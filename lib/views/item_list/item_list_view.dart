import 'package:coding_test/views/item_list/widgets/alert_box.dart';
import 'package:coding_test/views/widgets/list_tile_widget.dart';
import 'package:coding_test/views/item_list/widgets/user_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../models/item_model.dart';
import '../../services/api_helper.dart';
import '../../utils/app_colors.dart';
import '../item_details/item_details_view.dart';
import '../login_view/login_view.dart';

class ItemListViewBean {
  final String name;
  final String email;

  ItemListViewBean({required this.name, required this.email});
}

class ItemListView extends StatefulWidget {
  final ItemListViewBean itemListViewBean;

  const ItemListView({required this.itemListViewBean});

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  List<ItemDataBean> list = [];
  ApiHelper apiHelper = ApiHelper();
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getItemList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List View",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: isLoaded
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    children: [
                      Text(
                        widget.itemListViewBean.name,
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        widget.itemListViewBean.email,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      InkWell(
                        onTap: () {
                          FacebookAuth.instance.logOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginView(),
                              ),
                              (route) => false);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            border: Border.all(
                                width: 0, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "Log Out",
                            style: TextStyle(
                              fontSize: 17.5,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: ListView.builder(
                      itemCount: list.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTileWidget(
                          itemList: list,
                          index: index,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ItemDetailView(itemData: list[index]),
                              ),
                            );
                          },
                        );
                      }),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
    );
  }

  Future<void> getItemList() async {
    try {
      final data = await apiHelper.get(
          'https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue/hotels.json');
      setState(() {
        list = ItemList.fromJson(data).data!;
        isLoaded = true;
      });
    } on Exception catch (e) {
      setState(() {
        isLoaded = true;
      });
      alertBox(
        context: context,
        error: e.toString(),
        onButtonTap: () {
          FacebookAuth.instance.logOut();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginView(),
              ),
              (route) => false);
        },
      );
    }
  }
}
