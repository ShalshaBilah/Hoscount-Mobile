import 'package:hoscountmobile/bloc/profil/profil_bloc.dart';
import 'package:hoscountmobile/bloc/profil/profil_event.dart';
import 'package:hoscountmobile/bloc/profil/profil_state.dart';
import 'package:hoscountmobile/data/localsources/auth_local_storage.dart';
import 'package:hoscountmobile/screen/ResetPasswordScreen.dart';
import 'package:hoscountmobile/screen/change_password.dart';
import 'package:hoscountmobile/screen/edit_profile_page.dart';
import 'package:hoscountmobile/screen/forgot_password_page.dart';
import 'package:hoscountmobile/screen/login_page.dart';
import 'package:hoscountmobile/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProfileLoaded) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [Colors.purple, Colors.orange],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 5.0,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                      state.profile.avatar ??
                                          'https://gravatar.com/avatar/80e178804e023758d3e51ae6e296861f?s=400&d=robohash&r=x',
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfilePage()),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              state.profile.name ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              state.profile.email ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const Text("No data available");
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: size.height * .43,
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfileWidget(
                              icon: Icons.lock_outline,
                              title: 'Change Password',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangePasswordScreen()),
                                );
                              },
                            ),
                            ProfileWidget(
                              icon: Icons.email_outlined,
                              title: 'Reset Password',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ResetPasswordPage()),
                                );
                              },
                            ),
                            ProfileWidget(
                              icon: Icons.email_outlined,
                              title: 'Forgot Password',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordPage()),
                                );
                              },
                            ),
                            ProfileWidget(
                              icon: Icons.logout,
                              title: 'Log Out',
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Confirmation"),
                                      content: const Text(
                                          "Are you sure you want to log out?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await AuthLocalStorage()
                                                .removeToken();
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage(),
                                              ),
                                              (Route<dynamic> route) => false,
                                            );
                                          },
                                          child: const Text("Log Out"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
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

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
          vertical: 4, horizontal: 12), // Kurangi margin
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      shadowColor: Colors.purple.withOpacity(0.5),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        splashColor: Colors.purple.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 6, horizontal: 12), // Kurangi padding
          child: ListTile(
            leading: Icon(icon, color: Colors.purple),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14, // Ukuran font lebih kecil
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
              size: 14, // Ukuran icon lebih kecil
            ),
          ),
        ),
      ),
    );
  }
}
