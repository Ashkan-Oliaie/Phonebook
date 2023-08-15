// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactsResponse _$ContactsResponseFromJson(Map<String, dynamic> json) =>
    ContactsResponse(
      contacts: (json['contacts'] as List<dynamic>?)
          ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContactsResponseToJson(ContactsResponse instance) =>
    <String, dynamic>{
      'contacts': instance.contacts,
    };
