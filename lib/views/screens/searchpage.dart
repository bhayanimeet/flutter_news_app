import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../components/bookmark_news_controller.dart';
import '../../components/google_ads_controller.dart';
import '../../models/bookmark_news_model.dart';
import '../../res/global.dart';
import 'detailpage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  void getNews() async {
    String api =
        'https://newsapi.org/v2/everything?q=${Global.text}&from=2023-04-20&to=2023-05-12&sortBy=popularity&apiKey=c45f8dc15c8149f69c961bb011f693d6';
    var result = await Dio().get(api);

    if (result.statusCode == 200) {
      setState(() {
        Global.categoriesList = result.data['articles'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  void dispose() {
    super.dispose();
    Global.text = '';
    Global.textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                title: SizedBox(
                  height: 50,
                  width: 200,
                  child: Text(
                    "${Global.text} news",
                    style: GoogleFonts.arya(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                titlePadding: const EdgeInsets.only(left: 10, bottom: 4),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 7, left: 10, right: 10),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 28,
                  itemBuilder: (context, i) {
                    return (Global.categoriesList.isEmpty)
                        ? const Text("")
                        : GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const DetailPage(),
                                duration: const Duration(seconds: 1),
                                transition: Transition.fadeIn,
                                curve: Curves.easeInOut,
                                arguments: Global.categoriesList[i]['url'],
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
                                          (Global.categoriesList[i]
                                                      ['urlToImage'] ==
                                                  null)
                                              ? ""
                                              : Global.categoriesList[i]
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            (Global.categoriesList[i]
                                                        ['title'] ==
                                                    null)
                                                ? ""
                                                : (Global.categoriesList[i]
                                                                ['title']
                                                            .toString()
                                                            .length >
                                                        30)
                                                    ? "${Global.categoriesList[i]['title'].toString().substring(0, 30)}..."
                                                    : Global.categoriesList[i]
                                                        ['title'],
                                            style: GoogleFonts.play(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            (Global.categoriesList[i]
                                                        ['description'] ==
                                                    null)
                                                ? ""
                                                : (Global.categoriesList[i]
                                                                ['description']
                                                            .toString()
                                                            .length >
                                                        30)
                                                    ? "${Global.categoriesList[i]['description'].toString().substring(0, 30)}..."
                                                    : Global.categoriesList[i]
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
    );
  }
}
