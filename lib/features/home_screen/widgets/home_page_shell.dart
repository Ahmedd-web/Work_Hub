// Shell layout for the job-seeker home page (tabs + bottom navigation).
import 'package:flutter/material.dart';
import 'package:work_hub/generated/l10n.dart';

class HomePageShell extends StatelessWidget {
  const HomePageShell({
    super.key,
    required this.homeTab,
    required this.jobsTab,
    required this.savedTab,
    required this.profileTab,
    required this.selectedTab,
    required this.onTabChanged,
    required this.s,
  });

  final Widget homeTab;
  final Widget jobsTab;
  final Widget savedTab;
  final Widget profileTab;
  final int selectedTab;
  final ValueChanged<int> onTabChanged;
  final S s;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: selectedTab,
          children: [homeTab, jobsTab, savedTab, profileTab],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        onTap: onTabChanged,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: s.navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.work_outline),
            activeIcon: const Icon(Icons.work),
            label: s.navJobs,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bookmark_border),
            activeIcon: const Icon(Icons.bookmark),
            label: s.navSaved,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: s.navProfile,
          ),
        ],
      ),
    );
  }
}
