import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/base/custom_appbar.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/base/show_custom_message.dart';
import 'package:food_app/controller/auth_controller.dart';
import 'package:food_app/controller/user_controller.dart';
import 'package:food_app/models/signup_body_model.dart';
import 'package:food_app/models/update_model.dart';
import 'package:food_app/page/auth/sign_in_page.dart';
import 'package:food_app/routes/route_helper.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimension.dart';
import 'package:food_app/widget/app_icon.dart';
import 'package:food_app/widget/app_text_field.dart';
import 'package:food_app/widget/big_text.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    final UserController userController = Get.find<UserController>();
    userController.getUserInfo().then((_) {
      if (userController.userModel != null) {
        nameController.text = userController.userModel!.name;
        emailController.text = userController.userModel!.email;
        phoneController.text = userController.userModel!.phone;
      }
    });

    void _updateInfor() {
      var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnachBar("Vui lòng điền tên của bạn!", title: "Tên");
      } else if (email.isEmpty) {
        showCustomSnachBar("Vui lòng điền email của bạn!", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnachBar("Vui lòng điền email hợp lệ!",
            title: "Email không hợp lệ");
        //showCustomSnachBar("Please enter your email!", title: "Email");
      } else if (phone.isEmpty) {
        showCustomSnachBar("Vui lòng điền số điện thoại",
            title: "Số điện thoại");
      } else if (password.isNotEmpty && password.length <= 5) {
        showCustomSnachBar("Mật khẩu phải có ít nhất 6 kí tự!",
            title: "Mật khẩu");
      } else {
        UpdateModel updateModel = UpdateModel(
            name: name, email: email, phone: phone, password: password);
        //print(signUpBody.toJson());
        //print("result" + authController.registration(signUpBody).toString());
        authController.updateInfor(updateModel).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnachBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: "Cập nhật thông tin",
        backButtonExist: true,
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController) {
        return !_authController.isLoading
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
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
                    Text(
                      "Nhập thông tin của bạn",
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
                      textController: phoneController,
                      labelText: "Số điện thoại",
                      icon: Icons.phone,
                    ),
                    Container(
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            textController: passwordController,
                            labelText: "Mật khẩu",
                            icon: Icons.password,
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: Dimensions.width20),
                              width: Dimensions.screenWidth,
                              child: Text(
                                "* Vui lòng để trống mật khẩu nếu không thay đổi",
                                style: TextStyle(color: Colors.deepOrange),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    GestureDetector(
                      onTap: () {
                        _updateInfor();
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
                            text: "Lưu",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.05,
                    ),
                  ],
                ),
              )
            : const CustomLoader();
      }),
    );
  }
}
