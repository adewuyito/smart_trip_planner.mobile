import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupView extends HookConsumerWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey();

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final repasswordController = useTextEditingController();

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Itinera AI",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF065F46),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                "Create your account",
                style: GoogleFonts.inter(
                  textStyle: Theme.of(context).textTheme.headlineMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                "Lets get started",
                style: GoogleFonts.inter(
                  textStyle: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Color(0xFF8F95B2)),
                ),
              ),

              const SizedBox(height: 54),

              SizedBox(
                height: 58,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(0xFFD8DAE5)),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign in with Google",
                        style: GoogleFonts.inter(
                          textStyle: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(
                            color: Color(0xFF081735),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 27),

              customDivider(label: "or Sign in with email"),

              const SizedBox(height: 40),

              Form(
                key: formKey,
                child: Column(
                  spacing: 24,

                  children: [
                    emailFormInputField(controller: emailController),

                    passwordFormInputField(controller: passwordController),

                    passwordFormInputField(
                      controller: repasswordController,
                      label: "Confirm Password",
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: Color(0xFFD8DAE5)),
                          ),
                          backgroundColor: Color(0xFF065F46),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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

Widget emailFormInputField({required TextEditingController controller}) {
  return Column(
    spacing: 8,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Email address", style: GoogleFonts.inter()),
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail_outline, color: Color(0xFF8F95B2)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFD8DAE5)),
          ),
        ),
      ),
    ],
  );
}

Widget passwordFormInputField({
  required TextEditingController controller,
  String label = "Password",
}) {
  return Column(
    spacing: 8,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: GoogleFonts.inter()),
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_outline, color: Color(0xFF8F95B2)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFD8DAE5)),
          ),
        ),
      ),
    ],
  );
}

Widget customDivider({required String label}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Divider(thickness: 1, color: Colors.black),
      Text(label),
      Divider(thickness: 1, color: Colors.black),
    ],
  );
}
