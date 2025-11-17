import 'package:equatable/equatable.dart';

enum BottomBarItem {
  home,
  search,
  updateStory,
  notifications,
  profile;

  bool get isHome => this == BottomBarItem.home;
  bool get isSearch => this == BottomBarItem.search;
  bool get isUpdateStory => this == BottomBarItem.updateStory;
  bool get isNotifications => this == BottomBarItem.notifications;
  bool get isProfile => this == BottomBarItem.profile;
}

class BottomBarState extends Equatable {
  final BottomBarItem selectedItem;

  const BottomBarState({this.selectedItem = BottomBarItem.home});

  @override
  List<Object> get props => [selectedItem];

  BottomBarState copyWith({BottomBarItem? selectedItem}) {
    return BottomBarState(selectedItem: selectedItem ?? this.selectedItem);
  }
}
