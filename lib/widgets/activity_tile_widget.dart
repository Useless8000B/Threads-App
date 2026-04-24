import 'package:flutter/material.dart';

enum ActivityType { follow, like, reply, mention, request }

class ActivityTileWidget extends StatelessWidget {
  final String userName;
  final String timeAgo;
  final String content;
  final String? subContent;
  final String avatarUrl;
  final ActivityType type;

  const ActivityTileWidget({
    super.key,
    required this.userName,
    required this.timeAgo,
    required this.content,
    required this.avatarUrl,
    required this.type,
    this.subContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF1F1F1F), width: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: _getTypeColor(type),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Icon(_getTypeIcon(type), size: 10, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    children: [
                      TextSpan(text: userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const TextSpan(text: "  "),
                      TextSpan(text: timeAgo, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(color: Color(0xFF999999), fontSize: 14),
                ),
                if (subContent != null)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                      border: Border(left: BorderSide(color: Color(0xFF1F1F1F), width: 2)),
                    ),
                    child: Text(
                      subContent!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Color(0xFF666666), fontSize: 14),
                    ),
                  ),
              ],
            ),
          ),

          if (type == ActivityType.follow)
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF262626)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: const Text("Follow back", style: TextStyle(color: Colors.white, fontSize: 13)),
            ),
        ],
      ),
    );
  }

  Color _getTypeColor(ActivityType type) {
    switch (type) {
      case ActivityType.follow: return const Color(0xFF4C36ED);
      case ActivityType.like: return const Color(0xFFFF3040);
      case ActivityType.reply: return const Color(0xFF0095F6);
      case ActivityType.mention: return const Color(0xFF10B981);
      case ActivityType.request: return const Color(0xFF999999);
    }
  }

  IconData _getTypeIcon(ActivityType type) {
    switch (type) {
      case ActivityType.follow: return Icons.person;
      case ActivityType.like: return Icons.favorite;
      case ActivityType.reply: return Icons.chat_bubble;
      case ActivityType.mention: return Icons.alternate_email;
      case ActivityType.request: return Icons.lock;
    }
  }
}