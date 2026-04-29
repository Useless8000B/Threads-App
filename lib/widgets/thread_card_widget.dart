import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:threads_app/colors.dart';
import 'package:threads_app/widgets/snackbar_utils.dart';
import 'package:threads_app/services/post_service.dart';

class ThreadCardWidget extends StatelessWidget {
  final String postId;
  final String userName;
  final String content;
  final DateTime? timeAgo;
  final String? avatarUrl;
  final int replies;
  final int likes;
  final VoidCallback? onDelete;

  const ThreadCardWidget({
    super.key,
    required this.postId,
    required this.userName,
    required this.content,
    required this.timeAgo,
    this.avatarUrl,
    this.replies = 0,
    this.likes = 0,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildThreadGutter(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                ThreadActions(initialLikes: likes),
                const Divider(color: Color(0xFF1F1F1F), height: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreadGutter() {
    return SizedBox(
      width: 40,
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
            backgroundColor: const Color(0xFF2A2A2A),
            child: avatarUrl == null
                ? const Icon(Icons.person, color: Colors.white54)
                : null,
          ),
          const SizedBox(height: 8),
          Container(
            width: 1.5,
            height: 40,
            color: const Color(0xFF1F1F1F),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          userName,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Row(
          children: [
            Text(
              _formatTimeAgo(timeAgo),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(width: 10),
            _buildPopupMenu(context),
          ],
        ),
      ],
    );
  }

  Widget _buildPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(TablerIcons.dots, color: Colors.grey, size: 20),
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) => _handleMenuSelection(context, value),
      itemBuilder: (context) => [
        _buildMenuItem('delete', Icons.delete_outline, 'Delete', Colors.redAccent),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem(String val, IconData icon, String text, Color color) {
    return PopupMenuItem(
      value: val,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 12),
          Text(text, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  void _handleMenuSelection(BuildContext context, String value) async {
    if (value == 'delete') {
      final confirm = await _showDeleteDialog(context);
      if (confirm == true) {
        final success = await PostService().deletePost(postId);
        if (success) {
          onDelete?.call();
        } else {
          SnackbarUtils.showError(context, "You can only delete your own posts.");
        }
      }
    }
  }

  Future<bool?> _showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF181818),
        title: const Text("Delete post?", style: TextStyle(color: Colors.white)),
        content: const Text("This action cannot be undone.", style: TextStyle(color: Colors.grey)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text("Delete", style: TextStyle(color: Colors.redAccent))),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime? dateTime) {
    if (dateTime == null) return '';
    final diff = DateTime.now().difference(dateTime);
    if (diff.inDays >= 7) return '${(diff.inDays / 7).floor()}w';
    if (diff.inDays >= 1) return '${diff.inDays}d';
    if (diff.inHours >= 1) return '${diff.inHours}h';
    if (diff.inMinutes >= 1) return '${diff.inMinutes}m';
    return 'now';
  }
}

class ThreadActions extends StatefulWidget {
  final int initialLikes;
  const ThreadActions({super.key, required this.initialLikes});

  @override
  State<ThreadActions> createState() => _ThreadActionsState();
}

class _ThreadActionsState extends State<ThreadActions> {
  bool isLiked = false;
  late int likesCount;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    likesCount = widget.initialLikes;
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      isLiked ? likesCount++ : likesCount--;
      _scale = 1.3;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) setState(() => _scale = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: _toggleLike,
              child: RepaintBoundary(
                child: AnimatedScale(
                  scale: _scale,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                  child: Icon(
                    isLiked ? TablerIcons.heart_filled : TablerIcons.heart,
                    color: isLiked ? Colors.red : Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            const Icon(TablerIcons.message, color: AppColors.white, size: 22),
            const SizedBox(width: 16),
            const Icon(TablerIcons.repeat, color: AppColors.white, size: 22),
            const SizedBox(width: 16),
            const Icon(TablerIcons.send_2, color: AppColors.white, size: 22),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "0 replies · $likesCount likes",
          style: const TextStyle(color: Color(0xFF757575), fontSize: 13),
        ),
      ],
    );
  }
}