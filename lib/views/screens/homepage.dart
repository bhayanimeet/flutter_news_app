import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/components/bookmark_news_controller.dart';
import 'package:flutter_news_app/models/bookmark_news_model.dart';
import 'package:flutter_news_app/views/screens/categoryComponent.dart';
import 'package:flutter_news_app/views/screens/detailpage.dart';
import 'package:flutter_news_app/views/screens/likeComponent.dart';
import 'package:flutter_news_app/views/screens/searchpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../components/google_ads_controller.dart';
import '../../res/global.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  IconData home = Icons.home;
  IconData category = Icons.category_outlined;
  IconData fav = Icons.bookmark_outline;

  CarouselController carouselController = CarouselController();
  int currentPage = 0;

  void getNews() async {
    String api =
        'https://newsapi.org/v2/everything?q=india&from=2023-04-20&to=2023-05-12&sortBy=popularity&apiKey=c45f8dc15c8149f69c961bb011f693d6';
    var result = await Dio().get(api);

    if (result.statusCode == 200) {
      setState(() {
        Global.newsList = result.data['articles'];
      });
    }
  }

  customError() {
    ErrorWidget.builder = (FlutterErrorDetails error) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoadingAnimationWidget.discreteCircle(
                  color: Colors.white, size: 30),
              const SizedBox(height: 10),
              Text(
                "Please wait just a second...",
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    };
  }

  List carouselItems = [
    23,
    16,
    18,
    20,
    9,
  ];

  @override
  void initState() {
    super.initState();
    customError();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                  color: (Global.isDark == false)
                      ? const Color(0xffe9e2f1)
                      : const Color(0xff35313f),
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
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: SizedBox(
                          height: 50,
                          width: 200,
                          child: TextField(
                            controller: Global.textController,
                            onSubmitted: (val) {
                              setState(() {
                                if (val.isEmpty) {
                                  Get.off(
                                    () => const HomePage(),
                                    curve: Curves.easeInOut,
                                    transition: Transition.fadeIn,
                                    duration: const Duration(seconds: 1),
                                  );
                                } else {
                                  Global.text = val;
                                  Get.to(
                                    () => const SearchPage(),
                                    curve: Curves.easeInOut,
                                    transition: Transition.fadeIn,
                                    duration: const Duration(seconds: 1),
                                  );
                                }
                              });
                            },
                            style: GoogleFonts.arya(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: (Global.isDark == false)
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(top: 4),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Global.isDark == false)
                                        ? Colors.black
                                        : Colors.white,
                                    width: 1),
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 25,
                                color: (Global.isDark == false)
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              hintText: "Search",
                              hintStyle: GoogleFonts.arya(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: (Global.isDark == false)
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              filled: true,
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: (Global.isDark == false)
                                          ? Colors.black
                                          : Colors.white,
                                      width: 1)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: (Global.isDark == false)
                                          ? Colors.black
                                          : Colors.white),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: (Global.isDark == false)
                                          ? Colors.black
                                          : Colors.white),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
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
                            setState(() {
                              Global.isDark = !Global.isDark;
                            });
                          },
                          child: const Icon(Icons.light_mode_outlined),
                        ),
                      ),
                    ],
                  ),
                  titlePadding: const EdgeInsets.only(left: 10, bottom: 20),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  CarouselSlider(
                    items: carouselItems.map((e) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                                () => const DetailPage(),
                            duration: const Duration(seconds: 1),
                            transition: Transition.fadeIn,
                            curve: Curves.easeInOut,
                            arguments: Global.newsList[e]['url'],
                          );
                        },
                        child: Container(
                          height: 350,
                          width: 300,
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 350,
                                  child: Image.network(
                                    (Global.newsList[e]['urlToImage'] == null)
                                        ? ""
                                        : Global.newsList[e]['urlToImage'],
                                    filterQuality: FilterQuality.high,
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                    loadingBuilder: (context, child, image) {
                                      if (image == null) return child;
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey.shade400,
                                        highlightColor: Colors.grey.shade300,
                                        child: Container(
                                          height: 170,
                                          width: double.infinity,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, _, __) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey.shade400,
                                        highlightColor: Colors.grey.shade300,
                                        child: Container(
                                          height: 170,
                                          width: double.infinity,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                height: 350,
                                width: double.infinity,
                                padding:
                                const EdgeInsets.only(left: 10, bottom: 7,top: 10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black12.withOpacity(0),
                                      Colors.black12.withOpacity(0),
                                      Colors.black45.withOpacity(0.2),
                                      Colors.black,
                                    ],
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    (Global.newsList[e]['title'] == null)
                                        ? ""
                                        : (Global.newsList[e]['title']
                                        .toString()
                                        .length >
                                        30)
                                        ? "${Global.newsList[e]['title'].toString().substring(0, 30)}..."
                                        : Global.newsList[e]['title'],
                                    style: GoogleFonts.play(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                      initialPage: currentPage,
                      onPageChanged: (val, _) {
                        setState(() {
                          currentPage = val;
                        });
                      },
                      autoPlay: true,
                      enlargeCenterPage: true,
                      autoPlayAnimationDuration: const Duration(seconds: 3),
                      viewportFraction: 0.9,
                      autoPlayInterval: const Duration(seconds: 3),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 7, left: 10, right: 10),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 28,
                    itemBuilder: (context, i) {
                      return (Global.newsList.isEmpty)
                          ? const Text("")
                          : GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => const DetailPage(),
                                  duration: const Duration(seconds: 1),
                                  transition: Transition.fadeIn,
                                  curve: Curves.easeInOut,
                                  arguments: Global.newsList[i]['url'],
                                );
                              },
                              child: Container(
                                height: 170,
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                color: Colors.transparent,
                                child: Card(
                                  elevation: 3,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: SizedBox(
                                          height: 170,
                                          child: Image.network(
                                            (Global.newsList[i]['urlToImage'] ==
                                                    null)
                                                ? ""
                                                : Global.newsList[i]
                                                    ['urlToImage'],
                                            filterQuality: FilterQuality.high,
                                            width: double.infinity,
                                            fit: BoxFit.fitWidth,
                                            loadingBuilder:
                                                (context, child, image) {
                                              if (image == null) return child;
                                              return Shimmer.fromColors(
                                                baseColor: Colors.grey.shade400,
                                                highlightColor:
                                                    Colors.grey.shade300,
                                                child: Container(
                                                  height: 170,
                                                  width: double.infinity,
                                                  color: Colors.grey,
                                                ),
                                              );
                                            },
                                            errorBuilder: (context, _, __) {
                                              return Shimmer.fromColors(
                                                baseColor: Colors.grey.shade400,
                                                highlightColor:
                                                    Colors.grey.shade300,
                                                child: Container(
                                                  height: 170,
                                                  width: double.infinity,
                                                  color: Colors.grey,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 7),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black12.withOpacity(0),
                                              Colors.black12.withOpacity(0),
                                              Colors.black45.withOpacity(0.2),
                                              Colors.black,
                                            ],
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                onPressed: ()async {
                                                  BookMarkNews b1 = BookMarkNews(
                                                    title: Global.newsList[i]['title'],
                                                    description: Global.newsList[i]['description'],
                                                    image: Global.newsList[i]['urlToImage'],
                                                    url: Global.newsList[i]['url'],
                                                  );
                                                  await DBHelper.dbHelper.insertData(data: b1);
                                                  Get.showSnackbar(
                                                    GetSnackBar(
                                                      title: 'News',
                                                      backgroundColor: Colors.indigo.shade100,
                                                      snackPosition: SnackPosition.BOTTOM,
                                                      borderRadius: 20,
                                                      duration: const Duration(seconds: 2),
                                                      margin: const EdgeInsets.all(15),
                                                      message: 'News added into bookmark list...',
                                                      snackStyle: SnackStyle.FLOATING,
                                                    ),
                                                  );
                                                  setState(() {
                                                    Global.i++;
                                                    if(Global.i%4==0){
                                                      if (AdHelper.adHelper.interstitialAd != null) {
                                                        AdHelper.adHelper.interstitialAd!.show();
                                                        AdHelper.adHelper.loadInterstitialAd();
                                                      }
                                                    }
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.bookmark,
                                                  color: Colors.white,
                                                  size: 22,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              (Global.newsList[i]['title'] ==
                                                      null)
                                                  ? ""
                                                  : (Global.newsList[i]['title']
                                                              .toString()
                                                              .length >
                                                          30)
                                                      ? "${Global.newsList[i]['title'].toString().substring(0, 30)}..."
                                                      : Global.newsList[i]
                                                          ['title'],
                                              style: GoogleFonts.play(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              (Global.newsList[i]
                                                          ['description'] ==
                                                      null)
                                                  ? ""
                                                  : (Global.newsList[i][
                                                                  'description']
                                                              .toString()
                                                              .length >
                                                          30)
                                                      ? "${Global.newsList[i]['description'].toString().substring(0, 30)}..."
                                                      : Global.newsList[i]
                                                          ['description'],
                                              style: GoogleFonts.lato(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
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
            BottomNavigationBarItem(
                icon: Icon(fav, size: 30), label: "Favorite"),
          ],
          currentIndex: 0,
        ),
      ),
    );
  }
}
