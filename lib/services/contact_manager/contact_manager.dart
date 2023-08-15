import 'dart:async';
import 'package:phonebook/models/contact.dart';
import 'package:phonebook/services/api_service.dart';

abstract class IContactManager {
  List<Contact> get contacts;
  Future<List<Contact>?> fetchContacts();
  Future<void> addContact({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String notes,
    String? imagePath,
  });
  Future<bool> deleteContact(String id);
  StreamSubscription<List<Contact>> subscribeOnStableChanged(Function onChanged);
}

class ContactManager extends IContactManager {
  ContactManager(this._apiService);
  final StreamController<List<Contact>> _contactsStream = StreamController.broadcast();

  final ApiService _apiService;
  final _contacts = <Contact>[];

  @override
  Future<List<Contact>?> fetchContacts() async {
    final response = await _apiService.fetchContacts();

    _contacts.clear();
    _contacts.addAll(response?.contacts?.where((element) => element.hasData()).toList() ?? []);
    _contactsStream.add(_contacts);

    return response?.contacts;
  }

  @override
  Future<bool> addContact({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String notes,
    String? imagePath,
  }) async {
    final isSuccessful = await _apiService.addContact(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      email: email,
      notes: notes,
      picture: imagePath,
    );
    if (isSuccessful) {
      await fetchContacts();
    }

    return isSuccessful;
  }

  @override
  List<Contact> get contacts => _contacts;

  @override
  StreamSubscription<List<Contact>> subscribeOnStableChanged(Function onChanged) {
    return _contactsStream.stream.listen((item) => onChanged.call(item));
  }

  @override
  Future<bool> deleteContact(String id) async {
    final isSuccessful = await _apiService.deleteContact(id);
    if (isSuccessful) {
      _contacts.removeWhere((element) => element.id == id);
      _contactsStream.add(_contacts);
    }

    return isSuccessful;
  }
}
