import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class ThreadCardWidget extends StatelessWidget {
  final String userName;
  final String content;
  final DateTime? timeAgo;
  final String? avatarUrl;
  final int replies;
  final int likes;

  const ThreadCardWidget({
    super.key,
    required this.userName,
    required this.content,
    required this.timeAgo,
    this.avatarUrl,
    this.replies = 0,
    this.likes = 0,
  });

  String _formatTimeAgo(DateTime? dateTime) {
    if (dateTime == null) return '';
    final difference = DateTime.now().difference(dateTime);

    if (difference.inDays >= 7) {
      return '${(difference.inDays / 7).floor()}w';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays}d';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
                  backgroundColor: const Color(0xFF2A2A2A),
                  child: avatarUrl == null ? const Icon(Icons.person, color: Colors.white54) : null,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Container(width: 1.5, color: const Color(0xFF1F1F1F)),
                ),
                const SizedBox(height: 4),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(userName, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      Row(
                        children: [
                          Text(_formatTimeAgo(timeAgo), style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          const SizedBox(width: 10),
                          const Icon(TablerIcons.dots, color: Colors.grey, size: 20),
                        ],
                      ),
                    ],
                  ),
                  Text(content, style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.3)),

                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      Icon(TablerIcons.heart, color: Colors.white, size: 22),
                      SizedBox(width: 16),
                      Icon(TablerIcons.message, color: Colors.white, size: 22),
                      SizedBox(width: 16),
                      Icon(TablerIcons.repeat, color: Colors.white, size: 22),
                      SizedBox(width: 16),
                      Icon(TablerIcons.send_2, color: Colors.white, size: 22),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "$replies replies · $likes likes",
                      style: const TextStyle(color: Color(0xFF757575), fontSize: 13),
                    ),
                  ),
                  const Divider(color: Color(0xFF1F1F1F), height: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}