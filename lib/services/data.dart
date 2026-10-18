import 'package:news_app/model/cateogry_model.dart';

List<CateogryModel> getCategories() {
  List<CateogryModel> category = [];
  CateogryModel categoryModel = CateogryModel();

  // 1. Business Category
  categoryModel.cateogryName = "Business"; 
  categoryModel.image = "images/business-people-shaking-hands-together_53876-13391.avif";
  category.add(categoryModel);
  categoryModel = CateogryModel();

  // 2. Science Category
  categoryModel.cateogryName = "Science"; 
  categoryModel.image = "images/hand-drawn-science-education-background_23-2148499325.avif";
  category.add(categoryModel);
  categoryModel = CateogryModel();

  // 3. Health Category
  categoryModel.cateogryName = "Health"; // 
  categoryModel.image = "images/health-png-diverse-hands-wellness-remix-transparent-background_53876-941759.avif";
  category.add(categoryModel);
  categoryModel = CateogryModel();
 
  // 4. Entertainment Category
  categoryModel.cateogryName = "Entertainment"; 
  categoryModel.image = "images/group-diverse-friends-holding-movie-emoticons_53876-65393.avif";
  category.add(categoryModel);
  categoryModel = CateogryModel();

  // 5. Sports Category
  categoryModel.cateogryName = "Sports"; // 
  categoryModel.image = "images/360_F_4437974_DbE4NRiaoRtUeivMyfPoXZFNdCnYmjPq.jpg"; 
  category.add(categoryModel);
  categoryModel = CateogryModel();

  // 6. General Category
  categoryModel.cateogryName = "General"; 
  categoryModel.image = "images/vintage-general-store-enamel-tin-sign-retro-old-west-blue-rustic-embossed-isolated-shop-grunge-vintage-general-store-enamel-tin-128250267.webp"; 
  category.add(categoryModel);

  return category;
}
