import 'package:chat/cubit/signup_cubit/signup_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> registerUser({required String email, required String password}) async {
    emit(SignupLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        // Send email verification
        await user.sendEmailVerification();
        emit(SignupSuccess(message: 'Account created. Please verify your email.'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignupFailed(errorMessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignupFailed(errorMessage: 'The account already exists for that email.'));
      } else {
        emit(SignupFailed(errorMessage: 'Enter valid data.'));
      }
    } on Exception catch (_) {
      emit(SignupFailed(errorMessage: 'Something went wrong'));
    }
  }
}
