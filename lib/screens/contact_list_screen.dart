import 'package:agendaflutter/models/contact.dart';
import 'package:flutter/material.dart';
import 'contact_form_screen.dart';
import '../services/database_helper.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts(); 
  }

  Future<void> _loadContacts() async {
    final dbHelper = DatabaseHelper();
    final contactList = await dbHelper.fetchContacts();
    setState(() {
      contacts = contactList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contatos'),
      ),
      body: contacts.isEmpty
          ? const Center(
              child: Text(
                'Nenhum contato encontrado',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    title: Text(contact.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Telefone: ${contact.phone}'),
                        Text('Email: ${contact.email}'),
                      ],
                    ),
                    onTap: () => _editContact(contact),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addContact,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addContact() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactFormScreen(
          onSave: (contact) async {
            final dbHelper = DatabaseHelper();
            await dbHelper.addContact(contact); 
            _loadContacts(); 
          },
        ),
      ),
    );
  }

  void _editContact(Contact contact) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactFormScreen(
          contact: contact,
          onSave: (updatedContact) async {
            final dbHelper = DatabaseHelper();
            await dbHelper.updateContact(updatedContact); 
            _loadContacts(); 
          },
          onDelete: () async {
            final dbHelper = DatabaseHelper();
            await dbHelper.deleteContact(contact.id!); s
            _loadContacts(); 
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
