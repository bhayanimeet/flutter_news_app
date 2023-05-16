import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../res/global.dart';
import 'package:share_plus/share_plus.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late InAppWebViewController inAppWebViewController;
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: Colors.blue),
      onRefresh: () async {
        await inAppWebViewController.reload();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String url = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Explore news!",
          style: GoogleFonts.poppins(
            fontSize: 23,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: (Global.isDark == false)
            ? const Color(0xffe9e2f1)
            : const Color(0xff35313f),
        centerTitle: true,
        elevation: 15,
        actions: [
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Share.share(url);
            },
            icon: const Icon(Icons.share, size: 30),
          ),
        ],
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(url)),
        onWebViewCreated: (controller) {
          setState(() {
            inAppWebViewController = controller;
          });
        },
        pullToRefreshController: pullToRefreshController,
        onLoadStart: (controller, url) async {
          await pullToRefreshController.endRefreshing();
        },
      ),
    );
  }
}
