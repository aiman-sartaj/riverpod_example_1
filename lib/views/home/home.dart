import 'package:chat_app/providers/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolfizutils/wolfizutils.dart';

import '../../routes/app_routes.dart';
import '../../utils/colors.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SizedBox(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(ref.read(userProvider)!.email.toString()),
              10.hb,
              Container(
                width: double.maxFinite,
                height: 45.h,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.chat);
                  },
                  child: MyText(
                    text: "Get Started",
                    fontClr: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              20.hb,
              Container(
                width: double.maxFinite,
                height: 45.h,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: MaterialButton(
                  onPressed: () {
                    ref.read(userProvider.notifier).logout();
                  },
                  child: MyText(
                    text: "Logout",
                    fontClr: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
