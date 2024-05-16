import 'package:envied/envied.dart';

part '../env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'geminiKey')
  static const String geminiKey = _Env.geminiKey;
}
