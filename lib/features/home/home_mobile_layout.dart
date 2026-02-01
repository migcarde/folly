import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/bottom_bar/bottom_bar_notifier.dart';
import 'package:folly/features/bottom_bar/models/bottom_bar_state.dart';
import 'package:folly/features/feed/feed_mobile_layout.dart';
import 'package:folly/features/notifications/notifications_mobile_layout.dart';
import 'package:folly/features/profile/profile_mobile_layout.dart';
import 'package:folly/features/search_users/search_users_mobile_layout.dart';

class HomeMobileLayout extends ConsumerStatefulWidget {
  const HomeMobileLayout({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeMobileLayoutState();
}

class _HomeMobileLayoutState extends ConsumerState<HomeMobileLayout>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: BottomBarItem.values.length - 1,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(bottomBarNotifierProvider, (previous, next) {
      switch (next.selectedItem) {
        case BottomBarItem.home:
          _tabController.index = 0;
          break;
        case BottomBarItem.search:
          _tabController.index = 1;
        case BottomBarItem.updateStory:
          break;
        case BottomBarItem.notifications:
          _tabController.index = 2;
        case BottomBarItem.profile:
          _tabController.index = 3;
      }
    });

    return TabBarView(
      controller: _tabController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        FeedMobileLayout(),
        SearchUsersMobileLayout(),
        NotificationsMobileLayout(),
        ProfileMobileLayout(
          user: ref.watch(authNotifierProvider).user!,
          isCurrentUser: true,
        ),
      ],
    );
  }
}
