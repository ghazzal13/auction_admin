import 'package:auction_admin/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubit/cubit.dart';

class UserProfileScreen extends StatefulWidget {
  final String name;
  final String id;
  const UserProfileScreen({Key? key, required this.name, required this.id})
      : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState(
        name: name,
        id: id,
      );
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  _UserProfileScreenState({
    required this.name,
    required this.id,
  });
  String name;
  String id;
  @override
  void initState() {
    super.initState();
    AuctionCubit.get(context).getUserProfile(id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuctionCubit, AuctionStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // var userModel = AuctionCubit.get(context).model;
          var userModel = AuctionCubit.get(context).usermodel;

          return Scaffold(
            appBar: AppBar(
              // automaticallyImplyLeading: false,
              backgroundColor: Colors.teal,
              title: Text(
                name,
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/BackGround.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Container(
                            height: 70.0,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  4.0,
                                ),
                                topRight: Radius.circular(
                                  4.0,
                                ),
                              ),
                            ),
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        CircleAvatar(
                          radius: 64.0,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: NetworkImage(
                              '${userModel.image}',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      '${userModel.name}',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '${userModel.email}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: 2000,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('posts')
                            .where('uid', isEqualTo: id)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (ctx, index) => Container(
                              child: Usercard(
                                context: context,
                                snap: snapshot.data!.docs[index].data(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
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
                        '${DateFormat.yMd().add_jm().format(snap['postTime'].toDate())} '),
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
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                      ' ${DateFormat.yMd().add_jm().format(snap['startAuction'].toDate())}  '),
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
                Text(
                  snap['category'].toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  snap['price'].toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      snap['postImage'].toString(),
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
