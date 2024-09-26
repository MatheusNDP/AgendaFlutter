import 'package:agendaflutter/models/contact.dart';
import 'package:flutter/material.dart';

class ContactFormScreen extends StatefulWidget {
  final Contact? contact;
  final Function(Contact) onSave;
  final VoidCallback? onDelete;

  ContactFormScreen({this.contact, required this.onSave, this.onDelete});

  @override
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phone;
  late String _email;

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      _name = widget.contact!.name;
      _phone = widget.contact!.phone;
      _email = widget.contact!.email;
    } else {
      _name = '';
      _phone = '';
      _email = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact == null ? 'Adicionar Contato' : 'Editar Contato'),
        actions: [
          if (widget.onDelete != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: widget.onDelete,
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nome é obrigatório';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Telefone é obrigatório';
                  }
                  if (!RegExp(r'^\(\d{2}\) \d{5}-\d{4}$').hasMatch(value)) {
                    return 'Telefone deve estar no formato (XX) XXXXX-XXXX';
                  }
                  return null;
                },
                onSaved: (value) => _phone = value!,
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'E-mail é obrigatório';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSave(Contact(name: _name, phone: _phone, email: _email));
      Navigator.of(context).pop();
    }
  }
}
