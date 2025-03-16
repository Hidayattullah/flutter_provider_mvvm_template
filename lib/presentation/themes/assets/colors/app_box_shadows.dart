import 'package:flutter/material.dart';

class AppBoxShadows {
  static const boxShadow1 = BoxShadow(
    color: Color.fromARGB(50, 0, 0, 0),
    offset: Offset(1, 1),
    blurRadius: 10,
  );

  static const boxShadow2 = BoxShadow(
    color: Color.fromARGB(10, 0, 0, 0),
    blurRadius: 7,
    offset: Offset(0, 4),
  );
  static const boxShadow3 = BoxShadow(
    color: Color.fromARGB(30, 0, 0, 0),
    blurRadius: 10,
    offset: Offset(0, 4),
  );
  static const boxShadow4 = BoxShadow(
    color: Color.fromARGB(40, 0, 0, 0),
    blurRadius: 15,
    offset: Offset(0, 6),
  );
}
