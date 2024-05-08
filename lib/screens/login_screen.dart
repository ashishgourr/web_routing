import 'package:flutter/material.dart';
import 'package:web_routing/router/route_delegate.dart';
import 'package:web_routing/router/route_handeler.dart';
import 'package:web_routing/database/hive_storage_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 80,
                  width: 350,
                  child: TextFormField(
                    validator: (String? validator) {
                      if (validator!.isEmpty) {
                        return "Enter valid username";
                      }
                      return null;
                    },
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                        hintText: 'Enter username'),
                  ),
                ),
                SizedBox(
                  height: 80,
                  width: 350,
                  child: TextFormField(
                    validator: (String? validator) {
                      if (validator!.isEmpty) {
                        return "Enter valid password";
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter password'),
                  ),
                ),
                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextButton(
                    onPressed: () => _loginUser(),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _loginUser() async {
    if (_formKey.currentState!.validate()) {
      await HiveDataStorageService.logUserIn();
      CustomRouterDelegate().setPathName(RouteData.home.name);
    }
  }
}
