import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/base/show_custom_message.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/models/signup_body_model.dart';
import 'package:food_app/page/auth/sign_in_page.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
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
        showCustomSnachBar("Please enter your name!", title: "Name");
      } else if (email.isEmpty) {
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
      } else if (rePassword != password) {
        showCustomSnachBar("Password does not match!", title: "Password");
      } else if (phone.isEmpty) {
        showCustomSnachBar("Please enter your phone number", title: "Phone");
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
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController) {
        return !_authController.isLoading
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
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
                      "Sign Up",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                        textController: nameController,
                        labelText: "Name",
                        icon: Icons.person),
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
                    AppTextField(
                      textController: rePasswordController,
                      labelText: "Confirm password",
                      icon: Icons.password,
                      obscureText: true,
                    ),
                    AppTextField(
                      textController: phoneController,
                      labelText: "Phone",
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
                            text: "Register",
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
                        text: "Have an account already? ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.font16,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(() => SignInPage()),
                            text: "Sign In",
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
                        text: "Sign up using one of the following methods",
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
              )
            : const CustomLoader();
      }),
    );
  }
}
