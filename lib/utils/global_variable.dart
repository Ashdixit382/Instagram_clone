import 'package:flutter/material.dart';
import 'package:instagram_flutter/Screen/add_post_screen.dart';
import 'package:instagram_flutter/Screen/feed_screen.dart';

const webscreensize = 600;

const homeScreenItem = [
  FeedScreen(),
  Center(
    child: Text('search'),
  ),
  AddPost(),
  Center(
    child: Text('notification'),
  ),
  Center(
    child: Text('profile'),
  ),
];
