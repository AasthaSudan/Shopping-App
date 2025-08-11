import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/products_overview_screen.dart'; // Ensure this is correct

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isSignUp = false;
  var _isLoading = false;

  // Method to handle the form submission
  void _submit() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      if (_isSignUp) {
        await Provider.of<AuthProvider>(context, listen: false).signUp(
          _emailController.text,
          _passwordController.text,
        );
      } else {
        await Provider.of<AuthProvider>(context, listen: false).signIn(
          _emailController.text,
          _passwordController.text,
        );
      }
      Navigator.of(context).pushReplacementNamed(ProductsOverviewScreen.routeName);
    } catch (error) {
      // Handle the error
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Authentication Failed'),
          content: Text('Could not authenticate you. Please try again later.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Method to toggle between Sign In and Sign Up screens
  void _switchAuthMode() {
    setState(() {
      _isSignUp = !_isSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authenticate')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _submit,
                child: Text(_isSignUp ? 'Sign Up' : 'Sign In'),
              ),
            SizedBox(height: 10),
            TextButton(
              onPressed: _switchAuthMode,
              child: Text(
                _isSignUp
                    ? 'Already have an account? Sign In'
                    : 'Don\'t have an account? Sign Up',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
