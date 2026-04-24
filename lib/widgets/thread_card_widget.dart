import 'package:flutter/material.dart';

class ThreadCardWidget extends StatelessWidget {
  final String userName;
  final String content;
  final String timeAgo;
  final String? imageUrl;
  final String? avatarUrl;
  final int replies;
  final int likes;

  const ThreadCardWidget({
    super.key,
    required this.userName,
    required this.content,
    required this.timeAgo,
    this.imageUrl,
    this.avatarUrl,
    this.replies = 0,
    this.likes = 0,
  });

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
                          Text(timeAgo, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          const SizedBox(width: 10),
                          const Icon(Icons.more_horiz, color: Colors.grey, size: 20),
                        ],
                      ),
                    ],
                  ),
                  Text(content, style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.3)),
                  if (imageUrl != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(imageUrl!, fit: BoxFit.cover),
                      ),
                    ),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      Icon(Icons.favorite_border, color: Colors.white, size: 22),
                      SizedBox(width: 16),
                      Icon(Icons.chat_bubble_outline, color: Colors.white, size: 22),
                      SizedBox(width: 16),
                      Icon(Icons.repeat, color: Colors.white, size: 22),
                      SizedBox(width: 16),
                      Icon(Icons.send_outlined, color: Colors.white, size: 22),
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