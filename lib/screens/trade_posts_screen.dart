import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TradePostsScreen extends StatefulWidget {
  const TradePostsScreen({Key? key}) : super(key: key);

  @override
  _TradePostsScreenState createState() => _TradePostsScreenState();
}

class _TradePostsScreenState extends State<TradePostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Trade Posts',
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
              margin: const EdgeInsets.only(bottom: 400),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.teal.withOpacity(0.2),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 150,
                              //margin: new EdgeInsets.fromLTRB(200,0,0,0),
                              // color: Colors.black87,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://i.pinimg.com/564x/70/f9/dd/70f9dd78e5d27729b98d74cdd4c78484.jpg"),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.teal,
                                            backgroundImage: NetworkImage(
                                                'https://as2.ftcdn.net/v2/jpg/00/65/77/27/1000_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg'),
                                          ),
                                        ),
                                        Text(
                                          'UserName',
                                          style: TextStyle(
                                            color: Colors.teal[600],
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      // alignment: Alignment.topLeft,
                                      //margin: EdgeInsets.fromLTRB(12,5,320,400),
                                      child: Text(
                                        'Item I Have',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.teal[600],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      child: const Text(
                                        'Category',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.teal,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    //margin: EdgeInsets.fromLTRB(12,5,320,400),
                                    child: Text(
                                      'Title',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.teal[600],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      //margin: EdgeInsets.fromLTRB(12,0,320,400),
                                      child: Text(
                                        'Data Data Data',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.teal[600],
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(180, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                primary: Colors.teal[500],
                              ),
                              child: Container(
                                //margin: EdgeInsets.all(8.0),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'halter',
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                showDialog();
                              },
                            ),
                          ),
                        ),
                      ),
                      //SizedBox(width: 30,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(180, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              primary: Colors.teal[500],
                            ),
                            child: Container(
                              // margin: EdgeInsets.all(8.0),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'halter',
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            onPressed: () {
                              ShowDialog();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Submit Post"),
          content: const Text("Are you sure you want to Submit This Post?"),
          actions: [
            CupertinoDialogAction(
                child: const Text("YES"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TradePostsScreen(),
                    ),
                  );
                }),
            CupertinoDialogAction(
              child: const Text("NO"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TradePostsScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void ShowDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Cancel Post"),
          content: const Text("Are you sure you want to Cancel This Post?"),
          actions: [
            CupertinoDialogAction(
                child: const Text("YES"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TradePostsScreen(),
                    ),
                  );
                }),
            CupertinoDialogAction(
              child: const Text("NO"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TradePostsScreen(),
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
