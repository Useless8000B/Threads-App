import 'package:flutter/material.dart';
import 'package:threads_app/services/auth_service.dart';
import 'package:threads_app/widgets/thread_card_widget.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final AuthService _authService = AuthService();
  
  late Future<Map<String, dynamic>?> _userDataFuture;

  @override
  void initState() {
    super.initState();
    final user = _authService.currentUser;
    if (user != null) {
      _userDataFuture = _authService.getUserData(user.uid);
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

          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text("Error loading profile", style: TextStyle(color: Colors.white)),
            );
          }

          final userData = snapshot.data!;
          final String name = userData['username'] ?? "username";
          final String handle = "@${userData['username']?.toLowerCase() ?? 'user'}";
          final String bio = userData['bio'] ?? "No bio yet.";
          final String profilePic = userData['photoUrl'] ?? "https://ui-avatars.com/api/?name=$name&background=333&color=fff";

          return DefaultTabController(
            length: 3,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Padding(
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
                                  Row(
                                    children: [
                                      Text(
                                        handle,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF121212),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          "threads.net",
                                          style: TextStyle(color: Color(0xFF999999), fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(profilePic),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            bio,
                            style: const TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          const SizedBox(height: 16),
                          const Row(
                            children: [
                              Text(
                                "0 followers",
                                style: TextStyle(color: Color(0xFF999999)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: _buildProfileButton("Edit profile"),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildProfileButton("Share profile"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
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
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 1,
                    itemBuilder: (context, index) => ThreadCardWidget(
                      userName: name,
                      content: 'Welcome to my dynamic profile!',
                      timeAgo: DateTime.now(),
                    ),
                  ),
                  const Center(child: Text("No replies yet", style: TextStyle(color: Colors.white))),
                  const Center(child: Text("No reposts yet", style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
          );
        },
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

  @override double get minExtent => _tabBar.preferredSize.height;
  @override double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.black, child: _tabBar);
  }

  @override bool shouldRebuild(_SliverTabBarDelegate oldDelegate) => false;
}