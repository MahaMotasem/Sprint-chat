import 'package:chat/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'cubit/login_cubit/login_cubit.dart';
import 'cubit/signup_cubit/signup_cubit.dart';
import 'firebase_options.dart';
import 'theme/theme_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignupCubit()),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(), 
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              themeMode: themeProvider.themeMode,
              theme: themeProvider.lightTheme,
              darkTheme: themeProvider.darkTheme,
              home: HomeScreen(), // Ensure HomeScreen is imported
            );
          },
        ),
      ),
    );
  }
}
