import 'package:auction_admin/cubit/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('tradeitem').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('ConnectionState is waiting');
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                print('ConnectionState is has data');
              }
              if (snapshot.hasError) {
                print('ConnectionState is has error');
              }
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) => Container(
                  margin: const EdgeInsets.symmetric(
                      // horizontal: width > webScreenSize ? width * 0.3 : 0,
                      // vertical: width > webScreenSize ? 15 : 0,
                      ),
                  child: Usercard(
                    context: context,
                    snap: snapshot.data!.docs[index].data(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget Usercard({required dynamic snap, context}) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.black12,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.teal,
                      backgroundImage: NetworkImage(
                        snap['image'].toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snap['name'].toString(),
                      style: TextStyle(
                        color: Colors.teal[600],
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                        '${DateFormat.yMd().add_jm().format(snap['datePublished'].toDate())} '),
                  ],
                ),
                const Spacer(),
                PopupMenuButton(
                  onSelected: (value) {
                    if (value.toString() == '/delete') {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("Delete User"),
                          content: const Text(
                              "Are you sure you want to Delete This User?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'NO'),
                              child: const Text('NO'),
                            ),
                            TextButton(
                              onPressed: () {
                                AuctionCubit.get(context)
                                    .deletDoc('users', snap['uid'].toString());
                                Navigator.pop(context, 'YES');
                              },
                              child: const Text('YES'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  itemBuilder: (BuildContext bc) {
                    return const [
                      PopupMenuItem(
                        child: Text("delete"),
                        value: '/delete',
                      ),
                    ];
                  },
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snap['titel'].toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.teal[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  child: Text(
                    snap['description'].toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.teal[600],
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      snap['tradeItemImage'].toString(),
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
/*
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
*/