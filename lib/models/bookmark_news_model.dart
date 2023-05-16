class BookMarkNews {
  int? id;
  String? title;
  String? description;
  String? image;
  String? url;

  BookMarkNews({
    this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.url,
  });

  factory BookMarkNews.fromMap({required Map<String, dynamic> data}) {
    return BookMarkNews(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      image: data['image'],
      url: data['url'],
    );
  }
}