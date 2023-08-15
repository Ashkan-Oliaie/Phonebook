import 'package:bloc/bloc.dart';
import 'package:phonebook/services/contact_manager/contact_manager.dart';
import 'package:phonebook/UI/UI.dart';

import 'add_contact_state.dart';

class AddContactConfig {
  static const String firstNameKey = 'firstName';
  static const String lastNameKey = 'lastName';
  static const String phoneKey = 'phone';
  static const String emailKey = 'email';
  static const String notesKey = 'notes';
  static const String imagePathKey = 'image';
}

class AddContactViewModel extends Cubit<AddContactState> {
  final ContactManager _contactManager;

  AddContactViewModel(this._contactManager) : super(const AddContactLoaded());

  final Map<String, String?> _formValues = {
    AddContactConfig.firstNameKey: null,
    AddContactConfig.lastNameKey: null,
    AddContactConfig.phoneKey: null,
    AddContactConfig.emailKey: null,
    AddContactConfig.notesKey: null,
    AddContactConfig.imagePathKey: null,
  };
  final Map<String, String?> _formError = {};

  Future<void> addContact({
    String? imagePath,
    Function? onSuccess,
  }) async {
    emit((state as AddContactLoaded).copyWith(isLoading: true));
    var isFailed = false;
    _validateForm();
    if (_formError.isEmpty) {
      final isSuccessful = await _contactManager.addContact(
        firstName: _formValues[AddContactConfig.firstNameKey]!,
        lastName: _formValues[AddContactConfig.lastNameKey]!,
        phone: _formValues[AddContactConfig.phoneKey]!,
        email: _formValues[AddContactConfig.emailKey]!,
        notes: _formValues[AddContactConfig.notesKey]!,
        imagePath: _formValues[AddContactConfig.imagePathKey],
      );

      if (isSuccessful) {
        onSuccess?.call();
      } else {
        isFailed = true;
      }
    }

    emit((state as AddContactLoaded).copyWith(isLoading: false, isFailed: isFailed));
  }

  void setFieldValue(String fieldName, String value) {
    _formValues.update(fieldName, (oldValue) => value, ifAbsent: () => value);
  }

  void _validateForm() {
    _formError.clear();
    const requiredFieldText = 'This field is required';

    _formValues.forEach((key, value) {
      if (key != AddContactConfig.imagePathKey) {
        if (value == null || value.isEmpty) {
          _formError.update(key, (value) => requiredFieldText, ifAbsent: () => requiredFieldText);
        }
      }
    });

    emit((state as AddContactLoaded).copyWith(formErrors: {..._formError}));
  }
}
