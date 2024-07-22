import 'package:flutter/material.dart';
import 'package:frontend/constants/app_colors.dart';
import 'package:frontend/screens/signup_screen/sign_up.dart';
import 'package:frontend/ui_functions/login_function.dart';
import 'package:frontend/widgets/app_button.dart';
import 'package:frontend/widgets/custom_user_inputfield.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "SignIn",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColor.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 170.0,
                      child: Text(
                        "Let's Get Started",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    UserInputField(
                      labelText: "Email",
                      prefixIcon: "email",
                      nullText: "Email",
                      boolText: false,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 16),
                    UserInputField(
                      labelText: "Password",
                      prefixIcon: "password",
                      nullText: "Password",
                      boolText: true,
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 16.0),
                    if (_errorMessage.isNotEmpty)
                      Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: AppButton(
                        buttonText: "Log In",
                        onButtonTap: () {
                          setState(() {
                            _errorMessage = '';
                          });
                          LoginFunction.signIn(
                            context,
                            _emailController,
                            _passwordController,
                            _formKey,
                            (errorMessage) {
                              setState(() {
                                _errorMessage = errorMessage;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have An Account? ",
                            style: TextStyle(fontSize: 16)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignupScreen()));
                          },
                          child: Text(
                            " SignUp",
                            style: TextStyle(
                                fontSize: 16, color: AppColor.primary),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
