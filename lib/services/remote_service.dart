import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bean_bar_v2/models/post.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<Post?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return postFromJson(json as String);
    } else {
      return null;
    }
  }
}