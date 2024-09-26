import 'package:agendaflutter/models/contact.dart';
import 'package:flutter/material.dart';
import 'contact_form_screen.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
      ),
      body: contacts.isEmpty
          ? Center(  
              child: Text(
                'Nenhum contato encontrado',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),  
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10),  
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
        child: Icon(Icons.add),
      ),
    );
  }

  void _addContact() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactFormScreen(
          onSave: (contact) {
            setState(() {
              contacts.add(contact);
            });
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
          onSave: (updatedContact) {
            setState(() {
              final index = contacts.indexOf(contact);
              contacts[index] = updatedContact;
            });
          },
          onDelete: () {
            setState(() {
              contacts.remove(contact);
            });
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
