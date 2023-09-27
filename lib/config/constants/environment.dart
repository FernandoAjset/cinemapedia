import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? '';
  static String movieDbToken = dotenv.env['THE_MOVIEDB_ACCESS_TOKEN'] ?? '';

}
