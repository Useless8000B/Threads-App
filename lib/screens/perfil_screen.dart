import 'package:flutter/material.dart';
import 'package:threads_app/widgets/thread_card_widget.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DefaultTabController(
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
                              const Text(
                                "Zé Preto",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Text(
                                    "zé_void",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF121212),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      "threads.net",
                                      style: TextStyle(
                                        color: Color(0xFF999999),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuAj9KOZaX9wydvreWL9_zoAfVkgqKqlPKZbZrdPHbeoZuL6GcDYk42P7vb3PwuFsrAeX_WxCebqXvlML9rqY2mDik5C26trM53Mrz973jMAWadjf-bkVMLftXxI9LdYp3QlDBMEud2V8JTYiPCc9klkMIu8y1kAqViy3dXd6zW2Qp-hpbR7orHy3Nz68PRnPaB6dFzjNk7ZVt-Jr4yq6n4tTSXVxVxIstz9PTxG0KKD7X4jCjQc14veLY8hGuo2HZax6uzrfJ517a4",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Bio
                      const Text(
                        "Building minimalist interfaces at the intersection of void and function. Focusing on the beauty of the unspoken.",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const SizedBox(
                            width: 35,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundImage: NetworkImage(
                                    "https://lh3.googleusercontent.com/aida-public/AB6AXuCGYnp2NunFEignzx_9JHU-nifZFxRgQdGF_uixIx12LYPQReZ3JrSByzotcaIppxa2CEl61Hegam0P7j9TSsNKSxxd1IyYC7XQ7Tj9glqouW8GpyKGFjZEZgNAcElykD6AYkq2KcZm4Zw605H_aiPlW7QdiOKUjOcA_1K7Y1bc-dhdYO9a1z0_e-jwl7sm5vzzi2yV72_Ra8djiF6yYK5ufnFKwnH4KRiDMteohyKQvNRRuACRGGiK-spf_6NNBS3UfO8s5KT2MzI",
                                  ),
                                ),
                                Positioned(
                                  left: 12,
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundImage: NetworkImage(
                                      "https://lh3.googleusercontent.com/aida-public/AB6AXuDM09zuEb8b0zosVEmcbwphJNqZKC8C3hvQAI6V0F0Ttv2PFrOyVE4mZNj2puRu3EnkMy6nPmKVbp0Of_cqxvoUWU8Fz_sY_NYxgVHH2XlgUTlBNz1XtWkxe529GfsecdV3lDKEci1OeLHmHurKpL7kmJSI29NtZlQxxRP7sUgAjjMB13ghRz6CU-ijv110ya8oc-Iji_NickAA1ih3KvGVm0T3jbgPL8pgZz3kHOhf4otf7xtQt_zMbOnAHyHkde_uR1ahpC2Q0qA",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            "4.2k followers",
                            style: TextStyle(color: Color(0xFF999999)),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "•",
                              style: TextStyle(color: Color(0xFF444444)),
                            ),
                          ),
                          const Text(
                            "zé.design",
                            style: TextStyle(color: Color(0xFF999999)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF1F1F1F),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Edit profile",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF1F1F1F),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Share profile",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
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
                itemBuilder: (context, index) => const ThreadCardWidget(
                  userName: 'Adriel',
                  content:
                      'Remember the moment, you left me alone and broke every promise you ever made',
                  timeAgo: '45 days ago',
                ),
              ),
              const Center(
                child: Text(
                  "No replies yet",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Center(
                child: Text(
                  "No reposts yet",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
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
