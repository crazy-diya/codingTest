import 'package:coding_test/models/item_model.dart';
import 'package:coding_test/views/google_map/google_map_view.dart';
import 'package:coding_test/views/item_details/item_details_view.dart';
import 'package:coding_test/views/item_list/item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../views/login_view/login_view.dart';
import '../views/splash/splash_view.dart';

class Routes {
  static const String kSplashView = "kSplashView";
  static const String kLoginView = "kLoginView";
  static const String kMapView = "kMapView";
  static const String kItemDetailView = "kItemDetailView";
  static const String kItemListView = "kItemListView";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.kSplashView:
        return PageTransition(
          child: SplashView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kSplashView),
        );
      case Routes.kLoginView:
        return PageTransition(
          child: LoginView(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kLoginView),
        );
      case Routes.kMapView:
        return PageTransition(
          child: MapView(
            itemData: settings.arguments as ItemDataBean,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kMapView),
        );
      case Routes.kItemDetailView:
        return PageTransition(
          child: ItemDetailView(
            itemData: settings.arguments as ItemDataBean,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kItemDetailView),
        );
      case Routes.kItemListView:
        return PageTransition(
          child: ItemListView(
            itemListViewBean: settings.arguments as ItemListViewBean,
          ),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kItemListView),
        );

      default:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const Scaffold(
            body: Center(
              child: Text("Invalid Route"),
            ),
          ),
        );
    }
  }
}
