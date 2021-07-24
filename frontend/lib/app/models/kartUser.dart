import 'package:meta/meta.dart';

@immutable
class kartUser {
  const kartUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.imageURL,
  });

  final String? uid;
  final String? email;
  final String? displayName;
  final String? imageURL; 
  
}
