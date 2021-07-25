import 'package:meta/meta.dart';

@immutable
class kartUser {
  const kartUser({
    this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });

  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
}
