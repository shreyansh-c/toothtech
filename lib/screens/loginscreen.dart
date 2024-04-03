import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tooth_tech/screens/homescreen.dart';
import 'package:tooth_tech/utils/custombutton.dart';
import 'package:tooth_tech/utils/pallete.dart';
import 'package:mssql_connection/mssql_connection.dart';

class LoginScreen extends StatefulWidget {
  final MssqlConnection mssqlConnection;

  const LoginScreen({Key? key, required this.mssqlConnection})
      : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 95,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/svsulogo.png',
                width: 120,
                height: 120,
              ),
            ),
            const Text(
              'Subharti Dental College',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                  color: Pallete.primaryColor),
            ),
            const SizedBox(
              height: 90,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Login Now!',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                        color: Pallete.primaryColor,
                      ),
                    ),
                    Text(
                      'Enter Your Credentials to Login',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Pallete.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                height: 45,
                width: 320,
                decoration: BoxDecoration(
                    color: Pallete.tertiaryColor,
                    borderRadius: BorderRadius.circular(6)),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: "Email",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Pallete.secondaryColor,
                        ),
                        border: InputBorder.none),
                    showCursor: false,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(
                height: 45,
                width: 320,
                decoration: BoxDecoration(
                    color: Pallete.tertiaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: "Password",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Pallete.secondaryColor,
                        ),
                        border: InputBorder.none),
                    showCursor: false,
                    obscureText: true,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomButton(
              onPressed: _login,
              label: 'Login',
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              _message,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Pallete.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    String query =
        'SELECT * FROM login WHERE userid = "$email" AND pass = "$password"';
    String result = await widget.mssqlConnection.getData(query);

    if (result.isNotEmpty) {
      setState(() {
        _message = 'Login successful!';
      });
      // Redirect to home screen after a delay
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    } else {
      setState(() {
        _message = 'Invalid email or password';
      });
    }
  }
}
