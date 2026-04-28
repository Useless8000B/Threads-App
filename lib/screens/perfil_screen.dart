import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threads_app/colors.dart';
import 'package:threads_app/models/post_model.dart';
import 'package:threads_app/services/auth_service.dart';
import 'package:threads_app/services/post_service.dart';
import 'package:threads_app/services/user_service.dart';
import 'package:threads_app/widgets/thread_card_widget.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final AuthService _authService = AuthService();
  final ImagePicker _picker = ImagePicker();
  final UserService _userService = UserService();
  late Future<Map<String, dynamic>?> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    final user = _authService.currentUser;
    if (user != null) {
      _userDataFuture = _authService.getUserData(user.uid);
    }
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _refreshData();
    });
    await _userDataFuture;
  }

  Future<void> _pickAndUploadImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.black,
          content: Text(
            "Sending photo...",
            style: TextStyle(color: AppColors.white),
          ),
        ),
      );

      bool success = await _userService.updateProfilePicture(image.path);
      if (success) _handleRefresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(
              child: Text(
                "Error loading profile",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final userData = snapshot.data!;
          final String name = userData['username'] ?? "username";
          final String profilePic = userData['photoUrl'] ?? "https://ui-avatars.com/api/?name=$name&background=333&color=fff";

          return DefaultTabController(
            length: 3,
            child: NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: _buildProfileHeader(userData, name, profilePic),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverTabBarDelegate(
                      const TabBar(
                        indicatorColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.white,
                        unselectedLabelColor: Color(0xFF999999),
                        tabs: [
                          Tab(text: "Threads"),
                          Tab(text: "Replies"),
                          Tab(text: "Reposts"),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  _buildThreadsTab(name, profilePic),
                  _buildEmptyTab("No replies yet"),
                  _buildEmptyTab("No reposts yet"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildThreadsTab(String name, String avatar) {
    return Builder(
      builder: (context) {
        return RefreshIndicator(
          onRefresh: _handleRefresh,
          color: Colors.white,
          backgroundColor: Colors.black,
          child: CustomScrollView(
            key: const PageStorageKey("threads"),
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
              ),
              FutureBuilder<List<PostModel>>(
                future: PostService().getPostsByUser(),
                builder: (context, postSnapshot) {
                  if (postSnapshot.connectionState == ConnectionState.waiting) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }

                  final posts = postSnapshot.data ?? [];
                  if (posts.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: Text(
                          "No posts",
                          style: TextStyle(color: Color(0xFF999999)),
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final post = posts[index];
                      return ThreadCardWidget(
                        userName: name,
                        content: post.text ?? "",
                        avatarUrl: avatar,
                        timeAgo: post.createdAt ?? DateTime.now(),
                      );
                    }, childCount: posts.length),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyTab(String message) {
    return Builder(
      builder: (context) {
        return RefreshIndicator(
          onRefresh: _handleRefresh,
          color: Colors.white,
          backgroundColor: Colors.black,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
              ),
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(
    Map<String, dynamic> userData,
    String name,
    String profilePic,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "@${name.toLowerCase()}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              GestureDetector(
                onTap: _pickAndUploadImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(profilePic),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: const Icon(
                          TablerIcons.camera,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            userData['bio'] ?? "No bio yet.",
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildProfileButton("Edit profile")),
              const SizedBox(width: 12),
              Expanded(child: _buildProfileButton("Share profile")),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildProfileButton(String label) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF1F1F1F)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this._tabBar);
  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.black, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) => false;
}
