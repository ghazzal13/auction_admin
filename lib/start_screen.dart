import 'package:auction_admin/cubit/cubit.dart';
import 'package:auction_admin/cubit/states.dart';
import 'package:auction_admin/home_screens/main_management_categories_screen.dart';
import 'package:auction_admin/home_screens/managment_clients_screen.dart';
import 'package:auction_admin/home_screens/mangement_post_screen.dart';
import 'package:auction_admin/home_screens/management_request_screen.dart';
import 'package:auction_admin/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  static const List<Widget> _widgetOptions = <Widget>[
    ManagmentClientsScreen(),
    RequestScreen(),
    ManagementPostScreen(),
    ManagementReportsScreen()
  ];
  void onselect(int x) {
    setState(() {
      AuctionCubit.get(context).onItemTapped(x);
    });
  }

  @override
  void initState() {
    super.initState();
    AuctionCubit.get(context).selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body:
              _widgetOptions.elementAt(AuctionCubit.get(context).selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: primaryColor,
                icon: Icon(Icons.person),
                label: 'Clients',
              ),
              BottomNavigationBarItem(
                backgroundColor: primaryColor,
                icon: Icon(Icons.request_quote_outlined),
                label: 'Requests',
              ),
              BottomNavigationBarItem(
                backgroundColor: primaryColor,
                icon: Icon(Icons.gif_box),
                label: 'Posts',
              ),
              BottomNavigationBarItem(
                backgroundColor: primaryColor,
                icon: Icon(Icons.report_gmailerrorred),
                label: 'Reports',
              ),
            ],
            currentIndex: AuctionCubit.get(context).selectedIndex,
            selectedItemColor: Colors.yellow,
            onTap: onselect,
            type: BottomNavigationBarType.fixed,
            backgroundColor: primaryColor,
            unselectedItemColor: Colors.white,
          ),
        );
      },
    );
  }
}
