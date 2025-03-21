import 'package:flutter/cupertino.dart';

@immutable
class Pair<A, B> {
  final A a;
  final B b;

  const Pair(this.a, this.b);
}