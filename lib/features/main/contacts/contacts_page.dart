import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/app_bar/custom_appbar.dart';
import 'package:chatbox/core/widgets/app_scaffold.dart';
import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/features/main/contacts/contacts_state.dart';
import 'package:chatbox/features/main/settings/widget/setting_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'contacts_cubit.dart';
import 'contacts_navigator.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactsCubit>(
      create: (context) => ContactsCubit(
        friendRepos: context.read(),
        navigator: ContactsNavigator(context: context),
      ),
      child: ContactsPageChild(),
    );
  }
}

class ContactsPageChild extends StatefulWidget {
  const ContactsPageChild({super.key});

  @override
  State<ContactsPageChild> createState() => _ContactsPageChildState();
}

class _ContactsPageChildState extends State<ContactsPageChild>
    with AutomaticKeepAliveClientMixin {
  late final ContactsCubit _cubit;

  @override
  void initState() {
    super.initState();

    _cubit = context.read<ContactsCubit>();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppScaffold(header: _buildHeader(), body: _buildBody());
  }

  Widget _buildHeader() {
    return CustomAppbar(
      title: "Contacts",
      iconTrailing: AssetConstants.addFriendContact,
      onPressSearch: () => _cubit.navigateToSearch(),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("My contact", style: AppTextStyle.black.s16),
        16.height,
        _buildListContact(),
      ],
    );
  }

  Widget _buildListContact() {
    return Expanded(
      child: BlocBuilder<ContactsCubit, ContactsState>(
        buildWhen: (previous, current) => previous.contacts != current.contacts,
        builder: (context, state) {
          final contacts = groupContacts(state.contacts);
          final letters = contacts.keys.toList();
          return CustomScrollView(
            slivers: [
              for (var letter in letters) ...[
                _buildSectionHeader(letter),
                _buildContactList(contacts[letter]!),
              ],
            ],
          );
        },
      ),
    );
  }

  Map<String, List<UserEntity>> groupContacts(List<UserEntity> contacts) {
    Map<String, List<UserEntity>> grouped = {};

    for (var contact in contacts) {
      if (contact.name == null) continue;
      String letter = contact.name![0].toUpperCase();
      if (!grouped.containsKey(letter)) {
        grouped[letter] = [];
      }
      grouped[letter]!.add(contact);
    }
    return grouped;
  }

  Widget _buildSectionHeader(String letter) {
    return SliverToBoxAdapter(
      child: Text(letter, style: AppTextStyle.black.s16.w500),
    );
  }

  Widget _buildContactList(List<UserEntity> contacts) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final contact = contacts[index];
        return SettingListItem(
          title: contact.name,
          subtitle: contact.email != null
              ? Text(
                  contact.email!,
                  style: AppTextStyle.gray.s12,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                )
              : null,
          icon: contact.avatarUrl,
          onTap: () {
            _cubit.navigateToFriendProfile(contact);
          },
        );
      }, childCount: contacts.length),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
