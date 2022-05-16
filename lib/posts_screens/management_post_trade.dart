import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManagmentPostTradeScreen extends StatefulWidget {
  const ManagmentPostTradeScreen({Key? key}) : super(key: key);

  @override
  _ManagmentPostTradeScreenState createState() =>
      _ManagmentPostTradeScreenState();
}

class _ManagmentPostTradeScreenState extends State<ManagmentPostTradeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/BackGround.jpg'),
        )),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 580),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 60,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.teal.withOpacity(0.3),
                                  ),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.teal,
                                              backgroundImage: NetworkImage(
                                                  'https://as2.ftcdn.net/v2/jpg/00/65/77/27/1000_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: const Text(
                                          'Product Name',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.edit_outlined,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ShowDialog();
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
          title: const Text("Delete Post"),
          content: const Text("Are you sure you want to Delete This Post?"),
          actions: [
            CupertinoDialogAction(
                child: const Text("YES"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ManagmentPostTradeScreen(),
                    ),
                  );
                }),
            CupertinoDialogAction(
              child: const Text("NO"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManagmentPostTradeScreen(),
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
