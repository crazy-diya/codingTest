import 'package:coding_test/utils/navigation_routes.dart';
import 'package:flutter/material.dart';

import '../../models/item_model.dart';
import '../../utils/app_colors.dart';
import '../google_map/google_map_view.dart';

class ItemDetailView extends StatefulWidget {
  const ItemDetailView({required this.itemData});

  final ItemDataBean itemData;

  @override
  State<ItemDetailView> createState() => _ItemDetailViewState();
}

class _ItemDetailViewState extends State<ItemDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
          const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Details",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 20.0, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(
                  context, Routes.kMapView, arguments: widget.itemData);
            },
          ),
        ],
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(children: [
          Expanded(
            flex: 1,
            child: Image.network(
              widget.itemData.image!.large!,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/no_image.png',
                  fit: BoxFit.fitWidth,
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    widget.itemData.title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Text(
                    widget.itemData.description!,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
