import 'package:bukeet/enums/env_enum.dart';

class Environment {
  static String env = const String.fromEnvironment(
    "ENV",
    defaultValue: Env.dev,
  ).toUpperCase();
}
