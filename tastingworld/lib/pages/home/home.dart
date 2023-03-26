import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:rixa/rixa.dart';
import 'package:rixa/state_widgets/rixa_builder.dart';
import 'package:rixa/widgets/sized_button.dart';
import 'package:tastingworld/main.dart';
import 'package:tastingworld/states/categories.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return RixaBuilder(
      builder: (properties, fonts) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 430,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 430,
                      color: Colors.black,
                    ),
                    Container(
                      width: double.infinity,
                      height: 430,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.4),
                                  BlendMode.dstATop),
                              image: AssetImage("assets/home-map.jpg"),
                              fit: BoxFit.cover)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Travel Global, Eat Local.",
                            style: appFonts.L(color: Colors.white,fontFamily: 'Anton'),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              for (var category in Get.find<Categories>().items)
                                SizedButton(
                                  width: appFonts.appWidth * 0.2,
                                  height: appFonts.appHeight * 0.06,
                                  radius: 10,
                                  borderColor: Colors.white,
                                  borderWith: 2,
                                  onPressed: () {},
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.fastfood,
                                          color: Colors.orange,
                                          size: appFonts.icon_S(),
                                        ),
                                        Text(
                                          category.capitalizeFirstofEach,
                                          style:
                                              fonts.small3(color: Colors.white),
                                        )
                                      ]),
                                )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
