import 'package:flutter/material.dart';
import 'package:threads_app/colors.dart';
import 'package:threads_app/models/post_model.dart';
import 'package:threads_app/services/auth_service.dart';
import 'package:threads_app/services/post_service.dart';
import 'package:threads_app/widgets/snackbar_utils.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _controller = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuAfL31xZ1gxZ5rovFeRcOhRg6Y1YS5ozmIYQp8uZiS7mw0GqTSOiWz5sUW4sNC-7bN8a0Wkylnaja7eYYeQmsuISLMdPBRoWlFZKTI67G6iKQVtymMeXtUOzZOLWNunjevw57RUS0msfz44SgfLql8o3T8X9cNEiYr_fVGhrpdekkIXQJpXLvi6UJwLKOURlfZf95ZpGHT4WnwIGk33iKG9Gs-493qSXW1W3f6I1WhkYys5Z2ckkZ0j6PND-KW7vveJivCkO3_WxwU",
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        width: 2,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F1F1F),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Opacity(
                      opacity: 0.3,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuA16j4jzlsNjuEXkxbQtIQAh9fTQuvERPASqpFRV-Ef_0Vh1rm6grkanBjHGPODbM36PAfterDYsxLp64KW84eOgGthmjtkTrieaN1DZ7TNFqgx260_cIxOI6GXapwrJNy88NJBAWCuYoaGx-YdHZx4FwoRm5UMj1Yc4SLwaM6BlVsT0gWeqEcQwg_Us78V9u25JoODJu-S7k0gLZKs7sClPBm9nwHN88O3CXgAJxR0G0imNmjXkFHuWm8vdKlUZYCYeKGhmYnas0U",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "zé_preto",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: _controller,
                      autofocus: true,
                      maxLines: null,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: const InputDecoration(
                        hintText: "What's new?",
                        hintStyle: TextStyle(color: Color(0xFF666666)),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                    ),

                    const SizedBox(height: 16),
                    Row(
                      children: [

                        const Icon(
                          Icons.gif_box_outlined,
                          color: Color(0xFF666666),
                          size: 22,
                        ),
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.list_alt_rounded,
                          color: Color(0xFF666666),
                          size: 22,
                        ),
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.mic_none,
                          color: Color(0xFF666666),
                          size: 22,
                        ),
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.tag,
                          color: Color(0xFF666666),
                          size: 22,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      "Add to thread",
                      style: TextStyle(color: Color(0x66666666), fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Anyone can reply",
              style: TextStyle(color: Color(0xFF666666), fontSize: 14),
            ),
            ElevatedButton(
              onPressed: () async {
                final text = _controller.text;
                if (text.isEmpty) return;

                try {
                  final user = _authService.currentUser;

                  if (user == null) return;

                  final userData = await _authService.getUserData(user.uid);
                  final username = userData['username'] ?? "user";

                  final newPost = PostModel(
                    uid: user.uid,
                    username: username,
                    text: _controller.text,
                  );

                  final PostService postService = PostService();
                  bool success = await postService.createPost(newPost);

                  if (success) {
                    if (mounted) {
                      SnackbarUtils.showSuccess(context, "Post created successfully!");
                      Navigator.pop(context);
                    }
                  } else {
                    if (mounted) {
                      SnackbarUtils.showError(context, "Failed to create post.");
                    }
                  }
                } catch (error) {
                  if (mounted) {
                    SnackbarUtils.showError(context, "An error occurred: $error");
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text(
                "Post",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
