import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/theme/app_colors.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:chatbox/data/models/conversation/conversation_entity.dart';
import 'package:chatbox/features/main/home/widget/chat_item.dart';
import 'package:chatbox/features/main/home/widget/status_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_cubit.dart';
import 'home_navigator.dart';
import 'home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
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

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HomeCubit>();
    _cubit.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Column(
        spacing: 20,
        children: [
          _buildHeader(),
          Expanded(child: _buildListChats(context)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      child: Column(
        spacing: 20,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  _cubit.onPressSearch();
                },
                icon: AppAssetImage(
                  path: AssetConstants.search,
                  size: Size(44, 44),
                ),
              ),
              Text("Home", style: AppTextStyle.white.s20.w500),
              ClipRRect(
                borderRadius: 100.radius,
                child: AppAssetImage(
                  path: AssetConstants.onboardingBg,
                  size: Size(44, 44),
                ),
              ),
            ],
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
                      name: friend.name,
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
      ),
    );
  }

  Widget _buildListChats(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 2,
            child: VerticalDivider(color: AppColors.greyCD, thickness: 50),
          ),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  previous.chats != current.chats ||
                  previous.onlineFriends != current.onlineFriends,
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.chats.length,
                  itemBuilder: (context, index) {
                    final conversation = state.chats[index];
                    final friend = state.onlineFriends.firstWhere(
                      (element) => element.uid == conversation.lastSenderId,
                    );
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
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
