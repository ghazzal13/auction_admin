import 'package:auction_admin/cubit/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/user_profile_screen.dart';

class ManagmentClientsScreen extends StatefulWidget {
  const ManagmentClientsScreen({Key? key}) : super(key: key);

  @override
  State<ManagmentClientsScreen> createState() => _ManagmentClientsScreenState();
}

class _ManagmentClientsScreenState extends State<ManagmentClientsScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: const Text(
          'Managment Users',
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
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
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
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfileScreen(
            name: snap['name'].toString(),
            id: snap['uid'].toString(),
          ),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.black12,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
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
                // Text(
                //     '${DateFormat.yMd().add_jm().format(snap['postTime'].toDate())} '),
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
                            print(snap['uid'].toString());
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
          ]),
        ),
      ),
    ),
  );
}
