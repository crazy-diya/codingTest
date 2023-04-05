import 'dart:async';

import 'package:coding_test/views/widgets/curve_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../utils/app_colors.dart';
import '../../utils/navigation_routes.dart';
import '../item_list/item_list_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    _timer = Timer(const Duration(seconds: 15), () {
      Navigator.pushNamed(
        context,
        Routes.kItemListView,
        arguments: ItemListViewBean(
            name: "Dimuthu Lakshan", email: "dimuthulakshan2012@gmail.com"),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/fc_bg.jpeg",
              ),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 200,
                  child: Text(
                    'Welcome to the Facebook Login !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    facebookLogin();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 60.0,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Login with',
                          style: TextStyle(
                            color: AppColors.blueColor,
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Icon(
                          Icons.facebook,
                          color: AppColors.blueColor,
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      facebookLogin();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Sign up with',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Icon(
                              Icons.facebook,
                              color: Colors.white,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  facebookLogin() async {
    try {
      final result =
          await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();
        print('facebook_login_data:-');
        print(userData);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ItemListView(
                      itemListViewBean: ItemListViewBean(
                          name: userData['name'], email: userData['email']),
                    )));
      }
    } catch (error) {
      print(error);
    }
  }
}
