import 'package:flutter/material.dart';
import 'package:threads_app/models/post_model.dart';
import 'package:threads_app/services/post_service.dart';
import 'package:threads_app/widgets/thread_card_widget.dart';
import 'package:threads_app/widgets/thread_input_preview_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostService _postService = PostService();
  late Future<List<PostModel>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _postService.fetchPosts();
  }

  Future<void> _refreshPosts() async {
    setState(() {
      _postsFuture = _postService.fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshPosts,
        color: Colors.white,
        backgroundColor: Colors.grey[900],
        child: FutureBuilder<List<PostModel>>(
          future: _postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error loading posts: ${snapshot.error}",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }

            final posts = snapshot.data ?? [];

            if (posts.isEmpty) {
              return const Center(
                child: Text("No posts", style: TextStyle(color: Colors.white)),
              );
            }

            return ListView.builder(
              itemCount: posts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const ThreadInputPreviewWidget();
                }

                final post = posts[index - 1];

                return ThreadCardWidget(
                  userName: post.username,
                  content: post.text ?? "",
                  timeAgo: post.createdAt, 
                  replies: 0,
                  likes: 0,
                  avatarUrl: null,
                );
              },
            );
          },
        ),
      ),
    );
  }
}