import 'package:chatbox/core/widgets/button/nav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_cubit.dart';
import 'main_state.dart';
import 'main_tap.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (context) => MainCubit(),
      child: const MainTabChild(),
    );
  }
}

class MainTabChild extends StatefulWidget {
  const MainTabChild({super.key});

  @override
  State<MainTabChild> createState() => _MainTabChildState();
}

class _MainTabChildState extends State<MainTabChild> {
  late final List<Widget> _pagesList;
  late final MainCubit _cubit;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pagesList = MainTap.values.map((e) => e.page).toList();
    _cubit = context.read<MainCubit>();
    _pageController = PageController(initialPage: _cubit.state.currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      allowImplicitScrolling: false,
      onPageChanged: (index) {
        _cubit.changePage(index);
      },
      children: _pagesList,
    );
  }

  Widget _buildBottomNavigationBar() {
    return BlocConsumer<MainCubit, MainState>(
      buildWhen: (previous, current) =>
          previous.currentPage != current.currentPage,
      builder: (context, state) {
        return SizedBox(
          height: 90,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                for (final tap in MainTap.values)
                  Expanded(
                    child: NavButton(
                      iconPath: tap.iconPath,
                      text: tap.name,
                      isSelected: _cubit.state.currentPage == tap.index,
                      onTap: () {
                        _cubit.changePage(tap.index);
                        // print(tap.name);
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
      bloc: _cubit,
      listener: (context, state) {
        _pageController.jumpToPage(state.currentPage);
      },
    );
  }
}
