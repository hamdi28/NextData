class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  /// Constructor
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  /// Factory method to create a Post from JSON
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  /// Method to convert a Post object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  /// Method to convert a Post object to a String (useful for debugging)
  @override
  String toString() {
    return 'Post{userId: $userId, id: $id, title: $title, body: $body}';
  }
}
