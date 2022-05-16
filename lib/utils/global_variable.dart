import 'package:auction_admin/home_screens/main_management_categories_screen.dart';
import 'package:auction_admin/posts_screens/management_post_online.dart';
import 'package:auction_admin/home_screens/managment_clients_screen.dart';
import 'package:auction_admin/home_screens/management_request_screen.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const ManagmentClientsScreen(),
  const RequestScreen(),
  const ManagmentPostOnlineScreen(),
  const ManagementReportsScreen(),
];
