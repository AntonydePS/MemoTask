import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../ViewModel/login_view_model.dart';

class LoginPage extends StatelessWidget {
  final LoginViewModel viewModel = LoginViewModel();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo Task'),
      automaticallyImplyLeading: false, // Impede o botão de voltar
      ),
      body: Container(
        color: tdBGColor,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Usuário',
                  ),
                  validator: viewModel.validateUsername,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                  validator: viewModel.validatePassword,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final username = _usernameController.text;
                      final password = _passwordController.text;
                      final loginSuccessful =
                          await viewModel.login(username, password);
                      if (loginSuccessful) {
                        Navigator.pushReplacementNamed(context,
                            '/home'); // se a senha estiver correta ira para proxima tela "home".
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Usuario ou senha incorreta'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Entrar'),
                ),
                TextButton(
                  onPressed: () {
                    // falta a implementação da esquceu a senha
                  },
                  child: const Text('Esqueceu a senha?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
