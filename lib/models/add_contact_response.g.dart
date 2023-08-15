// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_contact_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddContactResponse _$AddContactResponseFromJson(Map<String, dynamic> json) =>
    AddContactResponse(
      contact: json['contact'] == null
          ? null
          : Contact.fromJson(json['contact'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddContactResponseToJson(AddContactResponse instance) =>
    <String, dynamic>{
      'contact': instance.contact,
    };
