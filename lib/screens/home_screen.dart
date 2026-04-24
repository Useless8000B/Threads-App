import 'package:flutter/material.dart';
import 'package:threads_app/widgets/thread_card_widget.dart';
import 'package:threads_app/widgets/thread_input_preview_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> mockThreads = [
      {
        "userName": "elena_design",
        "content": "Working on a new 'void-first' design system. There's something so peaceful about a pure black canvas. No noise, just focus.",
        "timeAgo": "4h",
        "replies": 12,
        "likes": 48,
        "avatarUrl": "https://lh3.googleusercontent.com/aida-public/AB6AXuBcaxiYOWcIz9XTtwgbwxew3jOl0BDo4OH55FwpbTTtti5el8WZ0NjgiavelR3Dh7dckuZVy_ieREqGYBtzadt8uuZf9LDdOTKP9XXsSCDLwJKE6FqarWZRtgQW8fi5Q0ibmrch1FsFQD73Iw1B3EBJXCFnHSVNARDizlSDlml9SWMl8Tq5xzRa_wW9z9vo7EtQ9PzvVlXOxM6pGM5C2DxCLI6svWq5CNCIza4DuDTTBRLH6ZmxTKO3cRz6Dgz5qHdpREkYeeaI75U"
      },
      {
        "userName": "marcus.dev",
        "content": "Finally visited the Tokyo National Art Center. The architecture is just as inspiring as the exhibits.",
        "timeAgo": "6h",
        "imageUrl": "https://images.unsplash.com/photo-1511497584788-876760111969",
        "replies": 5,
        "likes": 204,
        "avatarUrl": "https://lh3.googleusercontent.com/aida-public/AB6AXuD9kgcCPioZHkha8Y8Mo6Rp0hd7SboUSjjg-kcIgXaVKIYq3B64rOH1eQ-_ioHNE9-SqbVBQ-W8WP6Aenr9e2Z7NqRiTeOmv4PKkR1bdKlinqEZQnpPSduAwBIOVZVu8DgqQoNLjsL-7fD3NlM43thAT0h2v3-JqUQUgEBSEU_IKTgabmilb9qeUL6CEaGMTXLy_zqx8aQOeBRpXtS0vv8c3_d_N_SS4F3tBcXDBEyy9nA_GNVkBdl-Cfyd0jER0M0MCOsH9GR5meE"
      },
      {
        "userName": "aesthetic_void",
        "content": "Is it just me or does everyone feel more productive when they switch their IDE to pure black?",
        "timeAgo": "12h",
        "replies": 89,
        "likes": 1200,
        "avatarUrl": null
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: mockThreads.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const ThreadInputPreviewWidget();
          }
          
          final thread = mockThreads[index - 1];
          return ThreadCardWidget(
            userName: thread['userName'],
            content: thread['content'],
            timeAgo: thread['timeAgo'],
            imageUrl: thread['imageUrl'],
            replies: thread['replies'],
            likes: thread['likes'],
            avatarUrl: thread['avatarUrl'],
          );
        },
      ),
    );
  }
}