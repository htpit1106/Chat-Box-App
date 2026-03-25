import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/app_bar/custom_appbar.dart';
import 'package:chatbox/core/widgets/app_scaffold.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:chatbox/data/models/enum/call_type.dart';
import 'package:chatbox/features/main/calls/calls_cubit.dart';
import 'package:chatbox/features/main/settings/widget/setting_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'calls_state.dart';

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
  late final CallsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<CallsCubit>()..loadCalls();
    _cubit.loadCalls();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(header: _buildHeader(), body: _buildBody());
  }

  Widget _buildHeader() {
    return CustomAppbar(
      title: "Calls",
      iconTrailing: AssetConstants.addFriendContact,
      // onPressSearcharch: () => _cubit.navigateToSearch(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CallsCubit, CallsState>(
      buildWhen: (previous, current) => current.calls != previous.calls,
      builder: (context, state) {
        final calls = state.calls;
        if (calls.isEmpty) {
          return const Center(child: Text("No calls"));
        }
        return ListView.builder(
          itemCount: calls.length,
          itemBuilder: (context, index) {
            final call = calls[index];
            return SettingListItem(
              iconSize: Size(50, 50),
              title: "phuong hoang thi",
              subtitle: Wrap(
                children: [
                  AppAssetImage(
                    path: CallTypeExt.callTypeString(call.status).icon,
                  ),
                  4.width,
                  Text("today", style: AppTextStyle.gray.s12),
                ],
              ),
              trailing: Wrap(
                children: [
                  IconButton(
                    icon: const Icon(Icons.call_outlined),
                    color: Colors.grey,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.videocam_outlined),
                    color: Colors.grey,
                    onPressed: () {},
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
