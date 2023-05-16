import 'package:flutter/material.dart';
import 'package:flutter_news_app/models/bookmark_news_model.dart';
import 'package:flutter_news_app/views/screens/categoryComponent.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../components/bookmark_news_controller.dart';
import '../../res/global.dart';
import 'detailpage.dart';
import 'homepage.dart';

class BookMarkComponent extends StatefulWidget {
  const BookMarkComponent({Key? key}) : super(key: key);

  @override
  State<BookMarkComponent> createState() => _BookMarkComponentState();
}

class _BookMarkComponentState extends State<BookMarkComponent> {
  late Future<List<BookMarkNews>> news;

  int currentIndex = 2;
  IconData home = Icons.home_outlined;
  IconData category = Icons.category_outlined;
  IconData fav = Icons.bookmark;

  @override
  void initState() {
    super.initState();
    news = DBHelper.dbHelper.selectData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: news,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Images not found..."),
            );
          } else if (snapshot.hasData) {
            List<BookMarkNews>? data = snapshot.data;
            return CustomScrollView(
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
                              "Saved news",
                              style: GoogleFonts.arya(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: Global.isDark ? Colors.white : Colors.black,
                              ),
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
                (data!.isNotEmpty)
                    ? SliverAnimatedList(
                  initialItemCount: data.length,
                  itemBuilder: (context, i, animation) => Padding(
                    padding: const EdgeInsets.all(15),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.to(
                                  () => const DetailPage(),
                              duration: const Duration(seconds: 1),
                              transition: Transition.fadeIn,
                              curve: Curves.easeInOut,
                              arguments: data[i].url,
                            );
                          },
                          child: Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Global.isDark
                                  ? Colors.white
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                "${data[i].image}",
                                fit: BoxFit.fill,
                                loadingBuilder:
                                    (context, child, image) {
                                  if (image == null) return child;
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade400,
                                    highlightColor:
                                    Colors.grey.shade300,
                                    child: Container(
                                      height: 300,
                                      width: double.infinity,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white24,
                          ),
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () async {
                              int res = await DBHelper.dbHelper
                                  .deleteData(index: data[i].id!);

                              if (res == 1) {
                                setState(() {
                                  news = DBHelper.dbHelper.selectData();
                                });
                              }
                            },
                            child: const Icon(Icons.delete,
                                color: Colors.red, size: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                    : SliverToBoxAdapter(
                  child: Container(
                    height: 550,
                    width: double.infinity,
                    color: Colors.transparent,
                    alignment: const Alignment(0, 0),
                    child: Text(
                      "No favorite images...",
                      style: GoogleFonts.arya(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color:
                        Global.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.indigo, size: 40),
            );
          }
        },
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
              Get.to(
                    () => const CategoryComponent(),
                duration: const Duration(seconds: 2),
                transition: Transition.fadeIn,
                curve: Curves.easeInOut,
              );
            } else if (currentIndex == 2) {
              home = Icons.home_outlined;
              category = Icons.category_outlined;
              fav = Icons.bookmark;
            }
          });
        },
        selectedItemColor: Global.isDark ? Colors.white : Colors.black,
        unselectedItemColor: Global.isDark ? Colors.white30 : Colors.black45,
        items: [
          BottomNavigationBarItem(icon: Icon(home, size: 30), label: "Home"),
          BottomNavigationBarItem(icon: Icon(category, size: 30), label: "Category"),
          BottomNavigationBarItem(icon: Icon(fav, size: 30), label: "Bookmark"),
        ],
        currentIndex: 2,
      ),
    );
  }
}
