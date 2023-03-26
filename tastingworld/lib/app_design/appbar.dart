import 'package:flutter/material.dart';
import '../main.dart';

class MyAppbar extends StatelessWidget with PreferredSizeWidget {
  const MyAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appColors.appBarBackgroundColor,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Log in",
              style: appFonts.M(color: appColors.appBarTextColor),
            ),
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.person,
              color: appColors.iconColor,
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
