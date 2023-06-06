import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_gram/widgets/UserProfileScreen.dart';

import 'MyProfileScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool showUsers = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container( 
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg2.png'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            title: TextFormField(
              onTap: () => setState(() {
                showUsers = false;
              }),
              decoration: const InputDecoration(
                labelText: 'Search for a user',
              ),
              controller: searchController,
              onFieldSubmitted: (String _) {
                print(searchController.text);
                setState(() {
                  showUsers = true;
                });
              },
            ),
            backgroundColor: Colors.transparent,
          ),
          body: showUsers == false
              ? Container()
              : FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .where('username',
                          isGreaterThanOrEqualTo:
                              searchController.text.toUpperCase())
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const LinearProgressIndicator(
                        color: Colors.orange,
                      );
                    }

                    return ListView.builder(
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () async {
                              FirebaseAuth.instance.currentUser!.uid !=
                                      (snapshot.data! as dynamic).docs[index]
                                          ['uid']
                                  ? await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserProfile(
                                              uid: (snapshot.data! as dynamic)
                                                  .docs[index]['uid'])),
                                    )
                                  : await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyProfile(
                                              uid: (snapshot.data! as dynamic)
                                                  .docs[index]['uid'])),
                                    );
                            },
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['photoUrl']),
                            ),
                            title: Text((snapshot.data! as dynamic).docs[index]
                                ['username']),
                          );
                        });
                  }),
        ),
      ],
    );
  }
}
