import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/constants/app_image.dart';
import 'package:social_app/core/constants/const.dart';
import 'package:social_app/core/constants/dimensions.dart';
import 'package:social_app/core/utils/navigation_manager.dart';
import 'package:social_app/core/widgets/custom_button/login_button.dart';
import 'package:social_app/core/widgets/textfields/login_textfield.dart';
import 'package:social_app/feature/user/verify_phone_screen.dart';

import 'cubit/sign_up_cubit.dart';


class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final _phoneController = TextEditingController();
  final PhoneAuthCubit _phoneAuthCubit = PhoneAuthCubit();
  String countryCode = "+91";

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImage.icAppLogo,
                  width: Dimensions.w80,
                  height: Dimensions.h80,
                ).animate().fadeIn(begin: 0, duration: 500.ms),
                verticalHeight(Dimensions.h24),
                Text(
                  "Sign Up with Phone Number",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal.shade700),
                ).animate().fade(duration: 400.ms),
                verticalHeight(Dimensions.h24),
                Row(
                  children: [
                    CountryCodePicker(
                      onChanged: (country) {
                        setState(() {
                          countryCode = country.dialCode ?? "+91";
                        });
                      },
                      initialSelection: 'IN',
                      favorite: const ['+91', 'IN'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),
                    Expanded(
                      child: LoginTextfield(
                        controller: _phoneController,
                        labelText: "Phone Number",
                        prefixIcon: Icons.phone,
                        autofillHints: [AutofillHints.telephoneNumber],
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                verticalHeight(Dimensions.h24),
                LoginButton(
                  onTap: _sendOTP,
                  text: "Send OTP",
                  elevation: 0,
                ).animate().fade().slideY(duration: 500.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendOTP() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      Const.toastFail("Please enter a valid phone number");
      return;
    }

    final fullPhone = '$countryCode$phone';

    try {
      await _phoneAuthCubit.sendOtp(fullPhone);

      if (!mounted) return;
      navigateToPage( BlocProvider.value(
        value: _phoneAuthCubit, // ✅ re-use same cubit instance
        child: const OtpVerificationScreen(),
      ),
      );
    } catch (e) {
      Const.toastFail("Something went wrong");
    }
  }
}
