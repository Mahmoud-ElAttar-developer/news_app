import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/model/cateogry_view.dart'; // تأكد من مسار موديل الأخبار الأصلي في مشروعك

class ShowCategoryNews {
  // 1. القائمة التي ستخزن الأخبار ونوعها ArticleModel الموحد
  List<CateogryView> categories = [];

  Future<void> getCategoriesNews(String category) async {
    // 2. استخدام الرابط البديل المستقر والمجاني لمنع مشاكل الـ API Key
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=a3426e9c0bab4a2381221d42a46c9cd0";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        // 3. فحص الـ Null Safety بدقة لمنع الشاشات البيضاء
        if (element["urlToImage"] != null &&
            element["description"] != null &&
            element["title"] != null) {
          // 4. استخدام الموديل الصحيح هنا لإصلاح الإيرور الأحمر
          CateogryView categoryModel = CateogryView(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          categories.add(categoryModel);
        }
      });
    }
  }
}
