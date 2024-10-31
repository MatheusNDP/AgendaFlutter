import 'package:agendaflutter/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/contact.dart';
import 'contact_form_screen.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    final dbHelper = DatabaseHelper();
    final fetchedContacts = await dbHelper.getContacts();
    setState(() {
      contacts = fetchedContacts;
    });
  }

  void _addOrEditContact(Contact? contact) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactFormScreen(
          contact: contact,
          onSave: (newContact) async {
            final dbHelper = DatabaseHelper();
            if (contact == null) {
              await dbHelper.addContact(newContact);
            } else {
              await dbHelper.updateContact(newContact);
            }
            _fetchContacts();
          },
          onDelete: contact == null ? null : () async {
            await DatabaseHelper().deleteContact(contact.id!);
            Navigator.of(context).pop();
            _fetchContacts();
          },
        ),
      ),
    );
  }

  Future<void> _logout() async {
    await FlutterSecureStorage().delete(key: 'session_token');
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.phone),
            onTap: () => _addOrEditContact(contact),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditContact(null),
        child: Icon(Icons.add),
      ),
    );
  }
}