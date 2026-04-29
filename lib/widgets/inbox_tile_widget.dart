import 'package:flutter/material.dart';

class InboxTileWidget extends StatelessWidget {
  final String userName;
  final String lastMessage;
  final String timeAgo;
  final bool isUnread;
  final String? avatarUrl;

  const InboxTileWidget({
    super.key,
    required this.userName,
    required this.lastMessage,
    required this.timeAgo,
    this.isUnread = false,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: _buildAvatar(),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                timeAgo,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isUnread ? Colors.white : Colors.grey,
                fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
          trailing: isUnread ? _buildUnreadDot() : null,
        ),
        const Divider(
          color: Color(0xFF1F1F1F),
          thickness: 0.5,
          indent: 80,
          height: 1,
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
          backgroundColor: const Color(0xFF1F1F1F),
          child: avatarUrl == null 
              ? const Icon(Icons.person, color: Colors.grey) 
              : null,
        ),
        if (isUnread)
          Positioned(
            right: 0,
            top: 0,
            child: _buildNotificationBadge(),
          ),
      ],
    );
  }

  Widget _buildNotificationBadge() {
    return Container(
      width: 14,
      height: 14,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const SizedBox(
        width: 8,
        height: 8,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xFF049AEB),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildUnreadDot() {
    return const SizedBox(
      width: 8,
      height: 8,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xFF049AEB),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}