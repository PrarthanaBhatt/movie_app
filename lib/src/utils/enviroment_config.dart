import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnviromentConfig {
  //add the api key by running
  //flutter run --dart-define=movieApiKey=MYKEY
  final movieApiKey = const String.fromEnvironment("movieApiKey");
}

final enviromentConfigProvider = Provider<EnviromentConfig>((ref) {
  return EnviromentConfig();
});
