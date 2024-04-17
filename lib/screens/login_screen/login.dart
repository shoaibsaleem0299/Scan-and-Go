import 'package:flutter/material.dart';
import 'package:frontend/screens/navigation_screen/navigation_view.dart';
import 'package:frontend/screens/signup_screen/sign_up.dart';
import 'package:frontend/screens/splash_screen/splash.dart';
import 'package:frontend/widgets/app_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signIn() async {
    const url = 'http://10.0.2.2/api/signin.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': _emailController.text,
        'password': _passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      var sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool(SplashScreenState.loggedInKey, true);

      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const NavigationView(),
        ),
      );
    } else {
      // Registration failed
      // Handle error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid email or password.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

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
        backgroundColor: const Color.fromARGB(255, 2, 180, 70),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 170.0,
                  child: Text(
                    'Lets get started',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: 'e.g. JohnDoe@gmail.com',
                        hintStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 237, 237, 237),
                        prefixIcon: const Icon(Icons.email_sharp)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      hintText: '!@#^&%',
                      hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 237, 237, 237),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: const Icon(Icons.remove_red_eye_rounded),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Center(
                    child:
                        AppButton(buttonText: "Log In", onButtonTap: signIn)),
                const SizedBox(
                  height: 20.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Divider(
                      color: Colors.black,
                    ),
                    Text(
                      "Or",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 162.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the value as needed
                        color: const Color.fromARGB(
                            255, 237, 237, 237), // Background color
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.email_rounded,
                              color:
                                  Color.fromARGB(255, 2, 180, 70), // Icon color
                              size: 40.0,
                            ),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              "Google",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 162.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the value as needed
                        color: const Color.fromARGB(
                            255, 237, 237, 237), // Background color
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.facebook_sharp,
                              color: Colors.deepPurpleAccent, // Icon color
                              size: 40.0,
                            ),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              "Facebook",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "New to Here? Register Yourself",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        );
                      },
                      child: const Text(
                        " SignUp",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 2, 180, 70)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
