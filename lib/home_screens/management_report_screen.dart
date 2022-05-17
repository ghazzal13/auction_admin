import 'package:auction_admin/cubit/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('report')
                .where('cancelReport', isEqualTo: false)
                .snapshots(),
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
                  child: reportCard(
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

Widget reportCard({required dynamic snap, context}) {
  if (snap['reportType'].toString() == 'online') {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.teal,
                        backgroundImage: NetworkImage(
                          snap['postUserimage'].toString(),
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
                        snap['postUsername'].toString(),
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
                                  AuctionCubit.get(context).deletDoc(
                                      'users', snap['postUseruid'].toString());
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
              const SizedBox(
                height: 10,
              ),
              const Text(
                ' Rrport :',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
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
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text("Delete User"),
                                    content: const Text(
                                        "Are you sure you want to Delete This User?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'NO'),
                                        child: const Text('NO'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          AuctionCubit.get(context).deletDoc(
                                              'users', snap['uid'].toString());
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
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          child: Text(
                            snap['reportText'].toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.teal[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          AuctionCubit.get(context).cancelReport(
                              postId: snap['reportId'].toString(),
                              colection: 'report');
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Cancel Report',
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
                        onPressed: () {
                          AuctionCubit.get(context)
                              .cancelReport(
                                  postId: snap['reportId'].toString(),
                                  colection: 'report')
                              .then((value) => AuctionCubit.get(context)
                                  .deletDoc(
                                      'posts', snap['postId'].toString()));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Delete Post',
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
        ),
      ),
    );
  }
  if (snap['reportType'].toString() == 'offline') {
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.teal,
                        backgroundImage: NetworkImage(
                          snap['postUserimage'].toString(),
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
                        snap['postUsername'].toString(),
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
                                  AuctionCubit.get(context).deletDoc(
                                      'users', snap['postUseruid'].toString());
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
                      Text(
                        snap['address'].toString(),
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
                  // Container(
                  //   alignment: Alignment.topLeft,
                  //   child: Text(
                  //       ' ${DateFormat.yMd().add_jm().format(snap['startAuction'].toDate())}  '),
                  // ),
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
                        snap['ticketImage'].toString(),
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                ' Rrport: ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
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
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text("Delete User"),
                                    content: const Text(
                                        "Are you sure you want to Delete This User?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'NO'),
                                        child: const Text('NO'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          AuctionCubit.get(context).deletDoc(
                                              'users', snap['uid'].toString());
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
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          child: Text(
                            snap['reportText'].toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.teal[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          AuctionCubit.get(context).cancelPost(
                              postId: snap['ticketId'].toString(),
                              colection: 'tickets');
                        },
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
                        onPressed: () {
                          AuctionCubit.get(context).acceptPost(
                              postId: snap['ticketId'].toString(),
                              colection: 'tickets');
                        },
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
        ),
      ),
    );
  }
  if (snap['reportType'].toString() == 'trade') {
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.teal,
                        backgroundImage: NetworkImage(
                          snap['postUserimage'].toString(),
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
                        snap['postUsername'].toString(),
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
                                  AuctionCubit.get(context).deletDoc(
                                      'users', snap['postUseruid'].toString());
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
              const SizedBox(
                height: 10,
              ),
              const Text(
                ' Rrport: ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
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
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text("Delete User"),
                                    content: const Text(
                                        "Are you sure you want to Delete This User?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'NO'),
                                        child: const Text('NO'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          AuctionCubit.get(context).deletDoc(
                                              'users', snap['uid'].toString());
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
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          child: Text(
                            snap['reportText'].toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.teal[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
                            'Delete Post',
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
        ),
      ),
    );
  }
  if (snap['reportType'].toString() == 'comment') {}
  return Container();
}
