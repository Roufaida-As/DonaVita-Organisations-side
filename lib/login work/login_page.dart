import 'package:flutter/material.dart';
import 'package:secondapp/Theme/colors.dart';
import 'package:secondapp/login%20work/forgot_password_page.dart';
import 'package:secondapp/login%20work/services.dart';
import 'package:secondapp/login%20work/signup_page.dart';
import 'package:secondapp/utils/button.dart';
import 'package:secondapp/utils/item_border.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hidePassword = true;
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController pwcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void togglePassword() {
      setState(() {
        hidePassword = !hidePassword;
      });
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //logo
              const SizedBox(height: 50),

              Image.asset("assets/logo 2.png", width: 130, height: 102.78),
              const SizedBox(height: 10),
              const Text(
                "Login",
                style: TextStyle(
                  color: AppColors.icons,
                  fontSize: 38,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              ),
              //Hi welcome back
              const Text(
                "Hi, welcome back !",
                style: TextStyle(
                  color: AppColors.highicons,
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                    child: Text('Email',
                        style: TextStyle(
                            color: AppColors.icons,
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: TextFormField(
                      controller: emailcontroller,
                      validator: (value) {
                        if (!RegExp(
                                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                            .hasMatch(value!)) {
                          return 'wrong email format';
                        }
                        if (value.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: AppColors.icons, width: 2.16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: AppColors.icons, width: 2.16),
                          ),
                          hintText: "Enter your organisation email",
                          hintStyle: const TextStyle(
                              color: AppColors.smalltext, fontSize: 15),
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: AppColors.icons,
                          )),
                    ),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                    child: Text('Password',
                        style: TextStyle(
                            color: AppColors.icons,
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: TextFormField(
                      controller: pwcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password is required";
                        }
                        return null;
                      },
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: AppColors.icons, width: 2.16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: AppColors.icons, width: 2.16),
                          ),
                          hintText: "Enter Your password",
                          hintStyle: const TextStyle(
                              color: AppColors.smalltext, fontSize: 15),
                          suffixIcon: IconButton(
                              onPressed: () {
                                togglePassword();
                              },
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.icons,
                              )),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: AppColors.icons,
                          )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const forgetPassword(),
                        ));
                      },
                      child: const Text(
                        'forgot password?',
                        style: TextStyle(
                            fontSize: 12.95,
                            fontFamily: 'Nunito',
                            color: AppColors.highicons,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              //login button
              Button(
                buttonText: 'Login',
                onTap: () => login(),
              ),
              const SizedBox(height: 40),
              const Text(
                "Or sign in with",
                style: TextStyle(
                  color: AppColors.smalltext,
                  fontSize: 12.95,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(width: 23),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Border_(imagePath: 'assets/gg.png'),
                  SizedBox(width: 36),
                  Border_(imagePath: 'assets/fb.png'),
                ],
              ),
              const SizedBox(height: 33),
              // sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "You don't have an account?",
                    style: TextStyle(
                      color: AppColors.smalltext,
                      fontFamily: 'Nunito',
                      fontSize: 17.26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const SignUp()));
                    },
                    child: const Text(
                      "Sign up now",
                      style: TextStyle(
                        color: AppColors.highicons,
                        fontFamily: 'Nunito',
                        fontSize: 17.26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Image.asset("assets/Name.png", width: 64, height: 19),
            ]),
          ),
        ),
      ),
    );
  }

  void login() async {
    Services.loginn(emailcontroller.text.trim(), pwcontroller.text.trim());
  }
}
