import 'package:meta/meta.dart';

abstract class Validation {
  String validate({@required String field, @required Map input});
}
