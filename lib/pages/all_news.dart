import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/article_model.dart'; // تأكد من مسار موديل الأخبار عندك
import 'package:news_app/model/slider_model.dart';
import 'package:news_app/pages/article_view.dart';
import 'package:news_app/services/slider_data.dart' as custom_slider;
import 'package:news_app/services/news.dart';

class AllNews extends StatefulWidget {
  final String
  news; // استقبال نوع الأخبار (Breaking أو Trending) القادم من الصفحة الرئيسية
  const AllNews({super.key, required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  // القوائم لتخزين البيانات المسترجعة
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool _loading = true; // مؤشر التحميل لمنع الـ Memory Crash

  @override
  void initState() {
    super.initState();
    getNewsData();
  }

  // دالة ذكية ومدمجة لجلب البيانات بناءً على الكلمة الممررة ديناميكياً
  getNewsData() async {
    if (widget.news == "Breaking") {
      custom_slider.Slider sliderclass = custom_slider.Slider();
      await sliderclass.getSlider();
      sliders = sliderclass.slider;
    } else {
      News newsclass = News();
      await newsclass.getNews();
      articles = newsclass.news;
    }

    setState(() {
      _loading = false; // فتح الشاشة بعد اكتمال جلب البيانات بسلام
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.news} News", // عرض عنوان الصفحة ديناميكياً (مثل Breaking News)
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator()) // شاشة تحميل آمنة
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                // تحديد طول القائمة ديناميكياً بناءً على نوع الخبر المختار
                itemCount: widget.news == "Breaking"
                    ? sliders.length
                    : articles.length,
                itemBuilder: (context, index) {
                  return AllNewsSection(
                    image: widget.news == "Breaking"
                        ? (sliders[index].urlToImage ?? "")
                        : (articles[index].urlToImage ?? ""),
                    desc: widget.news == "Breaking"
                        ? (sliders[index].description ?? "")
                        : (articles[index].description ?? ""),
                    title: widget.news == "Breaking"
                        ? (sliders[index].title ?? "")
                        : (articles[index].title ?? ""),
                    url: widget.news == "Breaking"
                        ? (sliders[index].url ?? "")
                        : (articles[index].url ?? ""),
                  );
                },
              ),
            ),
    );
  }
}

class AllNewsSection extends StatelessWidget {
  final String image,
      desc,
      title,
      url; // جعلنا كل الحروف صغيرة وأضفنا final لمنع التحذير الأصفر

  const AllNewsSection({
    super.key,
    required this.image,
    required this.desc,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: url,
            ), // ⬅️ الانتقال لصفحة عرض الخبر وتمرير الرابط لها
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              desc,
              maxLines: 3,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(
              height: 20,
            ), // مسافة تفصل بين كل كارت خبر والآخر في القائمة
          ],
        ),
      ),
    );
  }
}
