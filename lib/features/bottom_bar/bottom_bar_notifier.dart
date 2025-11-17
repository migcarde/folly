import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/features/bottom_bar/models/bottom_bar_state.dart';

class BottomBarNotifier extends StateNotifier<BottomBarState> {
  BottomBarNotifier() : super(const BottomBarState());

  void selectItem(BottomBarItem item) =>
      state = state.copyWith(selectedItem: item);
}

final bottomBarNotifierProvider =
    StateNotifierProvider.autoDispose<BottomBarNotifier, BottomBarState>(
      (ref) => BottomBarNotifier(),
    );
