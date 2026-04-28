import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:threads_app/models/post_model.dart';
import 'package:threads_app/services/auth_service.dart';

class PostService {
  static const String _baseUrl = String.fromEnvironment("API_URL");
  static final AuthService _authService = AuthService();

  Future<bool> createPost(PostModel post) async {
    try {
      String? token = await FirebaseAuth.instance.currentUser?.getIdToken();

      final response = await http.post(
        Uri.parse("$_baseUrl/posts"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(post.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        print("Erro ao criar: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<PostModel>> fetchPosts() async {
    try {
      String? token = await FirebaseAuth.instance.currentUser?.getIdToken();

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse("$_baseUrl/posts"),
        headers: headers,
      );

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

  Future<List<PostModel>> getPostsByUser() async {
    try {
      final token = await _authService.token;

      if (token == null) {
        throw Exception("User not authenticated");
      }

      final response = await http.get(
        Uri.parse("$_baseUrl/posts/me"),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final String decodedBody = utf8.decode(response.bodyBytes);
        List<dynamic> body = jsonDecode(decodedBody);
        return body.map((item) => PostModel.fromJson(item)).toList();
      }

      return [];
    } catch (e) {
      return [];
    }
  }
}
