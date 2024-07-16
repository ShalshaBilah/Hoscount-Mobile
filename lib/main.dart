import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoscountmobile/bloc/change_password/change_password_bloc.dart';
import 'package:hoscountmobile/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:hoscountmobile/bloc/login/login_bloc.dart';
import 'package:hoscountmobile/bloc/profil/profil_bloc.dart';
import 'package:hoscountmobile/bloc/register/register_bloc.dart';
import 'package:hoscountmobile/bloc/reset_password/reset_password_bloc.dart';
import 'package:hoscountmobile/data/datasources/auth_datasources.dart';
import 'package:hoscountmobile/screen/login_page.dart';

import 'package:hoscountmobile/screen/onboarding_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // BlocProvider untuk RegisterBloc
        BlocProvider(
          create: (context) => RegisterBloc(AuthDatasource()),
        ),
        // BlocProvider untuk LoginBloc
        BlocProvider(
          create: (context) => LoginBloc(AuthDatasource()),
        ),
        // BlocProvider untuk Bloc lainnya bisa ditambahkan di sini jika diperlukan
        BlocProvider(
          create: (context) => ProfileBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => ChangePasswordBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => ForgotPasswordBloc(AuthDatasource()),
        ),
        BlocProvider<ResetPasswordBloc>(
          create: (context) => ResetPasswordBloc(),
        ),
      ],
      child: const MyApp(), // Memisahkan MaterialApp ke widget terpisah
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Onboarding Screen',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hoscountmobile/provider/imagepick_provider.dart';
// import 'package:hoscountmobile/provider/auth_provider.dart';
// import 'package:hoscountmobile/screen/home_screen.dart';
// import 'package:hoscountmobile/screen/login_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => Vider()),
//         ChangeNotifierProvider(create: (_) => ImagePickProvider())
//       ],
//       child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Flutter Demo',
//           darkTheme: ThemeData(
//               brightness: Brightness.dark, primarySwatch: Colors.green),
//           themeMode: ThemeMode.dark,
//           home: StreamBuilder(
//               stream: FirebaseAuth.instance.authStateChanges(),
//               builder: (ctx, snapshot) {
//                 if (snapshot.hasData) {
//                   return const LoginScreen();
//                 }
//                 return const HomePage();
//               })),
//     );
//   }
// }
