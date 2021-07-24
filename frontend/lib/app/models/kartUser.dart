import 'package:meta/meta.dart';

@immutable
class kartUser {
  const kartUser({
    required this.uid,
    required this.email,
    required this.displayName,
  });

  final String? uid;
  final String? email;
  final String? displayName;
}
