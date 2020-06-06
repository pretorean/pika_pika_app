class PostMessage {
  final String id;
  final String body;
  final String title;
  final String userId;
  final String firstName;
  final String lastName;
  final String likes;
  final String views;
  final String type;
  final String createDate;
  final String modifyDate;

  PostMessage({
    this.id,
    this.body,
    this.title,
    this.userId,
    this.firstName,
    this.lastName,
    this.likes,
    this.views,
    this.type,
    this.createDate,
    this.modifyDate,
  });

  PostMessage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        body = json['body'],
        title = json['title'],
        userId = json['user_id'],
        firstName = json['firstname'],
        lastName = json['lastname'],
        likes = json['likes'],
        views = json['views'],
        type = json['type'],
        createDate = json['createdate'],
        modifyDate = json['modifydate'];
}
