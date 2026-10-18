import 'package:flutter/material.dart';
import 'package:news_app/model/cateogry_view.dart';
import 'package:news_app/services/show_cateogry_news.dart';
import 'package:news_app/widgets/show_category.dart';

class CategoryNews extends StatefulWidget {
  final String name; // استقبال اسم التصنيف القادم من الصفحة الرئيسية
  const CategoryNews({super.key, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<CateogryView> categories = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
    categories = showCategoryNews.categories;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name, // عرض اسم التصنيف ديناميكياً في الـ AppBar
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return ShowCategory(
                    image:
                        categories[index].urlToImage ??
                        "", // استبدلنا ! بـ ?? لحمايتك من الشاشات البيضاء
                    desc: categories[index].description ?? "",
                    title: categories[index].title ?? "No Title",
                    url: categories[index].url ?? "",
                  );
                },
              ),
            ),
    );
  }
}
