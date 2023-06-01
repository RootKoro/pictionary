import 'package:flutter/material.dart';

class DrawingPoint {
  final String id;
  final List<Offset> offsets;
  Paint? paint;

  DrawingPoint({required this.id, required this.offsets, this.paint});
}
