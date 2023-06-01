import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pictionary/models/drawing.point.dart';

class DrawService {
  final String? id;
  final List<Offset>? offsets;

  DrawService({this.id, this.offsets});

  final CollectionReference drawCollection =
      FirebaseFirestore.instance.collection('drawings');

  DrawingPoint? _drawing(dynamic draw) {
    return draw == null
        ? null
        : DrawingPoint(id: draw.id, offsets: draw.offsets, paint: Paint());
  }

  DrawingPoint? draw(String? id, List<Offset>? offsets) {
    drawCollection.doc(id).set({"offsets": offsets});
    var drawnDocument = draws.map(_drawing).last;
    return _drawing(drawnDocument);
  }

  Stream<QuerySnapshot> get draws {
    return drawCollection.snapshots();
  }

  // Stream<DocumentSnapshot> get drawn {
  //   return drawCollection.;
  // }

  // Future<DocumentSnapshot?> get drawn async {
  //   return id == null ? null : await drawCollection.doc(id).get();
  // }
}

// class OffsetService {
//   int? dx;
//   int? dy;
//   String? id;

//   OffsetService({this.dx, this.dy, this.id});

//   final CollectionReference offsetCollection =
//       FirebaseFirestore.instance.collection('offsets');

//   dynamic setOffset(int? dx, int? dy) async {
//     return dx == null && dy == null ? offsetCollection.doc() : offsetCollection.doc(id).set({
//       dx: dx
//     })
//   }
// }
