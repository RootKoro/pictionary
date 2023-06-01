import 'drawing.state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Drawing extends DrawingState {
  final String id;
  final String username;

  Drawing({required this.id, required this.username});
}
