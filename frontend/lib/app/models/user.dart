import 'package:meta/meta.dart';

@immutable
class User {
  const User({
    required this.uid,
    required this.email,
    required this.displayName,
  });

  final String? uid;
  final String? email;
  final String? displayName;
}
