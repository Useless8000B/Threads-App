import 'package:flutter/material.dart';
import 'package:threads_app/colors.dart';
import 'package:threads_app/models/post_model.dart';
import 'package:threads_app/services/post_service.dart';
import 'package:threads_app/widgets/thread_card_widget.dart';
import 'package:threads_app/widgets/thread_input_preview_widget.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onNavigateToPost;
  const HomeScreen({super.key, required this.onNavigateToPost});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  final PostService _postService = PostService();
  late Future<List<PostModel>> _postsFuture;

  @override
  bool get wantKeepAlive => true;

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
    super.build(context);
    
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshPosts,
        color: AppColors.white,
        backgroundColor: Colors.grey[900],
        child: FutureBuilder<List<PostModel>>(
          future: _postsFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.white, strokeWidth: 2),
                );
              default:
                if (snapshot.hasError) {
                  return _buildError(snapshot.error.toString());
                }
                return _buildList(snapshot.data ?? []);
            }
          },
        ),
      ),
    );
  }

  Widget _buildList(List<PostModel> posts) {
    if (posts.isEmpty) {
      return const Center(child: Text("No posts", style: TextStyle(color: AppColors.white)));
    }

    return ListView.builder(
      cacheExtent: 1500, 
      itemCount: posts.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ThreadInputPreviewWidget(onTap: widget.onNavigateToPost);
        }

        final post = posts[index - 1];

        return ThreadCardWidget(
          key: ValueKey(post.id), 
          postId: post.id ?? '',
          userName: post.username,
          content: post.text ?? "",
          timeAgo: post.createdAt,
          avatarUrl: post.profilePic,
          onDelete: _refreshPosts,
        );
      },
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text("Error: $error", style: const TextStyle(color: Colors.redAccent)),
      ),
    );
  }
}