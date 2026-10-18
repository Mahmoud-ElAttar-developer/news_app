import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/model/slider_model.dart';

class Slider{
  List<SliderModel> slider = [];

  Future<void> getSlider() async {
    // الرابط المستخدم لجلب الأخبار من السيرفر
    String url =
        "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=a3426e9c0bab4a2381221d42a46c9cd0";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        // التأكد من أن الخبر يحتوي على صورة ووصف قبل إضافته لتجنب أخطاء التصميم
        if (element['urlToImage'] != null && element['description'] != null) {
          SliderModel sliderModel = SliderModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          slider.add(sliderModel);
        }
      });
    }
  }
}
