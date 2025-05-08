import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:cadidy/screens/dashboard/home.dart';
import 'package:cadidy/screens/dashboard/user_form_page.dart'; // Importar la nueva página
import 'package:cadidy/service/users_service.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              GoogleProvider(clientId: '690276078811-oal35u4arq6lohd79ksboehugnlae7va.apps.googleusercontent.com')
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/images/Icon.png'),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to Cadidy, please sign in!')
                    : const Text('Welcome to Cadidy, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
          );
        }

        // Guardar UID y correo electrónico en UsersService
        UsersService.uid = snapshot.data!.uid;
        UsersService.email = snapshot.data!.email!;
        print('Usuario autenticado con UID: ${UsersService.uid}');
        print('Correo electrónico del usuario: ${UsersService.email}');

        // Usar FutureBuilder para manejar la lógica asíncrona
        return FutureBuilder<bool>(
          future: UsersService.doesUIDExist(UsersService.uid!),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (asyncSnapshot.hasError) {
              return const Center(child: Text('Error verificando el UID.'));
            } else if (asyncSnapshot.data == true) {
              // Si el UID ya existe, redirigir a Home
              print('El UID existe en la base de datos.');
              return const Home();
            } else {
              // Si el UID no existe, redirigir al formulario
              print('El UID no existe en la base de datos.');
              return const UserFormPage();
            }
          },
        );
      },
    );
  }
}