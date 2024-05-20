import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/base/show_custom_message.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/page/auth/sign_up_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/app_icon.dart';
import 'package:food_app/widget/app_text_field.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    var signUpImage = ["f.png", "g.png"];

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnachBar("Please enter your email!", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnachBar("Please enter a valid email!",
            title: "Email is not valid");
        showCustomSnachBar("Please enter your email!", title: "Email");
      } else if (password.isEmpty) {
        showCustomSnachBar("Please enter your password!", title: "Password");
      } else if (password.length <= 5) {
        showCustomSnachBar("Password must have more 6 characters!",
            title: "Password");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
            print("login ok");
          } else {
            showCustomSnachBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          //color: Colors.amber,
                          margin: EdgeInsets.only(top: Dimensions.height20 * 2),
                          width: Dimensions.screenWidth * 0.9,
                          child: Positioned(
                            left: Dimensions.height20,
                            top: Dimensions.height45,
                            right: Dimensions.width20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: AppIcon(
                                    icon: Icons.arrow_back_ios,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.iconSize24,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(RouteHelper.getInitial());
                                  },
                                  child: AppIcon(
                                    icon: Icons.home_outlined,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.iconSize24,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: Dimensions.screenHeight * 0.20,
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 60,
                              backgroundImage:
                                  AssetImage("assets/image/logo part 1.png"),
                            ),
                          ),
                        ),
                        Text(
                          "Sign In",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AppTextField(
                            textController: emailController,
                            labelText: "Email",
                            icon: Icons.email),
                        AppTextField(
                          textController: passwordController,
                          labelText: "Password",
                          icon: Icons.password,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        GestureDetector(
                          onTap: () {
                            _login(authController);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: Dimensions.width20,
                                right: Dimensions.width20),
                            width: double.maxFinite,
                            height: Dimensions.screenHeight / 15,
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius10),
                            ),
                            child: Center(
                              child: BigText(
                                text: "Login",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: Dimensions.height15,
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RichText(
                                text: TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.back(),
                                  text: "Forgot password",
                                  style: TextStyle(
                                    color: Colors.red[400],
                                    fontSize: Dimensions.font16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        RichText(
                          text: TextSpan(
                            //recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font16,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => SignUpPage()),
                                text: "Create",
                                style: TextStyle(
                                  color: AppColors.mainColor,
                                  fontSize: Dimensions.font16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        RichText(
                          text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.back(),
                            text: "Log in with",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font16,
                            ),
                          ),
                        ),
                        Wrap(
                          children: List.generate(
                              signUpImage.length,
                              (index) => Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: CircleAvatar(
                                      radius: Dimensions.radius20,
                                      backgroundImage: AssetImage(
                                          "assets/image/" + signUpImage[index]),
                                    ),
                                  )),
                        ),
                      ],
                    ),
                  ),
                )
              : CustomLoader();
        }));
  }
}
