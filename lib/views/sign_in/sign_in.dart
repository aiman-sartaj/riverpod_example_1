import 'package:chat_app/core/custom_textfield.dart';
import 'package:chat_app/providers/user/user.dart';
import 'package:chat_app/routes/app_routes.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolfizutils/wolfizutils.dart';

import '../../utils/loading.dart';

class SignIn extends ConsumerWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignIn({super.key});
  Auth firebaseAuth = Auth();

  Future<void> _signIn(BuildContext context, WidgetRef ref) async {
    loading(context);
    final userNotifier = ref.read(userProvider.notifier);

    final user = await userNotifier.login(
      email: emailController.text,
      password: passwordController.text,
    );
    // ignore: use_build_context_synchronously
    notLoading(context);
    Navigator.of(context).pop();
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
                  text: "Sign In",
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
                    onPressed: () => _signIn(context, ref),
                    child: MyText(
                      text: "Sign In",
                      fontClr: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                15.hb,
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: MyText(
                        text: "Dont't have an account? Sign Up",
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
