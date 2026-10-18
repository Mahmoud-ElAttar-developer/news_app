import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/pages/article_view.dart';

class ShowCategory extends StatelessWidget {
  final String image, desc, title, url; // جعلنا كل الحروف صغيرة وأضفنا final لـ url

  const ShowCategory({
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
          MaterialPageRoute(builder: (context) => ArticleView(blogUrl: url)),
        );
      },
      child: Column(
        children: [
          // ويدجت عرض صورة الخبر من الإنترنت بأبعاد الشاشة كاملة بالعرض
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: image,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ), // المحاضر التالية تعرض العنوان والوصف للخبر بالـ title و desc المعرفين في ShowCategory
          Text(
            desc,
            maxLines: 4,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
