import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tooth_tech/utils/pallete.dart';

class CustomButton extends StatelessWidget {
  final Route route;
  final String label;

  const CustomButton({Key? key, required this.route, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(route);
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Pallete.tertiaryColor,
        surfaceTintColor: Pallete.tertiaryColor,
        shadowColor: Pallete.tertiaryColor,
        foregroundColor: Pallete.tertiaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: Text(
                label,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Pallete.secondaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
