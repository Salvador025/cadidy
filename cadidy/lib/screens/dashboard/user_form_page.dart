import 'package:flutter/material.dart';
import 'package:cadidy/service/users_service.dart';
import 'home.dart'; // Importar la pantalla Home

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  String displayName = '';
  String lastName = '';
  String address = '';
  String profilePicture = '';
  String phone = '';
  String username = '';

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final usersService = UsersService();
      await usersService.saveUserData(
        uid: UsersService.uid!,
        email: UsersService.email!,
        displayName: displayName,
        lastName: lastName,
        address: address,
        profilePicture: profilePicture,
        phone: phone,
        username: username,
      );

      // Redirigir a la pantalla Home
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Your Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => displayName = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Last Name'),
                onSaved: (value) => lastName = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                onSaved: (value) => address = value!,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Profile Picture URL'),
                onSaved: (value) => profilePicture = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                onSaved: (value) => phone = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                onSaved: (value) => username = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
