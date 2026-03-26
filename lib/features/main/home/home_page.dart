import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:chatbox/core/utils/string.utils.dart';
import 'package:chatbox/core/widgets/app_bar/custom_appbar.dart';
import 'package:chatbox/core/widgets/app_scaffold.dart';
import 'package:chatbox/core/widgets/loading/app_refresher.dart';
import 'package:chatbox/data/models/entity/conversation_entity.dart';
import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/features/main/home/widget/chat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_cubit.dart';
import 'home_navigator.dart';
import 'home_state.dart';
import 'widget/status_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) =>
          HomeCubit(
            navigator: HomeNavigator(context: context),
            friendRepository: context.read(),
            conversationRepos: context.read(),
          ),
      child: HomePageChild(),
    );
  }
}

class HomePageChild extends StatefulWidget {
  const HomePageChild({super.key});

  @override
  State<HomePageChild> createState() => _HomePageChildState();
}

class _HomePageChildState extends State<HomePageChild>
    with AutomaticKeepAliveClientMixin {
  late final HomeCubit _cubit;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HomeCubit>();
    _cubit.fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppRefresher(
      controller: _refreshController,
      enablePullUP: false,
      onRefresh: () async {
        _cubit.fetchData();
      },
      child: AppScaffold(
        header: _buildHeader(),
        body: _buildListChats(context),
      ),
    );
  }

  Widget _buildHeader() {
    return BlocSelector<AppCubit, AppState, UserEntity?>(
      selector: (state) => state.currentUser,
      builder: (context, currentUser) {
        return Column(
          spacing: 10,
          children: [
            CustomAppbar(
              title: "Home",
              iconTrailing: currentUser?.avatarUrl,
              onPressSearch: () {
                _cubit.onPressSearch();
              },
              onPressTrailing: () {
                _cubit.onPressAvt(currentUser!);
              },
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: BlocBuilder<HomeCubit, HomeState>(
                buildWhen: (previous, current) =>
                previous.onlineFriends != current.onlineFriends,
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.onlineFriends.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final friend = state.onlineFriends[index];
                      return StatusItem(
                        iconPath: friend.avatarUrl,
                        name: StringUtils.getLastName(friend.name),
                        onTap: () {
                          if (friend.uid == null) return;
                          final conversation = ConversationEntity(
                            memberIds: [friend.uid!],
                            lastMessageAt: DateTime.now(),
                            lastSenderId: friend.uid,
                            isGroup: false,
                          );
                          _cubit.onPressItemChat(conversation, friend);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildListChats(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
      previous.chats != current.chats ||
          previous.onlineFriends != current.onlineFriends,
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.chats.length,
          itemBuilder: (context, index) {
            final conversation = state.chats[index];
            final friend = state.onlineFriends.firstWhere((element) {
              if (conversation.memberIds == null) return false;
              return conversation.memberIds!.contains(element.uid);
            });
            return ChatItem(
              name: friend.name,
              avatar: friend.avatarUrl,
              lastMessage: conversation.lastMessage,
              isOnline: true,
              onTap: () {
                _cubit.onPressItemChat(conversation, friend);
              },
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
