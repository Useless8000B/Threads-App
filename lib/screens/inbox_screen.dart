import 'package:flutter/material.dart';
import 'package:threads_app/widgets/inbox_tile_widget.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF1F1F1F)),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              children: const [
                InboxTileWidget(
                  userName: "irineu",
                  lastMessage: "Did you see the latest post about the architectural design?",
                  timeAgo: "2h",
                  isUnread: true,
                  avatarUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuBQKSRYSEG_AoHgVYzOR7s1WAZTT4TQZ7LGa_LzWxCyQ4GDvo-ede-07FMayXAMQkxJIe4Bl8KZgIB7GJSQx3RGmMvOk5N8NxlSMBQWEo9lBmESWcLxrsVcarAJaoSMJNu34SSJNOMa1b7Ny6jhnOjHmvWyk_S3Dg2kQKKziHmHYYsQBd22lKjuxkL8sZ0ma57dCWokB6Fz0Bz7LqlNCOpR5sch9LH6gvbrIDP_Af8YxoBihc5EBOhESbWOby-Y2jT7zYFwbPvpX4E",
                ),
                InboxTileWidget(
                  userName: "marcus.design",
                  lastMessage: "Sent a photo",
                  timeAgo: "4h",
                  isUnread: false,
                  avatarUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuBGGxyeilpJqB-57QfB7W75_0WYHPBmGbCA4Y84sgghCvIHd_IMEe3kfLhnCrmiS8HYgEI0O89r9q2w6bJb4seYI4aAl5k-Mxhm6LK4XDWcHdkVmJnOckQgGwlqh2g7thvhRnXOtqeakUksv2UlHwygwZ2AdfqWkZfMaAzJBRXE__3uoodquXJsvmcvtfJ6NlWBmIX_wYf25mhvi8p7MutcBVxiUN8rrd9s3E0XRzVvM6WxG4cuzK0HT4FVEpwSAFtwIWWV4lpJHjM",
                ),
                InboxTileWidget(
                  userName: "supershock",
                  lastMessage: "That works for me. See you at the gallery tonight!",
                  timeAgo: "1d",
                  isUnread: false,
                  avatarUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuC5_IK2Z83IeJhD8PsbQdUdHcr69WjSx_LBndBAgYcp5rllrpzZNVTRcErJ_Mkz9BdU1G4o_HPMVc_IGBtpHSuhohjeCrQVvLdsCud7LUiOtUfs8Sue4eqphtTYnj7sAbPMIX6wMNMJTotIXuHRNK8nA4i27F-iwheMkTuZPX6xkIsuxDqDDFvoRy3Q31bC1yLLnRX4xkL2q_MtrPWi5gyaynhIl2wQ4rDNcjMK7mpKfdK9q5VG3YCfFvCEczk8fuMPH22ajCw2_-M",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}