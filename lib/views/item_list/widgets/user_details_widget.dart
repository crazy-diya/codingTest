import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../utils/app_colors.dart';
import '../../login_view/login_view.dart';

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            email,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                border: Border.all(width: 1, color: AppColors.primaryColor),
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
    );
  }
}
