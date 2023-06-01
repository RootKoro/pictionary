import 'answer.model.dart';
import 'drawing.point.dart';
import 'room.model.dart';

class DrawingState {
  List<DrawingPoint>? historyPoints;
  List<DrawingPoint>? points;
  RoomModel? room;
  List<AnswerModel>? answers;

  DrawingState({this.historyPoints, this.points, this.room, this.answers});
}
