import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:threads_app/models/post_model.dart';

class PostService {
  static const String _baseUrl = String.fromEnvironment('API_URL');

  Future<bool> createPost(PostModel post) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(post.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception("Backend error (${response.statusCode}): ${response.body}");
      }
    } catch (e) {
      throw Exception("Connection failed: $e");
    }
  }

  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((item) => PostModel.fromJson(item)).toList();
      } else {
        throw Exception("Couldn't load posts");
      }
    } catch (e) {
      throw Exception("Error retrieving posts");
    }
  }
}