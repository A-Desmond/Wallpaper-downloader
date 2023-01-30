import 'package:flutter/material.dart';


class IconBut extends StatelessWidget {
  final VoidCallback ontap;
  final IconData icon;
  final String description;
  const IconBut({
    super.key,
    required this.ontap,
    required this.icon,
    required this.description,
  });
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      InkWell(
        splashColor: Colors.red,
        borderRadius: BorderRadius.circular(20),
        onTap: ontap,
        child: CircleAvatar(
          radius: 35,
          backgroundColor:
              const Color.fromARGB(255, 159, 181, 199).withOpacity(0.2),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Icon(
              icon,
              color: Colors.white.withOpacity(0.5),
              size: 35,
            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
      Text(
        description,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white.withOpacity(0.5),
        ),
      )
    ]);
  }
}
