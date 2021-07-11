import 'package:meta/meta.dart';

@immutable
class AppState {
  final dynamic user;
  final List<dynamic> category;

  AppState({@required this.user,@required this.category});

  factory AppState.initial() {
    return AppState(user: null, category:[]);
  }
}