import 'package:chat_app/providers/user/user.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:chat_app/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolfizutils/wolfizutils.dart';

import '../../core/custom_textfield.dart';
import '../../utils/colors.dart';
import '../../utils/loading.dart';

class SignUp extends ConsumerWidget {
  SignUp({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _createNewUser(BuildContext context, WidgetRef ref) async {
    loading(context);
    final userNotifier = ref.read(userProvider.notifier);
    await userNotifier.createUser(
      email: emailController.text,
      password: passwordController.text,
    );

    await FirebaseServices()
        .saveToCollection(emailController.text, nameController.text);

    // ignore: use_build_context_synchronously
    notLoading(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 112.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: "Sign Up",
                  fontClr: AppColors.primaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
                52.hb,
                MyCustomTextField(
                  controller: emailController,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                35.hb,
                MyCustomTextField(
                  controller: nameController,
                  hintText: "Name",
                  keyboardType: TextInputType.name,
                ),
                35.hb,
                MyCustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  keyboardType: TextInputType.visiblePassword,
                ),
                40.hb,
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
                    onPressed: () => _createNewUser(context, ref),
                    child: MyText(
                      text: "Sign Up",
                      fontClr: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                15.hb,
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () =>
                        Navigator.of(context).pushNamed(AppRoutes.signIn),
                    child: MyText(
                        text: "Already have an account? Sign In",
                        fontSize: 11,
                        fontClr: AppColors.primaryColor),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
