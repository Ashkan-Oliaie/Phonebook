import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:phonebook/UI/UI.dart';
import 'package:phonebook/models/contact.dart';

class ContactDetailView extends StatefulWidget {
  final Contact contact;

  @override
  ContactDetailViewState createState() => ContactDetailViewState();

  const ContactDetailView({
    super.key,
    required this.contact,
  });
}

class ContactDetailViewState extends State<ContactDetailView> {
  final viewmodel = GetIt.instance.get<ContactDetailViewModel>();

  @override
  void initState() {
    viewmodel.initialize(widget.contact);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactDetailViewModel>(
      create: (context) => viewmodel,
      child: BlocBuilder<ContactDetailViewModel, ContactDetailState>(
        builder: (context, state) {
          if (state is ContactDetailLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: Text("${state.contact?.firstName} ${state.contact?.lastName}"),
              ),
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 0.5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          state.contact?.picture?.first ?? "",
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (c, o, s) => const SizedBox(height: 200, width: 200, child: Icon(Icons.close)),
                        ),
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Text(
                          "Phone number",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        Text("${state.contact?.phone}"),
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Row(
                      children: [
                        Text(
                          "Email",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                        Text("${state.contact?.email}"),
                      ],
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Note",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${state.contact?.notes}", maxLines: 10),
                        ),
                      ],
                    ),
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
}
