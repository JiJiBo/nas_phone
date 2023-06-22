import 'package:mobx/mobx.dart';

// This is our generated file (we'll see this soon!)
part 'route.g.dart';

// We expose this to be used throughout our project
class route = _route with _$route;

final routeStore = route();

// Our store class
abstract class _route with Store {
  String welcome_ui_route = "/welcome_ui_route";
  String home_ui_route = "/home_ui_route";
  String add_ui_route = "/add_ui_route";
}
