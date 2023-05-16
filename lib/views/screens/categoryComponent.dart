import 'package:flutter/material.dart';
import 'package:flutter_news_app/views/screens/homepage.dart';
import 'package:flutter_news_app/views/screens/likeComponent.dart';
import 'package:flutter_news_app/views/screens/searchpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../res/global.dart';
import 'package:get/get.dart';

class CategoryComponent extends StatefulWidget {
  const CategoryComponent({Key? key}) : super(key: key);

  @override
  State<CategoryComponent> createState() => _CategoryComponentState();
}

class _CategoryComponentState extends State<CategoryComponent> {
  int currentIndex = 0;
  IconData home = Icons.home_outlined;
  IconData category = Icons.category_sharp;
  IconData fav = Icons.bookmark_outline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 130,
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(25)),
                color: (Global.isDark)
                    ? const Color(0xff1e1e1e)
                    : Colors.blue.shade50,
              ),
              child: FlexibleSpaceBar(
                expandedTitleScale: 1,
                background: Align(
                  alignment: const Alignment(-0.89, -0.4),
                  child: Text(
                    "News",
                    style: GoogleFonts.arya(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Global.isDark ? Colors.white : Colors.black),
                  ),
                ),
                title: Row(
                  children: [
                    Expanded(
                      flex: 11,
                      child: Text(
                        "Categories",
                        style: GoogleFonts.arya(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Global.isDark ? Colors.white : Colors.black),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
                          Get.changeThemeMode(
                            (Get.isDarkMode == true)
                                ? ThemeMode.light
                                : ThemeMode.dark,
                          );
                        },
                        child: Icon(
                          Icons.light_mode_outlined,
                          color: Global.isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                titlePadding: const EdgeInsets.only(left: 10, bottom: 20),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Popular Searches",
                        style: GoogleFonts.play(
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Global.isDark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                          color: Global.isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      myContainer(
                        title: 'Latest\nNews',
                        myColor: Colors.indigo.shade300,
                        nav: 'Latest',
                      ),
                      const SizedBox(width: 10),
                      myContainer(
                          title: 'World\nNews',
                          myColor: Colors.blue.shade300,
                          nav: 'World'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      myContainer(
                          title: 'Weather\nNews',
                          myColor: Colors.purple.shade200,
                          nav: 'Weather'),
                      const SizedBox(width: 10),
                      myContainer(
                          title: 'Political\nNews',
                          myColor: Colors.teal.shade300,
                          nav: 'Political'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      myContainer(
                          title: 'Sports\nNews',
                          myColor: Colors.orange.shade400,
                          nav: 'Sports'),
                      const SizedBox(width: 10),
                      myContainer(
                          title: 'Health\nNews',
                          myColor: Colors.pink.shade300,
                          nav: 'Health'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      myContainer(
                          title: 'Tech\nNews',
                          myColor: Colors.red.shade300,
                          nav: 'Tech'),
                      const SizedBox(width: 10),
                      myContainer(
                          title: 'Science\nNews',
                          myColor: Colors.green.shade400,
                          nav: 'Science'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      myContainer(
                          title: 'Medical\nNews',
                          myColor: Colors.amber.shade400,
                          nav: 'Medical'),
                      const SizedBox(width: 10),
                      myContainer(
                          title: 'Wildlife\nNews',
                          myColor: Colors.deepPurple.shade300,
                          nav: 'Wildlife'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LoadingAnimationWidget.discreteCircle(
                      color: Global.isDark ? Colors.white : Colors.black,
                      size: 30),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor:
          (Global.isDark == true) ? const Color(0xff2a2a2a) : Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            (Global.isDark) ? const Color(0xff1e1e1e) : Colors.blue.shade50,
        onTap: (val) {
          setState(() {
            currentIndex = val;
            if (currentIndex == 0) {
              home = Icons.home;
              category = Icons.category_outlined;
              fav = Icons.bookmark_outline;
              Get.to(
                () => const HomePage(),
                duration: const Duration(seconds: 2),
                transition: Transition.fadeIn,
                curve: Curves.easeInOut,
              );
            } else if (currentIndex == 1) {
              home = Icons.home_outlined;
              category = Icons.category_sharp;
              fav = Icons.bookmark_outline;
            } else if (currentIndex == 2) {
              home = Icons.home_outlined;
              category = Icons.category_outlined;
              fav = Icons.bookmark;
              Get.to(
                () => const BookMarkComponent(),
                duration: const Duration(seconds: 2),
                transition: Transition.fadeIn,
                curve: Curves.easeInOut,
              );
            }
          });
        },
        selectedItemColor: Global.isDark ? Colors.white : Colors.black,
        unselectedItemColor: Global.isDark ? Colors.white30 : Colors.black45,
        items: [
          BottomNavigationBarItem(icon: Icon(home, size: 30), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(category, size: 30), label: "Category"),
          BottomNavigationBarItem(icon: Icon(fav, size: 30), label: "Favorite"),
        ],
        currentIndex: 1,
      ),
    );
  }

  Widget myContainer(
      {required String title, required Color myColor, required String nav}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Global.text = nav;
        });
        Get.to(
          () => const SearchPage(),
          transition: Transition.fadeIn,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width / 2.16,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: myColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 1,
              color: Global.isDark ? Colors.white38 : Colors.grey.shade400,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.arya(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
