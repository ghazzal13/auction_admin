import 'package:auction_admin/posts_screens/management_post_trade.dart';
import 'package:flutter/material.dart';

import 'package:auction_admin/posts_screens/management_post_online.dart';

import '../posts_screens/management_post_offline.dart';

class ManagementPostScreen extends StatefulWidget {
  const ManagementPostScreen({Key? key}) : super(key: key);

  @override
  _ManagementPostScreenState createState() => _ManagementPostScreenState();
}

class _ManagementPostScreenState extends State<ManagementPostScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal,
          title: const Text(
            'Management Posts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
              unselectedLabelColor: Colors.green.shade300,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.teal.shade300, Colors.tealAccent.shade400]),
                borderRadius: BorderRadius.circular(30),
                // color: Colors.teal.shade200,
              ),
              tabs: [
                Container(
                    decoration: (BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white10, width: 1),
                    )),
                    alignment: Alignment.center,
                    child: const Tab(
                      text: ('Online Auction'),
                    )),
                Container(
                    decoration: (BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white10, width: 1),
                    )),
                    alignment: Alignment.center,
                    child: const Tab(
                      text: ('Offline Auction'),
                    )),
                Container(
                    decoration: (BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white10, width: 1),
                    )),
                    alignment: Alignment.center,
                    child: const Tab(
                      text: ('Trade'),
                    )),
              ]),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/BackGround.jpg'),
          )),
          child: const Center(
            child: TabBarView(children: [
              ManagmentPostOnlineScreen(),
              ManagmentPostOfflineScreen(),
              ManagmentPostTradeScreen(),
            ]),
          ),
        ),
      ),
    );
  }
}
