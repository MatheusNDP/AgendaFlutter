import 'package:agendaflutter/models/contact.dart';
import 'package:flutter/material.dart';
import 'contact_form_screen.dart';
import '../services/database_helper.dart'; // Importa o DatabaseHelper

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts(); // Carrega os contatos do banco de dados ao iniciar
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
          onSave: (contact) async {
            final dbHelper = DatabaseHelper();
            await dbHelper.addContact(contact); // Salva o contato no banco de dados
            _loadContacts(); // Atualiza a lista de contatos
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
            await dbHelper.updateContact(updatedContact); // Atualiza o contato no banco de dados
            _loadContacts(); // Atualiza a lista de contatos
          },
          onDelete: () async {
            final dbHelper = DatabaseHelper();
            await dbHelper.deleteContact(contact.id!); // Remove o contato do banco de dados
            _loadContacts(); // Atualiza a lista de contatos
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
