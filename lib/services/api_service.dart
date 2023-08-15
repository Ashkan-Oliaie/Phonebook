import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:phonebook/core/config.dart';
import 'package:phonebook/models/index.dart';

abstract class IApiService {
  Future<ContactsResponse> fetchContacts();
  Future<AddContactResponse> addContact(Contact contact);
}

class ApiService {
  Future<ContactsResponse?> fetchContacts() async {
    try {
      final response = await http.get(
        Uri.parse('${Configuration.baseUrl}/contacts'),
        headers: {
          'x-apikey': Configuration.contactsApiKey,
        },
      );
      final jsonMap = json.decode(response.body);
      return ContactsResponse(
        contacts: (jsonMap as List).map((e) => Contact.fromJson(e)).toList(),
      );
    } catch (e) {
      // Handle errors
    }

    return null;
  }

  Future<bool> addContact({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String notes,
    String? picture,
  }) async {
    final contact = Contact(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      email: email,
      notes: notes,
    );
    final map = contact.toJson();
    if (picture != null) {
      map['picture'] = [picture];
    }

    try {
      final response = await http.post(
        Uri.parse('${Configuration.baseUrl}/contacts'),
        body: json.encode(map),
        headers: {'x-apikey': Configuration.contactsApiKey, 'Content-Type': 'application/json'},
      );

      return response.statusCode == 201;
    } catch (e) {
      // Handle errors
    }

    return false;
  }

  Future<bool> deleteContact(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('${Configuration.baseUrl}/contacts/$id'),
        headers: {
          'x-apikey': Configuration.contactsApiKey,
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      // Handle errors
    }
    return false;
  }
}
