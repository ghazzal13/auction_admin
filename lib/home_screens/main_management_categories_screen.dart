import 'package:auction_admin/screens/management_categories_screen.dart';
import 'package:flutter/material.dart';

class ManagementReportsScreen extends StatefulWidget {
  const ManagementReportsScreen({Key? key}) : super(key: key);

  @override
  State<ManagementReportsScreen> createState() =>
      _ManagementReportsScreenState();
}

class _ManagementReportsScreenState extends State<ManagementReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: const Text(
          'Managment Reports',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/BackGround.jpg'),
        )),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(bottom: 520),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.96,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.teal.withOpacity(0.3),
                              ),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.teal,
                                      backgroundImage: NetworkImage(
                                          'https://as2.ftcdn.net/v2/jpg/00/65/77/27/1000_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg'),
                                    ),
                                  ),
                                  Text(
                                    'Name Categories',
                                    style: TextStyle(
                                      color: Colors.teal[600],
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.delete_forever_rounded,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ManagementCategoriesSxreen(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/* 

class MainManagementCategoriesScreen extends StatefulWidget {
  const MainManagementCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<MainManagementCategoriesScreen> createState() =>
      _MainManagementCategoriesScreenState();
}

class _MainManagementCategoriesScreenState
    extends State<MainManagementCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: const Text(
          'Managment Categories',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/BackGround.jpg'),
        )),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(bottom: 520),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.96,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.teal.withOpacity(0.3),
                              ),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.teal,
                                      backgroundImage: NetworkImage(
                                          'https://as2.ftcdn.net/v2/jpg/00/65/77/27/1000_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg'),
                                    ),
                                  ),
                                  Text(
                                    'Name Categories',
                                    style: TextStyle(
                                      color: Colors.teal[600],
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      ShowDialog();
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever_rounded,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ManagementCategoriesSxreen(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void ShowDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Delete User"),
          content: const Text("Are you sure you want to Delete This User?"),
          actions: [
            CupertinoDialogAction(
                child: const Text("YES"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const MainManagementCategoriesScreen(),
                    ),
                  );
                }),
            CupertinoDialogAction(
              child: const Text("NO"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MainManagementCategoriesScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
*/