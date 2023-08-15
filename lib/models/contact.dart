import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact {
  @JsonKey(name: '_id', includeToJson: false)
  final String? id;
  final String? firstName;
  final String? lastName;
  @JsonKey(includeToJson: false)
  final List<String?>? picture;
  final String? phone;
  final String? email;
  final String? notes;

  Contact({
    this.id,
    required this.firstName,
    required this.lastName,
    this.picture,
    required this.phone,
    required this.email,
    required this.notes,
  });

  bool hasData() {
    return firstName != null && lastName != null && phone != null && email != null;
  }

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
