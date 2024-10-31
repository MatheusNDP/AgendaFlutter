class Contact {
  final int? id; // Agora temos um campo id, que pode ser nulo
  final String name;
  final String phone;
  final String email;

  Contact({this.id, required this.name, required this.phone, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Incluindo o id no map
      'name': name,
      'phone': phone,
      'email': email,
    };
  }

  // Método para criar um objeto Contact a partir de um Map
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'], // Atribuindo o id a partir do Map
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
    );
  }
}
