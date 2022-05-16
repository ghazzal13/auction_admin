import 'package:auction_admin/cubit/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManagmentPostOnlineScreen extends StatefulWidget {
  const ManagmentPostOnlineScreen({Key? key}) : super(key: key);

  @override
  _ManagmentPostOnlineScreenState createState() =>
      _ManagmentPostOnlineScreenState();
}

class _ManagmentPostOnlineScreenState extends State<ManagmentPostOnlineScreen> {
  bool sort = false;

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
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
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
                  child: PostCard3(
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

Widget PostCard3({
  required dynamic snap,
  context,
}) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 5,
      right: 5,
      top: 5,
    ),
    child: Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.teal.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Stack(
                    //   children: [
                    //     CircleAvatar(
                    //       radius: 20,
                    //       backgroundColor: Colors.teal,
                    //       backgroundImage: NetworkImage(
                    //         snap['image'].toString(),
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
                    PopupMenuButton(
                      onSelected: (value) {
                        if (value.toString() == '/Delete') {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('AlertDialog Title'),
                              content: const Text('AlertDialog description'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    AuctionCubit.get(context).deletDoc(
                                        'posts', snap['postId'].toString());
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (value.toString() == '/Edit') {}
                      },
                      itemBuilder: (BuildContext bc) {
                        return const [
                          PopupMenuItem(
                            child: Text("Delete"),
                            value: '/Delete',
                          ),
                          PopupMenuItem(
                            child: Text("Edit"),
                            value: '/Edit',
                          ),
                        ];
                      },
                    )
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     SizedBox(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           const SizedBox(
                //             height: 5,
                //           ),
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 snap['titel'].toString(),
                //                 style: TextStyle(
                //                   fontSize: 18,
                //                   color: Colors.teal[600],
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //             ],
                //           ),
                //           const SizedBox(
                //             height: 5,
                //           ),
                //           Container(
                //             alignment: Alignment.topLeft,
                //             child: Text(
                //                 ' ${DateFormat.yMd().add_jm().format(snap['startAuction'].toDate())}  '),
                //           ),
                //           const SizedBox(
                //             height: 5,
                //           ),
                //           SizedBox(
                //             child: Text(
                //               snap['description'].toString(),
                //               style: TextStyle(
                //                 fontSize: 12,
                //                 color: Colors.teal[600],
                //                 fontWeight: FontWeight.w600,
                //               ),
                //               maxLines: 5,
                //               overflow: TextOverflow.ellipsis,
                //             ),
                //           ),
                //           const SizedBox(
                //             height: 5,
                //           ),
                //           Text(
                //             snap['category'].toString(),
                //             style: const TextStyle(
                //               fontSize: 20,
                //               color: Colors.teal,
                //               fontWeight: FontWeight.w600,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     Container(
                //       width: 200,
                //       height: 200,
                //       decoration: BoxDecoration(
                //         image: DecorationImage(
                //             image: NetworkImage(
                //               snap['postImage'].toString(),
                //             ),
                //             fit: BoxFit.cover),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'accept',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
