import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/bottom_bar/bottom_bar_mobile_layout.dart';
import 'package:folly/features/home/home_mobile_layout.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(child: HomeMobileLayout()),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomBarMobileLayout(),
          ),
        ],
      ),
    );
  }
}
