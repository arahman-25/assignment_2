import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';
import 'register.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _busy = false;

  Future<void> _submit() async {
  if (_busy || !_formKey.currentState!.validate()) return;
  setState(() { _busy = true; });
  try {
    await _auth.signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );
  } on FirebaseAuthException catch (error) {
    final message = error.code == 'network-request-failed'
        ? 'Check your connection and try again.'
        : 'Sign-in failed. Check your details and sign-in setup.';
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  } finally {
    if (mounted) setState(() { _busy = false; });
  }
}

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Login',
          style: GoogleFonts.jetBrainsMono(),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 32),

              Container(
                width: 320,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Container(
                width: 320,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10)
                  )
                ),
                onPressed: () {
                  _busy ? null : _submit();
                },
                child: Text(
                  'Register',
                  style: GoogleFonts.jetBrainsMono()
                )
              ),

              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: "New User? ",
                          style: TextStyle(
                            color: Color(0xff6A6A6A),
                            fontWeight: FontWeight.normal,
                            fontSize: 16
                          ),
                        ),
                        TextSpan(
                          text: "Create Account",
                          style: const TextStyle(
                              color: Color(0xff1A1D1E),
                              fontWeight: FontWeight.normal,
                              fontSize: 16
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Registration()
                              ),
                            );
                          }
                        ),
                      ]
                    )
                  )
              )
            ],
          )
        )
      )
    );
  }
}