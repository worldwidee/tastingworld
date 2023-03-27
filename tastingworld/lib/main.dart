import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rixa/rixa.dart';
import 'package:tastingworld/models/food.dart';
import 'package:tastingworld/models/user.dart';
import 'package:tastingworld/models/comment.dart';
import 'package:tastingworld/services/food_service.dart';
import 'package:tastingworld/services/comment_service.dart';
import 'package:tastingworld/states/categories.dart';
import 'package:tastingworld/states/foods.dart';

import 'app_design/error_screen.dart';
import 'app_design/page_control_panel.dart';
import 'pages/category/category.dart';
import 'pages/food/food.dart';
import 'pages/home/home.dart';
import 'pages/profile/profile.dart';

late AppColors appColors;
late AppFonts appFonts;
late AppSettings appSettings;
late PageManager pageManager;

void main() async {
  var categories = Get.put(Categories());
  var foods = Get.put(Foods());
  if (categories.items.isEmpty) {
    categories.setItems(await FoodService.getCategories());
  }
  WidgetsFlutterBinding.ensureInitialized();
  Rixa.setup(
      pages: AppPages(
          pages: [
            NestedPage(
                fonts: PageFonts(text_small: 10),
                builder: (context, properties, child) {
                  return PageControlPanel(child: child);
                },
                children: [
                  RixaPage(
                      name: "home",
                      builder: (context, properties) => const Home(),
                      route: "/"),
                  RixaPage(
                    name: "category",
                    builder: (context, properties) => const Category(),
                    route: "/category/:category",
                  ),
                  RixaPage(
                    name: "food",
                    builder: (context, properties) => const FoodPage(),
                    route: "/food/:food",
                  ),
                  RixaPage(
                      name: "profile",
                      builder: (context, properties) => const Profile(),
                      route: "/profile"),
                ]),
          ],
          initialRoute: "/",
          unknownRoutePage: const PageControlPanel(child: ErrorPage())),
      appearances: AppAppearances(
        appearances: [
          Appearance.dark(),
          Appearance.light(),
        ],
        initAppearance: Appearance.light(),
      ),
      languages: AppLanguages(languages: ["English"], initLanguge: "English"));

  appColors = Rixa.appColors;
  appFonts = Rixa.appFonts;
  appSettings = Rixa.appSettings;
  pageManager = Rixa.pageManager;
  pageManager = Rixa.pageManager;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RixaMaterial();
  }
}
