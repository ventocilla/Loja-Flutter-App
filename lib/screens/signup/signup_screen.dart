import 'package:flutter/material.dart';
import 'package:loja_flutter_app/helpers/validators.dart';
import 'package:loja_flutter_app/model/user.dart';
import 'package:loja_flutter_app/model/user_manager.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Criar Conta'),
          centerTitle: true,
        ),
        body: Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Consumer<UserManager>(
                builder: (_, userManager, __) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: <Widget>[
                      TextFormField(
                        //onChanged: (value) => print(value),
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(
                          hintText: 'Nome Completo',
                        ),
                        autocorrect: false,
                        validator: (name) {
                          if (name.isEmpty) {
                            return 'Campo obrigatório';
                          } else if(name.trim().split(' ').length <= 1){
                            return 'Preencha seu nome completo';
                          }
                          return null;
                        },
                        onSaved: (name) => user.name = name,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        //onChanged: (value) => print(value),
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) {
                          if (email.isEmpty) {
                            return 'Campo obrigatório';
                          } else if (!emailValid(email)) {
                            return 'Email invalido';
                          }
                          return null;
                        },
                        onSaved: (email) => user.email = email,
                      ),
                      //child,
                      const SizedBox(height: 16),
                      TextFormField(
                        //onChanged: (value) => print(value),
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(
                          hintText: 'Senha',
                        ),
                        obscureText: true,
                        autocorrect: true,
                        validator: (pass) {
                          if (pass.isEmpty) {
                            return 'Campo obrigatório';
                          } else if (pass.length < 6) {
                            return 'Senha muito curta';
                          }
                          return null;
                        },
                        onSaved: (pass) => user.password = pass,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        //onChanged: (value) => print(value),
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(
                          hintText: 'Repita a Senha',
                        ),
                        obscureText: true,
                        autocorrect: true,
                        validator: (pass) {
                          if (pass.isEmpty) {
                            return 'Campo obrigatório';
                          } else if (pass.length < 6) {
                            return 'Senha muito curta';
                          }
                          return null;
                        },
                        onSaved: (pass) => user.confirmPassword = pass,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 50, //44
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          disabledColor:
                          Theme.of(context).primaryColor.withAlpha(100),
                          onPressed: userManager.loading
                              ? null
                              : (){
                            if(formKey.currentState.validate()){
                              formKey.currentState.save();
                              if(user.password != user.confirmPassword){
                                scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: const Text('Senhas não coimcidem!'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              context.read<UserManager>().signup(
                                  user: user,
                                  onSucess: (){
                                    Navigator.pop(context);
                                  },
                                  onFail: (e){
                                    scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text('Falha ao cadastrar: $e'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                              );
                            }
                          },
                          textColor: Colors.white,
                          child: userManager.loading
                              ? const CircularProgressIndicator(
                            valueColor:
                            AlwaysStoppedAnimation(Colors.white),
                          )
                              : const Text(
                            'Criar Conta',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ));
  }
}
