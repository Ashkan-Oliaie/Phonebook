import 'package:json_annotation/json_annotation.dart';
import 'contact.dart';

part 'add_contact_response.g.dart';

@JsonSerializable()
class AddContactResponse {
  Contact? contact;

  AddContactResponse({required this.contact});

  factory AddContactResponse.fromJson(Map<String, dynamic> json) => _$AddContactResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AddContactResponseToJson(this);
}
