import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/view_model/services/session_controller.dart';

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  String username = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: StreamBuilder(
              stream: ref.child(SessionController().userId.toString()).onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  print(SessionController().userId.toString);
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                  username = map['username'];
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Colors.black,
                        ],
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 16.0,
                            ),
                            child: Text(
                              'Welcome back,',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 0.0,
                            ),
                            child: Text(
                              '$username',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 48.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32.0),
                                  topRight: Radius.circular(32.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 16.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Your feed',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    Expanded(
                                        child: FirebaseAnimatedList(
                                            query: ref,
                                            itemBuilder: (context, snapshot,
                                                animation, index) {
                                              if (SessionController()
                                                      .userId
                                                      .toString() ==
                                                  snapshot.child('uid')) {
                                                return Container();
                                              } else {
                                                return Card(
                                                  child: ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(snapshot
                                                              .child('profile')
                                                              .value
                                                              .toString()),
                                                    ),
                                                    title: Text(snapshot
                                                        .child('username')
                                                        .value
                                                        .toString()),
                                                    subtitle: Text(snapshot
                                                        .child('email')
                                                        .value
                                                        .toString()),
                                                  ),
                                                );
                                              }
                                            })),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                      child: Text('Something Went Wrong',
                          style: Theme.of(context).textTheme.subtitle1));
                }
              },
            )),
        // child: FirebaseAnimatedList(
        //     query: ref,
        //     itemBuilder: (context, snapshot, animation, index) {
        //       if (SessionController().userId.toString() ==
        //           snapshot.child('uid')) {
        //         return Container();
        //       } else {
        //         return Container(
        //           decoration: const BoxDecoration(
        //             gradient: LinearGradient(
        //               begin: Alignment.topLeft,
        //               end: Alignment.bottomRight,
        //               colors: [
        //                 Colors.white,
        //                 Colors.black,
        //               ],
        //             ),
        //           ),
        //           child: SafeArea(
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 const Padding(
        //                   padding: EdgeInsets.symmetric(
        //                     horizontal: 24.0,
        //                     vertical: 16.0,
        //                   ),
        //                   child: Text(
        //                     'Welcome back,',
        //                     style: TextStyle(
        //                       color: Colors.white,
        //                       fontSize: 24.0,
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: EdgeInsets.symmetric(
        //                     horizontal: 24.0,
        //                     vertical: 0.0,
        //                   ),
        //                   child: Text(
        //                     'Username',
        //                     style: TextStyle(
        //                       color: Colors.white,
        //                       fontSize: 48.0,
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                 ),
        //                 const SizedBox(
        //                   height: 16.0,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         );
        //         // return Card(
        //         //   child: ListTile(
        //         //     leading: CircleAvatar(
        //         //       backgroundImage: NetworkImage(
        //         //           snapshot.child('profile').value.toString()),
        //         //     ),
        //         //     title: Text(snapshot.child('username').value.toString()),
        //         //     subtitle: Text(snapshot.child('email').value.toString()),
        //         //   ),
        //         // );
        //       }
        //     }),
      ),
    );
  }
}
