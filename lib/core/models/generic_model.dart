class GenericModel {
  final int userId;
  final String userName;
  final int postId;
  final String postTitle;
  final String postBody;

  /// Constructor
  GenericModel({
    required this.userId,
    required this.postId,
    required this.postTitle,
    required this.userName,
    required this.postBody,
  });

  /// Factory method to create a Post from JSON
  factory GenericModel.fromJson(Map<dynamic, dynamic> json) {
    return GenericModel(
      userId: json['userId'],
      userName: json['userName'],
      postId: json['Id'],
      postTitle: json['postTitle'],
      postBody: json['postBody'],
    );
  }

  // Method to convert a Post object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'postTitle': postTitle,
      'postBody': postBody,
    };
  }

}