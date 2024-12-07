import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50),
                Center(
                  child: Text(
                    "Welcome to XYZ",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                _buildTextField("Email Id", "Enter your mail id", false),
                SizedBox(height: 20),
                _buildTextField("Password", "Enter your password", true),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Forgot password logic
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                          color: Colors.blue,
                          decoration:
                          TextDecoration.underline,
                          decorationColor: Colors.blue,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Your logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Replace 'primary' with 'backgroundColor'
                        padding: EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        "Sign In", // or "Sign in" for the Sign-In page
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Center(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 1,
                          endIndent: 10,
                        ),
                      ),
                      Text(
                        "or sign in with",
                        style: TextStyle(color: Colors.blue),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 1,
                          indent: 10,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset('assets/google_icon.png'),
                      iconSize: 100,
                      onPressed: () {
                        // Google sign-in logic
                      },
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Image.asset('assets/apple_icon.png'),
                      iconSize: 50,
                      onPressed: () {
                        // Apple sign-in logic
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white70),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.blue,
                              decoration:
                              TextDecoration.underline,
                              decorationColor: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String placeholder, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextField(
          obscureText: isPassword ? !_isPasswordVisible : false,
          decoration: InputDecoration(
            filled: true, // Enable filling the input box
            fillColor: Colors.white, // Set the background color to white
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none, // Remove the border
            ),
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.grey), // Adjust hint text color
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey, // Color of the icon
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            )
                : null,
          ),
          style: TextStyle(color: Colors.black), // Set the text color to black for contrast
        ),
      ],
    );
  }
}
