import 'package:equatable/equatable.dart';
import 'package:phonebook/models/contact.dart';

abstract class ContactListState extends Equatable {
  const ContactListState();
}

class ContactListLoaded extends ContactListState {
  final List<Contact> contacts;
  final bool isLoading;
  final bool hasError;

  const ContactListLoaded({
    this.contacts = const [],
    this.isLoading = false,
    this.hasError = false,
  });

  @override
  List<Object?> get props => [contacts, isLoading, hasError];

  ContactListLoaded copyWith({
    List<Contact>? contacts,
    bool? isLoading,
    bool? hasError,
  }) {
    return ContactListLoaded(
      contacts: contacts ?? this.contacts,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
