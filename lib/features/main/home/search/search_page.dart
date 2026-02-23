import 'package:chatbox/core/widgets/app_bar/app_bar_widget.dart';
import 'package:chatbox/features/main/home/search/widget/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_cubit.dart';
import 'search_state.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) {
        return SearchCubit(
          userRepository: context.read(),
          friendRepository: context.read(),
        );
      },
      child: SearchPageChild(),
    );
  }
}

class SearchPageChild extends StatefulWidget {
  const SearchPageChild({super.key});

  @override
  State<SearchPageChild> createState() => _SearchPageChildState();
}

class _SearchPageChildState extends State<SearchPageChild> {
  late final SearchCubit _cubit;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SearchCubit>();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: _buildAppBar()),
      body: _buildListUsers(),
    );
  }

  Widget _buildAppBar() {
    return SizedBox(
      height: 35,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search by name or email',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: Icon(Icons.search, size: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.green, width: 1.5),
          ),

          isDense: true,
        ),
        controller: _searchController,
        onChanged: (value) {
          _cubit.searchUsers(value);
        },
      ),
    );
  }

  Widget _buildListUsers() {
    return BlocBuilder<SearchCubit, SearchState>(
      // buildWhen: (previous, current) => previous.listUsers != current.listUsers,
      builder: (context, state) {
        if (state.listNonFriend.isEmpty && state.listFriends.isEmpty) {
          return Center(child: Text('No data'));
        }
        return ListView.builder(
          itemCount: state.listNonFriend.length + state.listFriends.length,
          itemBuilder: (context, index) {
            if (index < state.listFriends.length) {
              final friend = state.listFriends[index];
              return UserItem(
                name: friend.name,
                email: friend.email,
                isFriend: true,
              );
            }
            final nonFriend =
                state.listNonFriend[index - state.listFriends.length];
            return UserItem(
              name: nonFriend.name,
              email: nonFriend.email,
              isFriend: false,
              onTap: () {
                // print("add friend");
                if (nonFriend.uid == null) return;
                _cubit.addFriend(nonFriend.uid!, _searchController.text);
              },
            );
          },
        );
      },
    );
  }
}
