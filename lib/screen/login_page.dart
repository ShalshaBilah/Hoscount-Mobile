import 'package:hoscountmobile/screen/forgot_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hoscountmobile/bloc/login/login_bloc.dart';
import 'package:hoscountmobile/data/localsources/auth_local_storage.dart';
import 'package:hoscountmobile/data/model/requests/login_model.dart';
import 'package:hoscountmobile/screen/register_page.dart';
import 'package:hoscountmobile/ui/root_page.dart';

class TextInput extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;

  const TextInput({
    required this.icon,
    required this.hint,
    required this.inputType,
    required this.inputAction,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: Colors.black),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black),
        ),
        keyboardType: inputType,
        textInputAction: inputAction,
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextInputAction inputAction;
  final TextEditingController controller;

  const PasswordInput({
    required this.icon,
    required this.hint,
    required this.inputAction,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: Colors.black),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.black),
        ),
        obscureText: true,
        textInputAction: inputAction,
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const RoundedButton({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 112, 8),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    isLogin();
    Future.delayed(const Duration(seconds: 2));
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
    super.initState();
  }

  void isLogin() async {
    final isTokenExist = await AuthLocalStorage().isTokenExist();
    if (isTokenExist) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RootPage()),
      );
    }
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade200,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: SafeArea(
              child: FadeTransition(
                opacity: _animation,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      height: 40,
                      child: const Center(
                        child: Text(
                          'Hoscount',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Image.asset(
                      'assets/images/logo.png', // Update with your logo path
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          TextInput(
                            icon: FontAwesomeIcons.solidEnvelope,
                            hint: 'Email',
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.next,
                            controller: emailController!,
                          ),
                          PasswordInput(
                            icon: FontAwesomeIcons.lock,
                            hint: 'Password',
                            inputAction: TextInputAction.done,
                            controller: passwordController!,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordPage()),
                                );
                              },
                              child: const Text(
                                'Lupa Password?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          BlocConsumer<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state is LoginLoaded) {
                                emailController!.clear();
                                passwordController!.clear();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text('Success login'),
                                  ),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const RootPage()),
                                );
                              } else if (state is LoginError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(state.message),
                                  ),
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is LoginLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return RoundedButton(
                                buttonText: 'Login',
                                onPressed: () {
                                  final requestModel = LoginModel(
                                    email: emailController!.text,
                                    password: passwordController!.text,
                                  );
                                  context.read<LoginBloc>().add(
                                      DoLoginEvent(loginModel: requestModel));
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const RegisterPage();
                              }));
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                              ),
                              child: const Text(
                                'Belum Punya Akun? Daftar',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
