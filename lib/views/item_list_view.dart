import 'package:coding_test/views/widgets/alert_box.dart';
import 'package:coding_test/views/widgets/list_tile_widget.dart';
import 'package:coding_test/views/widgets/user_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../models/item_model.dart';
import '../services/api_helper.dart';
import '../utils/app_colors.dart';
import 'item_details_view.dart';
import 'login_view.dart';

class ItemListScreen extends StatefulWidget {
  final String name;
  final String email;

  const ItemListScreen({required this.name, required this.email});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  List<ItemBean> hotelList = [];
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
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: isLoaded
          ? Column(
              children: [
                UserDetailsWidget(
                  email: widget.email,
                  name: widget.name,
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: ListView.builder(
                      itemCount: hotelList.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTileWidget(
                          hotelList: hotelList,
                          index: index,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ItemDetailsView(itemData: hotelList[index]),
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
        hotelList = ItemList.fromJson(data).data!;
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
