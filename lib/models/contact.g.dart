// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      id: json['_id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      picture: (json['picture'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'notes': instance.notes,
    };
