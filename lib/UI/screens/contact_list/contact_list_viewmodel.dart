import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonebook/UI/UI.dart';
import 'package:phonebook/models/contact.dart';
import 'package:phonebook/services/contact_manager/contact_manager.dart';

class ContactListViewModel extends Cubit<ContactListState> {
  final ContactManager _contactManager;

  ContactListViewModel(this._contactManager) : super(const ContactListLoaded()) {
    _contactManager.subscribeOnStableChanged(_listenToContactChanges);
  }

  Future<void> fetchContacts() async {
    var hasError = false;
    emit((state as ContactListLoaded).copyWith(isLoading: true));
    await _contactManager.fetchContacts();
    emit((state as ContactListLoaded).copyWith(isLoading: false, hasError: hasError));
  }

  void _listenToContactChanges(List<Contact> contacts) {
    emit(ContactListLoaded(contacts: [...contacts]));
  }

  void deleteContact(String? id) {
    _contactManager.deleteContact(id ?? "");
  }
}
