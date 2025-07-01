import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:social_app/core/constants/const.dart';
import 'package:social_app/core/storage/shared_pref_utils.dart';

import '../../../core/utils/navigation_manager.dart';

import 'package:google_sign_in/google_sign_in.dart';


abstract class SignUpState{}

class SignUpSuccess extends SignUpState{}
class SignUpFailed extends SignUpState{}

final auth = FirebaseAuth.instance;

class SignUpWithEmailPassword extends Cubit {
  SignUpWithEmailPassword() : super(null);

  Future<void> signUpWithEmail(String email, String password) async {
    emit(EasyLoading.show());
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = auth.currentUser;
      Future.delayed(Duration(seconds: 1));
      if (user!= null) {
        emit(SignUpSuccess());
      }
      else{
        Const.toastFail("Something went wrong");
      }
      SharedPrefUtils.setIsUserLoggedIn(true);
      emit(EasyLoading.dismiss());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(EasyLoading.dismiss());
        Const.toastFail('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        emit(EasyLoading.dismiss());
        Const.toastFail('The account already exists for that email.');
      } else {
        emit(EasyLoading.dismiss());
        Const.toastFail(e.toString());
      }
    } catch (e) {
      emit(EasyLoading.dismiss());
      Const.toastFail(e.toString());
    }
  }
}

class SignUpWithGoogle extends Cubit {
  SignUpWithGoogle() : super(null);

  Future<void> signUpWithEmail() async {}
}


/// This Cubit manages the phone authentication flow:
/// - Sends OTP
/// - Verifies OTP
/// - Emits verificationId as state
class PhoneAuthCubit extends Cubit<String?> {
  PhoneAuthCubit() : super(null); // state holds verificationId

  /// Send OTP to phone number
  Future<void> sendOtp(String phoneNumber) async {
    EasyLoading.show(status: 'Sending OTP...');

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-sign in (Android only)
        try {
          await auth.signInWithCredential(credential);
          EasyLoading.dismiss();
        } catch (e) {
          EasyLoading.dismiss();
          Const.toastFail("Auto-login failed");
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        EasyLoading.dismiss();
        Const.toastFail("OTP Failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        emit(verificationId);
        EasyLoading.dismiss();
        Const.toastSuccess("OTP Sent");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        emit(verificationId);
      },
    );
  }

  /// Verify OTP entered by user
  Future<void> verifyOtp(String otpCode) async {
    if (state == null) {
      Const.toastFail("Verification ID not found");
      return;
    }

    EasyLoading.show(status: 'Verifying...');
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: state!,
        smsCode: otpCode,
      );

      await auth.signInWithCredential(credential);
      SharedPrefUtils.setIsUserLoggedIn(true);
      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Const.toastFail(e.message ?? "OTP Verification Failed");
    } catch (e) {
      EasyLoading.dismiss();
      Const.toastFail("Something went wrong");
    }
  }
}

class GoogleAuthCubit extends Cubit<User?> {
  GoogleAuthCubit() : super(null);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    EasyLoading.show(status: 'Signing in with Google...');
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        EasyLoading.dismiss();
        Const.toastFail("Google Sign-In cancelled");
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        SharedPrefUtils.setIsUserLoggedIn(true);
        emit(user);
        EasyLoading.dismiss();
        Const.toastSuccess("Signed in as ${user.displayName}");
      } else {
        throw Exception("User is null after Google sign-in");
      }
    } catch (e) {
      EasyLoading.dismiss();
      Const.toastFail("Google Sign-In Failed: ${e.toString()}");
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    emit(null);
  }
}

