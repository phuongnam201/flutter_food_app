import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_appbar.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/base/show_custom_message.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/models/signup_body_model.dart';
import 'package:food_app/page/auth/sign_in_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/app_icon.dart';
import 'package:food_app/widget/app_text_field.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
    var rePasswordController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImage = ["f.png", "g.png"];

    void _registration() {
      var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String rePassword = rePasswordController.text.trim();

      if (name.isEmpty) {
        showCustomSnachBar("Vui lòng điền tên của bạn!", title: "Tên");
      } else if (email.isEmpty) {
        showCustomSnachBar("Vui lòng điền email của bạn!", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnachBar("Vui lòng điền email hợp lệ!",
            title: "Email không hợp lệ");
        //showCustomSnachBar("Please enter your email!", title: "Email");
      } else if (password.isEmpty) {
        showCustomSnachBar("Vui lòng điền mật khẩu!", title: "Mật khẩu");
      } else if (password.length <= 5) {
        showCustomSnachBar("Mật khẩu phải có ít nhất 6 kí tự!",
            title: "Mật khẩu");
      } else if (rePassword != password) {
        showCustomSnachBar("Mật khẩu không khớp!", title: "Mật khẩu");
      } else if (phone.isEmpty) {
        showCustomSnachBar("Vui lòng điền số điện thoại",
            title: "Số điện thoại");
      } else {
        SignUpBody signUpBody = SignUpBody(
            name: name, email: email, phone: phone, password: password);
        //print(signUpBody.toJson());
        //print("result" + authController.registration(signUpBody).toString());
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("ok");
          } else {
            showCustomSnachBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      appBar: CustomAppBar(title: "Đăng kí"),
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController) {
        return !_authController.isLoading
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Container(
                    //   //color: Colors.amber,
                    //   margin: EdgeInsets.only(top: Dimensions.height20 * 2),
                    //   width: Dimensions.screenWidth * 0.9,
                    //   child: Positioned(
                    //     left: Dimensions.height20,
                    //     top: Dimensions.height45,
                    //     right: Dimensions.width20,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         GestureDetector(
                    //           onTap: () {
                    //             Navigator.pop(context);
                    //           },
                    //           child: AppIcon(
                    //             icon: Icons.arrow_back_ios,
                    //             iconColor: Colors.white,
                    //             iconSize: Dimensions.iconSize24,
                    //             backgroundColor: AppColors.mainColor,
                    //           ),
                    //         ),
                    //         GestureDetector(
                    //           onTap: () {
                    //             Get.toNamed(RouteHelper.getInitial());
                    //           },
                    //           child: AppIcon(
                    //             icon: Icons.home_outlined,
                    //             iconColor: Colors.white,
                    //             iconSize: Dimensions.iconSize24,
                    //             backgroundColor: AppColors.mainColor,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
                      "Nhập thông tin đăng kí",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                        textController: nameController,
                        labelText: "Tên",
                        icon: Icons.person),
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
                    AppTextField(
                      textController: rePasswordController,
                      labelText: "Xác nhận mật khẩu",
                      icon: Icons.password,
                      obscureText: true,
                    ),
                    AppTextField(
                      textController: phoneController,
                      labelText: "Số điện thoại",
                      icon: Icons.phone,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _registration();
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
                            text: "Đăng kí",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    RichText(
                      text: TextSpan(
                        //recognizer: TapGestureRecognizer()
                        // ..onTap = () => Get.to(() => SignInPage()),
                        text: "Bạn đã có tài khoản ? ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.font16,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(() => SignInPage()),
                            text: "Đăng nhập ngay!",
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
                    // RichText(
                    //   text: TextSpan(
                    //     recognizer: TapGestureRecognizer()
                    //       ..onTap = () => Get.back(),
                    //     text: "Sign up using one of the following methods",
                    //     style: TextStyle(
                    //       color: Colors.grey[500],
                    //       fontSize: Dimensions.font16,
                    //     ),
                    //   ),
                    // ),
                    // Wrap(
                    //   children: List.generate(
                    //       signUpImage.length,
                    //       (index) => Padding(
                    //             padding: EdgeInsets.all(10.0),
                    //             child: CircleAvatar(
                    //               radius: Dimensions.radius20,
                    //               backgroundImage: AssetImage(
                    //                   "assets/image/" + signUpImage[index]),
                    //             ),
                    //           )),
                    // ),
                  ],
                ),
              )
            : const CustomLoader();
      }),
    );
  }
}
