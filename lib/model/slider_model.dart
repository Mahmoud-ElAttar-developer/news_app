class SliderModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;

  // الـ Constructor الخاص بالـ Model
  SliderModel({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.content,
  });

  // دالة الـ factory من أجل تحويل الـ JSON (الذي تراه في المتصفح) إلى كائن يفهمه فلاتر
  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      content: json['content'],
    );
  }
}
