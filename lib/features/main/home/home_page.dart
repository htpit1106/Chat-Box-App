import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/theme/app_colors.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:chatbox/features/main/home/widget/chat_item.dart';
import 'package:chatbox/features/main/home/widget/status_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_cubit.dart';
import 'home_navigator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(navigator: HomeNavigator(context: context)),
      child: HomePageChild(),
    );
  }
}

class HomePageChild extends StatefulWidget {
  const HomePageChild({super.key});

  @override
  State<HomePageChild> createState() => _HomePageChildState();
}

class _HomePageChildState extends State<HomePageChild> {
  late final HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HomeCubit>();
  }

  @override
  Widget build(BuildContext context) {
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
                icon: AppAssetImage(path: AssetConstants.search, size: Size(44, 44)),
              ),
              Text("Home", style: AppTextStyle.white.s20.w500),
              ClipRRect(
                  borderRadius: 100.radius,
                  child: AppAssetImage(path: AssetConstants.onboardingBg, size: Size(44, 44))),
            ],
          ),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [StatusItem(), StatusItem(), StatusItem(), StatusItem()],
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
            child: ListView(
              children: [
                ChatItem(onPressDelete: () {}, onPressNotification: () {}),
                ChatItem(
                  onTap: () {
                    _cubit.onPressItemChat();
                  },
                ),
                ChatItem(isOnline: false, onNotification: true),
                ChatItem(isOnline: false),
                ChatItem(),
                ChatItem(),
                ChatItem(isOnline: false),
                ChatItem(),
                ChatItem(isOnline: false),
                ChatItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
