class PushMessage {
  final String messaggeId;
  final String title;
  final String body;
  final DateTime sentDate;
  final Map<String, dynamic>? data;
  final String? imageUrl;

  PushMessage(
      {required this.messaggeId,
      required this.title,
      required this.body,
      required this.sentDate,
      this.data,
      this.imageUrl});

  @override
  String toString() {
    return '''
    PushMessage: $messaggeId 
    Title:       $title
    Body:        $body
    SentDate:    $sentDate
    Data:        $data
    ImgUrl:      $imageUrl
    ''';
  }
}
