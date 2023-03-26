import 'package:flutter/material.dart';
import 'package:rixa/rixa.dart';
import '../../main.dart';

class MyDrawer extends StatelessWidget {
  List<Widget> pageIcons = [];
  MyDrawer({Key? key}) : super(key: key);
  List<String> routes = [];
  late List<String> pageNames;
  @override
  Widget build(BuildContext context) {
    pageNames = [];
    return Drawer(
      backgroundColor: appColors.drawerBackgroundColor,
      child: Container(
        width: double.infinity,
        height: appFonts.appHeight,
        child: Column(
          children: [
            SizedBox(
              height: appFonts.appHeight * 0.03,
            ),
            TextButton(
              onPressed: () {
                context.go(route: "/");
                Navigator.pop(context);
              },
              child: Image.asset(
                "assets/icon1.png",
                width: double.infinity,
                height: appFonts.appHeight * 0.06,
              ),
            ),
            for (int i = 0; i < pageNames.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextButton(
                  onPressed: () {
                    context.go(route: routes[i]);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      pageIcons[i],
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${pageNames[i]} ${i < 2 ? (i + 1) : ""}",
                        style: appFonts.S(color: appColors.secondaryTextColor),
                      )
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: SizedButton(
                width: double.infinity,
                height: appFonts.appHeight * 0.06,
                color: appColors.drawerBtnColor,
                innerPadding: const EdgeInsets.symmetric(horizontal: 10),
                onPressed: () {
                  context.go(route: "/login");
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(Icons.logout,
                        color: appColors.appBarBtnTextColor,
                        size: appFonts.icon_M()),
                    Text("Signout",
                        style: appFonts.M(color: appColors.appBarBtnTextColor))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
