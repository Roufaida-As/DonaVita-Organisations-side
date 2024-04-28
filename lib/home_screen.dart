import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:secondapp/Theme/colors.dart';
import 'package:secondapp/chat%20work/chat_page.dart';
import 'package:secondapp/notifications%20work/notifications_page.dart';
import 'package:secondapp/profile%20work/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: AppColors.clear,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                    height: 35,
                    width: 60,
                    decoration: BoxDecoration(
                        color: _selectedIndex == 0
                            ? AppColors.highicons
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        shape: BoxShape.rectangle),
                    child: const Icon(
                      Icons.person_2_outlined,
                      color: AppColors.icons,
                      size: 27,
                    )),
              ),
              BottomNavigationBarItem(
                icon: Container(
                    height: 35,
                    width: 60,
                    decoration: BoxDecoration(
                        color: _selectedIndex == 1
                            ? AppColors.highicons
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        shape: BoxShape.rectangle),
                    child: const Icon(
                      Icons.chat_outlined,
                      color: AppColors.icons,
                      size: 27,
                    )),
              ),
              BottomNavigationBarItem(
                icon: Container(
                    height: 35,
                    width: 60,
                    decoration: BoxDecoration(
                        color: _selectedIndex == 2
                            ? AppColors.highicons
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        shape: BoxShape.rectangle),
                    child: const Icon(
                      Icons.notifications_active_outlined,
                      color: AppColors.icons,
                      size: 27,
                    )),
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoPageScaffold(child: _buildPage(index));
          }),
    );
  }
}

Widget _buildPage(int index) {
  switch (index) {
    case 0:
      return CupertinoTabView(builder: ((context) {
        return const CupertinoPageScaffold(child: ProfilePage());
      }));
    case 1:
      return CupertinoTabView(builder: ((context) {
        return const CupertinoPageScaffold(child: ChatPage());
      }));
    case 2:
      return CupertinoTabView(builder: ((context) {
        return const CupertinoPageScaffold(child: NotificationPage());
      }));
    default:
      return const SizedBox(); // Return an empty widget if index is out of bounds
  }
}
