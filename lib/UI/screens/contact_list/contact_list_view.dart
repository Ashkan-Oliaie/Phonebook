import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:phonebook/core/router.dart';
import 'package:phonebook/models/contact.dart';
import 'package:phonebook/UI/UI.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  ContactListScreenState createState() => ContactListScreenState();
}

class ContactListScreenState extends State<ContactListScreen> {
  final viewmodel = GetIt.instance.get<ContactListViewModel>();

  @override
  void initState() {
    viewmodel.fetchContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactListViewModel>(
      create: (context) => viewmodel,
      child: BlocBuilder<ContactListViewModel, ContactListState>(
        builder: (context, state) {
          if (state is ContactListLoaded) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.addContact);
                },
                child: const Icon(Icons.add),
              ),
              appBar: AppBar(
                title: const Text("Contacts"),
              ),
              body: Center(
                child: ListView(
                  children: [
                    if (state.contacts.isEmpty && !state.isLoading)
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const Text('No data to display'),
                            ElevatedButton(
                                onPressed: () {
                                  viewmodel.fetchContacts();
                                },
                                child: const Text("Try again"))
                          ],
                        ),
                      ),
                    if (state.isLoading) const SizedBox(height: 50, child: Center(child: CircularProgressIndicator())),
                    ...state.contacts.map((e) => _buildContactItem(e)).toList()
                  ],
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildContactItem(Contact contact) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.contactDetails, arguments: contact);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.5))),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    contact.picture?.first ?? "",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (c, o, s) => const SizedBox(height: 50, width: 50, child: Icon(Icons.close)),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${contact.firstName} ${contact.lastName}",
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("${contact.phone}"),
                  Text("${contact.email}"),
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    viewmodel.deleteContact(contact.id);
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}
