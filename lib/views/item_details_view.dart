
import 'package:flutter/material.dart';

import '../models/item_model.dart';
import '../utils/app_colors.dart';
import 'google_map_view.dart';

class ItemDetailsView extends StatefulWidget {
  const ItemDetailsView({required this.itemData});

  final ItemBean itemData;

  @override
  State<ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<ItemDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      GoogleMapView(itemData: widget.itemData),
                ),
              );
            },
          ),
        ],
        backgroundColor: AppColors.primaryColor,
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
                return Image.asset('assets/images/Image_not_available.png',
                    fit: BoxFit.fitWidth);
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
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Text(
                    widget.itemData.description!,
                    textAlign: TextAlign.left,
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
