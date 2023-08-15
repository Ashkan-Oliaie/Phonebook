import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:phonebook/UI/UI.dart';

class Field {
  String label;
  String name;

  Field(this.label, this.name);
}

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({Key? key}) : super(key: key);

  @override
  AddContactScreenState createState() => AddContactScreenState();
}

class AddContactScreenState extends State<AddContactScreen> {
  final viewmodel = GetIt.instance.get<AddContactViewModel>();

  List<Field> fields = [
    Field('First Name', AddContactConfig.firstNameKey),
    Field('Last Name', AddContactConfig.lastNameKey),
    Field('Phone', AddContactConfig.phoneKey),
    Field('Email', AddContactConfig.emailKey),
    Field('Note', AddContactConfig.notesKey),
    Field('Image', AddContactConfig.imagePathKey),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddContactViewModel>(
      create: (context) => viewmodel,
      child: BlocBuilder<AddContactViewModel, AddContactState>(
        bloc: viewmodel,
        builder: (context, state) {
          if (state is AddContactLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Add Contact'),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...fields
                          .map((field) => _buildTextField(
                                name: field.name,
                                label: field.label,
                                keyboardType: field.name == AddContactConfig.phoneKey ? TextInputType.phone : TextInputType.text,
                                errorMessage: state.formErrors[field.name],
                              ))
                          .toList(),
                      ElevatedButton(
                        onPressed: state.isLoading
                            ? null
                            : () {
                                viewmodel.addContact(
                                  onSuccess: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                        child: state.isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator()) : const Text('Add Contact'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildTextField({required String name, required String label, TextInputType keyboardType = TextInputType.text, String? errorMessage}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        onChanged: (String value) => viewmodel.setFieldValue(name, value),
        decoration: InputDecoration(labelText: label, errorText: errorMessage),
      ),
    );
  }
}
