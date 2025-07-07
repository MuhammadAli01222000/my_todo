import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class LocalUser extends HiveObject {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String? email;

  @HiveField(2)
  final String? displayName;

  LocalUser({
    required this.uid,
    this.email,
    this.displayName,
  });
}
