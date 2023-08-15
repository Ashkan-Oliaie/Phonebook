import 'package:json_annotation/json_annotation.dart';
import 'contact.dart';

part 'contacts_response.g.dart';

@JsonSerializable()
class ContactsResponse {
  List<Contact>? contacts;

  ContactsResponse({required this.contacts});

  factory ContactsResponse.fromJson(Map<String, dynamic> json) => _$ContactsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}
