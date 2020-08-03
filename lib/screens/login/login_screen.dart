import 'package:flutter/material.dart';
import 'package:loja_flutter_app/helpers/validators.dart';
import 'package:loja_flutter_app/model/user.dart';
import 'package:loja_flutter_app/model/user_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Login'),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            child: const Text('CRIAR CONTA',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),),
          ],
        ),
        body: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Consumer<UserManager>(
                builder: (_, userManager, child) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: <Widget>[
                      TextFormField(
                        controller: emailController,
                        //onChanged: (value) => print(value),
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) {
                          if (!emailValid(email)) {
                            return 'Email inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        //onChanged: (value) => print(value),
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        //keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        obscureText: true,
                        validator: (password) {
                          if (password.isEmpty || password.length < 6) {
                            return 'Senha inválida';
                          }
                          return null;
                        },
                      ),
                      child,
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 50, //44
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          disabledColor:
                              Theme.of(context).primaryColor.withAlpha(100),
                          onPressed: userManager.loading
                              ? null
                              : () {
                                  if (formKey.currentState.validate()) {
                                    userManager.signIn(
                                        user: User(
                                            email: emailController.text,
                                            password: passwordController.text
                                        ),
                                        onFail: (e) {
                                          scaffoldKey.currentState.showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text('Falha ao entrar: $e'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        },
                                        onSucess: () {
                                          Navigator.pop(context);
                                        });
                                  }
                                },
                          textColor: Colors.white,
                          child: userManager.loading
                              ? const CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : const Text(
                                  'Entrar',
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
                      )
                    ],
                  );
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: const Text('Esqueci minha senha'),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
