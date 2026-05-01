import 'package:flutter/material.dart';
import 'package:threads_app/colors.dart';
import 'package:threads_app/widgets/activity_tile_widget.dart';

class LikedScreen extends StatelessWidget {
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> filters = ["All", "Replies", "Mentions", "Quotes", "Reposts", "Verified"];

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        cacheExtent: 1000, 
        slivers: [
          // 1. Optimized Filter Bar
          SliverToBoxAdapter(
            child: _buildFilterBar(filters),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _dummyData[index];
              },
              childCount: _dummyData.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(List<String> filters) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.grey_2, width: 0.5)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final isFirst = index == 0;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(filters[index]),
              selected: isFirst,
              onSelected: (_) {},
              labelStyle: TextStyle(
                color: isFirst ? Colors.black : const Color(0xFF999999),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              selectedColor: Colors.white,
              backgroundColor: const Color(0xFF121212),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isFirst ? Colors.white : AppColors.grey_2,
                ),
              ),
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }
}

const List<ActivityTileWidget> _dummyData = [
  ActivityTileWidget(
    userName: "marcus_dev",
    type: ActivityType.follow,
    timeAgo: "2h",
    content: "Followed you",
    avatarUrl: "https://api.dicebear.com/7.x/avataaars/svg?seed=Marcus",
  ),
  ActivityTileWidget(
    userName: "elena.designs",
    type: ActivityType.like,
    timeAgo: "4h",
    content: "Liked your thread",
    subContent: "The future of UI design is not about focus...",
    avatarUrl: "https://api.dicebear.com/7.x/avataaars/svg?seed=Elena",
  ),
  ActivityTileWidget(
    userName: "creative.sam",
    type: ActivityType.reply,
    timeAgo: "8h",
    content: "This is exactly what I needed to hear today!",
    avatarUrl: "https://api.dicebear.com/7.x/avataaars/svg?seed=Sam",
  ),
];