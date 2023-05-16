import '../res/global.dart';

class NewsModel {
  // final String source;

  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? image;
  final String? content;

  NewsModel({
    // required this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.image,
    this.content,
  });

  factory NewsModel.fromMap({required Map data}) {
    return NewsModel(
      // source: data['articles'][i]['source'],
      author: data['articles'][Global.i++]['author'],
      title: data['articles'][Global.i++]['title'],
      description: data['articles'][Global.i++]['description'],
      url: data['articles'][Global.i++]['url'],
      image: data['articles'][Global.i++]['urlToImage'],
      content: data['articles'][Global.i++]['content'],
    );
  }
}
