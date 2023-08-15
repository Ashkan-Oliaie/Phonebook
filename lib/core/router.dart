import 'package:flutter/material.dart';
import 'package:phonebook/UI/UI.dart';
import 'package:phonebook/models/index.dart';

class Routes {
  static const String contactList = '/contact_list';
  static const String addContact = '/add_contact';
  static const String editContact = '/edit_contact';
  static const String contactDetails = '/contact_details';
}

class CustomRouter {
  static Route<dynamic>? generateRoutes(RouteSettings settings) {
    if (settings.name == Routes.contactList) {
      return MaterialPageRoute(
        builder: (context) => const ContactListScreen(),
      );
    } else if (settings.name == Routes.addContact) {
      return MaterialPageRoute(
        builder: (context) => const AddContactScreen(),
      );
    } else if (settings.name == Routes.contactDetails) {
      final Contact contact = settings.arguments as Contact;

      return MaterialPageRoute(
        builder: (context) => ContactDetailView(contact: contact),
      );
    }
    return null;
  }
}
