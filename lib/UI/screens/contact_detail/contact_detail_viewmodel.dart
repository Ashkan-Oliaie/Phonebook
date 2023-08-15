import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phonebook/UI/UI.dart';
import 'package:phonebook/models/contact.dart';

class ContactDetailViewModel extends Cubit<ContactDetailState> {
  ContactDetailViewModel() : super(const ContactDetailLoaded());

  Future<void> initialize(Contact contact) async {
    emit(ContactDetailLoaded(contact: contact));
  }
}
