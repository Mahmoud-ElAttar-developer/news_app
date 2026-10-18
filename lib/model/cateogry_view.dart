class CateogryView {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;

  // الـ Constructor الخاص بالـ Model
 CateogryView({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.content,
  });

  // دالة الـ factory من أجل تحويل الـ JSON (الذي تراه في المتصفح) إلى كائن يفهمه فلاتر
  factory CateogryView.fromJson(Map<String, dynamic> json) {
    return CateogryView(
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      content: json['content'],
    );
  }
}
