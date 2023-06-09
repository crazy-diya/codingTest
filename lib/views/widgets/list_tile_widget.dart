import 'package:flutter/material.dart';

import '../../models/item_model.dart';
import '../../utils/app_colors.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.itemList,
    required this.index,
    required this.onTap,
  });

  final int index;
  final Function() onTap;
  final List<ItemDataBean> itemList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            leading: ClipOval(
              child: Image.network(
                itemList[index].image!.medium!,
                height: 60.0,
                width: 60.0,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60.0,
                    alignment: Alignment.center,
                    child: const Text(
                      'Image Not Loading',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 11, color: AppColors.primaryColor),
                    ),
                  );
                },
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 7.5),
              child: Text(
                itemList[index].title!,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            subtitle: Text(
              itemList[index].address!,
              style: const TextStyle(
                fontSize: 13.0,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Divider(
              thickness: 2.0,
            ),
          ),
        ],
      ),
    );
  }
}
