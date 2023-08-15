import 'package:equatable/equatable.dart';
import 'package:phonebook/models/index.dart';

abstract class ContactDetailState extends Equatable {
  const ContactDetailState();
}

class ContactDetailLoaded extends ContactDetailState {
  final Contact? contact;

  @override
  List<Object?> get props => [contact];

  const ContactDetailLoaded({
    this.contact,
  });
}
