import 'package:chat/constans/colors.dart';
import 'package:chat/helper/show_snack_bar.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/signup_screen.dart';
import 'package:chat/theme/theme_provider.dart';
import 'package:chat/widgests/custom_switch.dart';
import 'package:chat/widgests/material_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../cubit/login_cubit/login_cubit.dart';
import '../cubit/login_cubit/login_state.dart';
import '../widgests/text_form_field.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key,});
  String? email, password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (BuildContext context, Object? state) {
        if(state is LoginLoading){isLoading=true;}
        else if(state is LoginSuccess){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(email: email!)));
          isLoading = false;
        }
        else if(state is LoginFailed){
          isLoading = false;
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) => Container(

            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  Theme.of(context).brightness == Brightness.dark
                      ? 'assets/images/stars.jpeg'
                      : 'assets/images/morning.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                       Align(
                        alignment: Alignment.centerRight,
                         child: CustomSwitch(
                                            value: Theme.of(context).brightness == Brightness.dark,
                                             onChanged: (value) {
                                               themeProvider.toggleTheme();
                                             }),
                       ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Image(
                        image: AssetImage('assets/images/s-removebg-preview.png'),
                        width: 250,
                        height: 250,
                      ),
                      const Center(
                        child: Text(
                          'ChatSprint',
                          style: TextStyle(
                            fontFamily: 'Schyler',
                            height: .5,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Email is required';
                          } else if (value!.length < 3) {
                            return 'Enter a valid email';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          email = value;
                        },
                        hintText: 'email',
                        keyboard: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        pass: true,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Password is required';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          password = value;
                        },
                        hintText: 'password',
                        keyboard: TextInputType.visiblePassword,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                       CustomButton(
                        text: 'Login',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<LoginCubit>(context).signUser(email: email, password: password);
                          } else {}
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupScreen()));
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color(0xffD6F7E7),
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}