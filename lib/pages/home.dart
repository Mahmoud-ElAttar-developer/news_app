// ignore_for_file: non_constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/article_model.dart';
import 'package:news_app/model/cateogry_model.dart';
import 'package:news_app/model/slider_model.dart';
import 'package:news_app/pages/all_news.dart';
import 'package:news_app/services/data.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart' as custom_slider;
import 'package:news_app/widgets/blog_tile.dart';
import 'package:news_app/widgets/build_image.dart';
import 'package:news_app/widgets/build_indicator.dart';
import 'package:news_app/widgets/cateogry_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CateogryModel> category = [];
  List<SliderModel> slider = [];
  List<ArticleModel> articles = [];
  bool _Loading = true;
  int activeIndex = 0; // المتغير المسؤول عن تتبع الصورة الحالية 🔥

  @override
  void initState() {
    category = getCategories();
    loadAllData();
    super.initState();
  }

  loadAllData() async {
    // 1. جلب بيانات السلايدر من كلاس Slider الخاص بك
    // 1. جلب بيانات السلايدر باستخدام الاسم المميز لمنع التضارب
    custom_slider.Slider sliderclass = custom_slider.Slider();
    await sliderclass.getSlider();
    slider = sliderclass.slider;

    // 2. جلب بيانات الأخبار ثانياً من السيرفر
    News newsclass = News();
    await newsclass.getNews();
    articles = newsclass.news;

    // 3. تحديث الشاشة مرة واحدة فقط بعد اكتمال جلب كل البيانات
    setState(() {
      _Loading = false; // الآن تفتح الواجهة بسلام بدون كراش
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _Loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    // قائمة التصنيفات الأفقية
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      height: 70,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: category.length,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            image: category[index].image!,
                            categoryName: category[index].cateogryName!,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Breaking News! ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AllNews(
                                    news: "Breaking",
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // السلايدر المتحرك مع إضافة ميزة تحديث الصفحة النشطة 🔥
                    CarouselSlider.builder(
                      itemCount: slider.length,
                      itemBuilder: (context, index, realIndex) {
                        String? res = slider[index].urlToImage;
                        String? res1 = slider[index].title;
                        return buildImage(
                          context,
                          res!,
                          index,
                          res1!,
                          slider[index].url,
                        );
                      },
                      options: CarouselOptions(
                        height: 250,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex =
                                index; // تحديث الرقم عند حركة السلايدر
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 30), // مسافة قبل المؤشر
                    buildIndicator(activeIndex, slider),
                    const SizedBox(height: 20),
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Trending News! ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AllNews(
                                    news: "Trending",
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return BlogTile(
                          imgUrl:
                              articles[index].urlToImage ??
                              "", // استبدل علامة الـ ! بـ ?? لمنع انهيار البيانات
                          title: articles[index].title ?? "No Title",
                          description: articles[index].description ?? "",
                          url: articles[index].url ?? "",
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
