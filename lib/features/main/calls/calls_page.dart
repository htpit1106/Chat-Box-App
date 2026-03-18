import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/widgets/app_bar/custom_appbar.dart';
import 'package:chatbox/core/widgets/app_scaffold.dart';
import 'package:chatbox/features/main/calls/calling/calling_screen.dart';
import 'package:chatbox/features/main/calls/widget/calls_items.dart';
import 'package:flutter/material.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CallsPageChild();
  }
}

class CallsPageChild extends StatefulWidget {
  const CallsPageChild({super.key});

  @override
  State<CallsPageChild> createState() => _CallsPageChildState();
}

class _CallsPageChildState extends State<CallsPageChild> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      header: _buildHeader(),
      body: _buildBody(),

    );
  }

  Widget _buildHeader() {
    return CustomAppbar(
      title: "Contacts",
      iconTrailing: AssetConstants.addFriendContact,
      // onPressSearcharch: () => _cubit.navigateToSearch(),
    );
  }

  Widget _buildBody(){
    return ListView(
      children: [
        CallItem(name: 'alec', time: 'today', avatarUrl: '')
      ],
    );
  }
}
