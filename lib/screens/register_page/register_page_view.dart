import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:news/helpers/global.dart';
import 'package:news/widgets/custom_widet.dart';
import 'package:news/widgets/reoute_navigator.dart';
import './register_page_view_model.dart';

class RegisterPageView extends RegisterPageViewModel {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return CustomScaffold(
      body: Stack(
        children: [
          Image.asset(
            ImageBoarding.register,
            width: width,
            height: height * 0.85,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: height * 0.41,
            left: width * 0.05,
            child: InkWell(
              onTap: () {
                backScreen(context);
              },
              child: Container(
                width: width * 0.1,
                height: width * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: width * 0.05,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: width,
              height: height * 0.4,
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(width * 0.1),
                  topLeft: Radius.circular(width * 0.1),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  sarabunText(
                    width * 0.05,
                    "Register",
                    fw: FontWeight.bold,
                    ta: TextAlign.center,
                    th: 1.2,
                  ),
                  Column(
                    children: [
                      inputRegister(username, "Username"),
                      inputRegister(email, "Email"),
                      inputRegister(password, "Password", isPassword: true),
                      inputRegister(reTypePassword, "Ketik Ulang Password",
                          isPassword: true),
                    ],
                  ),
                  registerButton()
                ],
              ),
            ),
          ),
          isLoading ? isLoadActionPage(width, height) : SizedBox()
        ],
      ),
    );
  }

  Widget inputRegister(
    TextEditingController controller,
    String hint, {
    bool isPassword = false,
  }) {
    return Container(
      height: height * 0.05,
      width: width,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.005,
      ),
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(width * 0.01),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? isVisible : false,
        style: TextStyle(fontSize: width * 0.033),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(fontSize: width * 0.033),
          suffixIcon: isPassword
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(height * 0.001),
                    child: Icon(
                      isVisible ? FontAwesome.eye_slash : FontAwesome.eye,
                      size: width * 0.04,
                      color: ClassColors.maincolor,
                    ),
                  ),
                )
              : SizedBox(),
          suffixIconConstraints: BoxConstraints(minHeight: 0, minWidth: 0),
        ),
      ),
    );
  }

  Widget registerButton() {
    return InkWell(
      onTap: () {
        registerAction();
      },
      child: Container(
        height: height * 0.05,
        decoration: BoxDecoration(
          color: ClassColors.maincolor,
          borderRadius: BorderRadius.circular(width * 0.012),
        ),
        margin: EdgeInsets.symmetric(horizontal: width * 0.17),
        padding: EdgeInsets.symmetric(
          vertical: height * 0.01,
          horizontal: width * 0.05,
        ),
        child: Center(
          child: sarabunText(
            width * 0.04,
            "Daftar",
            ta: TextAlign.center,
            color: Colors.white,
            fw: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
