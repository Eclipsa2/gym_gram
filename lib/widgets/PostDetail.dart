import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gym_gram/cards/PostCard.dart';

class PostDetail extends StatelessWidget {
  final post;
  const PostDetail({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent
      ),
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
        Navigator.pop(context);
      },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
            color: Colors.transparent,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
              child: Container(
                color: Colors.black.withOpacity(0.2), // Adjust the opacity of the background
              ),
            ),
          ),
            GestureDetector(
              onTap: () {
              // Handle tap on the page content
              // Add any specific behavior for the page content
            },
              child: Container(
                
                child: PostCard(
              uid: post['uid'],
              photoUrl: post['photoUrl'],
              workoutId: post['workoutId'],
              postId: post['postId'],
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
