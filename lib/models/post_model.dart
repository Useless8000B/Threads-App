import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? id;
  final String uid;
  final String username;
  final String? text;
  final DateTime? createdAt;

  PostModel({
    this.id,
    required this.uid,
    required this.username,
    this.text,
    this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      uid: json['uid'] ?? '',
      username: json['username'] ?? '',
      text: json['text'] ?? '',
      createdAt: json['createdAt'] != null 
          ? DateTime.tryParse(json['createdAt'].toString()) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'text': text,
    };
  }

  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PostModel(
      id: doc.id,
      uid: data['uid'] ?? '',
      username: data['username'] ?? '',
      text: data['text'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}