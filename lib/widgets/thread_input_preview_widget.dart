import 'package:flutter/material.dart';

class ThreadInputPreviewWidget extends StatelessWidget {
  const ThreadInputPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF1F1F1F))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuDZB6falXkw1qbnl8QcqD0dzlIFbAMqXRSyQ_3EIBrHCMNdIsU0Q5ZfdspdLs4APa2-PAoLDxgxvDn6uRIkhTTc899apXDRV3zzMgAjt11yf6KoVQrWOyje7XCU89GcH9MBW0lsjPg2KZ8GNP0kUPaddpKzglmeDcwOCXKp4w09OBAplEcnvM8J40V_DVnhaxnsc6Rj-Qx5nDu0oL_sxhvWQk91KOoNIjcjv4aKwFx8I2r2EkhK8TTn5UsqcAP5iHqe4FTOJb3do_I"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "What's new?",
                  style: TextStyle(color: Color(0xFF757575), fontSize: 15),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.image_outlined, color: Color(0xFF757575), size: 20),
                        SizedBox(width: 16),
                        Icon(Icons.gif_box_outlined, color: Color(0xFF757575), size: 20),
                        SizedBox(width: 16),
                        Icon(Icons.list, color: Color(0xFF757575), size: 20),
                        SizedBox(width: 16),
                        Icon(Icons.mic_none, color: Color(0xFF757575), size: 20),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        disabledBackgroundColor: Colors.white.withValues(alpha: 0.5),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      ),
                      child: const Text("Post", style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}