import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_appbar.dart';
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
        showCustomSnachBar("Vui lòng điền email của bạn!", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnachBar("Hãy điền một email hợp lệ!",
            title: "Email is not valid");
        // showCustomSnachBar("Please enter your email!", title: "Email");
      } else if (password.isEmpty) {
        showCustomSnachBar("Vui lòng điền mật khẩu", title: "Password");
      } else if (password.length <= 5) {
        showCustomSnachBar("Mật khẩu tối thiểu phải có 6 kí tự!",
            title: "Mật khẩu");
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
        appBar: CustomAppBar(title: "Đăng nhập"),
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
                        SizedBox(
                          height: 10,
                        ),
                        AppTextField(
                            textController: emailController,
                            labelText: "Email",
                            icon: Icons.email),
                        AppTextField(
                          textController: passwordController,
                          labelText: "Mật khẩu",
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
                                text: "Đăng nhập",
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
                                  text: "Quên mật khẩu",
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
                            text: "Bạn chưa có tài khoản? ",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font16,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => SignUpPage()),
                                text: "Đăng kí ngay!",
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
                            text: "Đăng nhập với",
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
