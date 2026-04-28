import 'package:flutter/material.dart';
import 'package:threads_app/widgets/activity_tile_widget.dart';

class LikedScreen extends StatelessWidget {
  const LikedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> filters = ["All", "Replies", "Mentions", "Quotes", "Reposts", "Verified"];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFF1F1F1F))),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  bool isFirst = index == 0;
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
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
                        side: BorderSide(color: isFirst ? Colors.white : const Color(0xFF1F1F1F)),
                      ),
                      showCheckmark: false,
                    ),
                  );
                },
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              const ActivityTileWidget(
                userName: "marcus_dev",
                type: ActivityType.follow,
                timeAgo: "2h",
                content: "Followed you",
                avatarUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuAccBoX5k2IOdKntoyw98bbtyFWtoXgkW6mFMZGWsDbTiUqCiB79pv-5nLH00EG9ZD9ht4sLk3RXJm5fcOCG-E-BF0oRCR2rdl9G46TL2vcnaPapJLjPkx-frnwtvlGaTEuoaItygw8YdeaVNZMdItQJjewFQ0D-cjDk_46eiDBxtb9wKsdFYS2N47EBVco9vRLprZF4y1Ps47Mt8KcB2NS-jJa3uZ9odymtKdoAnM5doLMXrAfXb-rqIwlo7waFyvgLCVE-5yMZ7I",
              ),
              const ActivityTileWidget(
                userName: "elena.designs",
                type: ActivityType.like,
                timeAgo: "4h",
                content: "Liked your thread",
                subContent: "The future of UI design is not about more features, but about more focus. Minimalism is the ultimate sophistication.",
                avatarUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuAG4AYmuynfyButJpeuVkrekTNZxDI1SSuppujHA2bkOSc11QKcQESum1af9rG_FCL_MhFm5SDe2rH1oCxRtI4GTKYt2HsD6DrOc_HuaR26ii9_cG07_SfDWMQPWPgh8Flbkvw3zIgfc2jvJtzErA_fXygqe-1iBOkDc6Ion0z31M6EV8WptyR4npMSx9Mq61LL3CLyharZ2bHJ0KrCpwp13FTzFC_v_6HhyN6D02lwnw8ywzxfYINRItV2Ia4_uh9ZBbqs3VlW4e0",
              ),
              const ActivityTileWidget(
                userName: "creative.sam",
                type: ActivityType.reply,
                timeAgo: "8h",
                content: "This is exactly what I needed to hear today! The void-first philosophy makes so much sense for focus. 🌌",
                avatarUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuAwgHric-TPOhxL3JClBzk2ucqgdt4hzBrt7U1baViMycxl_qukMOzGtyfbWmypgEAMLYwokiIsYgTN0BeuI4mSL57AlBGmhyvfM0UTdPK1FPuEdtVT1n_zRo042lpk_574gUf8Imw6bVKAG6HQTJ9CIUXQ6cQSJpOa7wMn5OpBs6FFkRt9Lcy29HZv4CW7IG6K9xkQgSvx3WSKbQq5ncqXGZ48iJNhTocIh5SKPeA7peugrhxj1ZnLQcvYtjtEimWygTSn1X7zQxI",
              ),
            ]),
          ),
        ],
      ),
    );
  }
}