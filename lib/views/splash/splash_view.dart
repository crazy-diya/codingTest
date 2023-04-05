import 'dart:async';

import 'package:coding_test/views/item_list/item_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import '../../utils/navigation_routes.dart';
import '../widgets/common_widgets.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  static bool loading = true;
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer(const Duration(seconds: 4), () {
      loading = false;
      Navigator.pushNamed(context, Routes.kLoginView,);
      // Navigator.pushNamed(
      //   context,
      //   Routes.kItemListView,
      //   arguments: ItemListViewBean(
      //       name: "Dimuthu Lakshan", email: "dimuthulakshan2012@gmail.com"),
      // );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.imgSplashBG), fit: BoxFit.cover),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizeVer(65),
                Center(
                  child: Text(
                    AppStrings.splashAppName,
                    style: GoogleFonts.aguafinaScript(
                        fontSize: 136, color: AppColors.fontWhiteColor),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 32, bottom: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        AppStrings.splashDesc1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: AppColors.fontWhiteColor),
                      ),
                      Text(
                        AppStrings.splashDesc2,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 47,
                          color: AppColors.fontWhiteColor,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.start,
                        AppStrings.splashDesc3,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 47,
                          color: AppColors.fontWhiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          loading == true
              ? const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.primaryColor,
                    strokeWidth: 2,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
