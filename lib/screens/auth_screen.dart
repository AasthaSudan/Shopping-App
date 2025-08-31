import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isSignUp = false;
  var _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      if (_isSignUp) {
        await Provider.of<AuthProvider>(context, listen: false).signUp(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } else {
        await Provider.of<AuthProvider>(context, listen: false).signIn(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      }
    } catch (error) {
      print("Auth Error: $error");
    }

    setState(() => _isLoading = false);
  }

  void _switchAuthMode() {
    setState(() => _isSignUp = !_isSignUp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA7C7E7), Color(0xFFF1D1D1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 30),

              // ✅ Branding
              Icon(Icons.shopping_bag, size: 90, color: Colors.black87),
              Text(
                "Trendora",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, // Darker
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Sign in to continue shopping your favorites!",
                style: TextStyle(color: Colors.black54, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // ✅ Form
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (_isSignUp)
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                labelStyle: TextStyle(color: Colors.black87),
                                prefixIcon:
                                Icon(Icons.person, color: Colors.blue),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name.';
                                }
                                return null;
                              },
                            ),
                          if (_isSignUp) SizedBox(height: 16),

                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.black87),
                              prefixIcon:
                              Icon(Icons.email, color: Colors.blue),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) => value == null ||
                                !value.contains('@')
                                ? 'Enter valid email'
                                : null,
                          ),
                          SizedBox(height: 16),

                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.black87),
                              prefixIcon:
                              Icon(Icons.lock, color: Colors.blue),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) => value == null ||
                                value.length < 6
                                ? 'Password must be 6+ chars'
                                : null,
                          ),

                          if (_isSignUp)
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Tip: Use at least 6 characters with a mix of letters & numbers",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              ),
                            ),

                          SizedBox(height: 20),

                          if (_isLoading)
                            CircularProgressIndicator()
                          else
                            ElevatedButton(
                              onPressed: _submit,
                              child: Text(_isSignUp ? 'Sign Up' : 'Sign In'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black87,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 25),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          SizedBox(height: 10),

                          if (!_isSignUp)
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 14),
                              ),
                            ),

                          TextButton(
                            onPressed: _switchAuthMode,
                            child: Text(
                              _isSignUp
                                  ? "Already have an account? Sign In"
                                  : "Don't have an account? Sign Up",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 16),
                            ),
                          ),

                          SizedBox(height: 10),
                          Text(
                            "By continuing, you agree to our Terms of Service & Privacy Policy.",
                            style: TextStyle(
                                color: Colors.black54, fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}