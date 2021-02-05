import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_scramble_frontend/lib/auth/bloc/auth_bloc.dart' as auth;
import 'package:word_scramble_frontend/lib/model/user.dart';
import 'package:word_scramble_frontend/ui/login/bloc/login_bloc.dart';

class Login extends StatefulWidget {
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  LoginBloc _bloc = new LoginBloc();
  Map<String, dynamic> errors;
  String _username;
  String _name;
  void initState() {
    super.initState();
    _bloc.listen((state) {
      if (state is UserLoggedInState) {
        BlocProvider.of<auth.AuthBloc>(context)
            .add(auth.LoginEvent(state.data));
        Navigator.of(context).pop();
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Join The Game"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: BlocBuilder(
                    cubit: _bloc,
                    builder: (context, state) {
                      if (state is LoginInitial || state is FailToLoginState) {
                        return Padding(
                            padding: EdgeInsets.all(20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 18,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Email",
                                            style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 82,
                                        child: TextFormField(
                                          onSaved: (String value) {
                                            _username = value;
                                          },
                                          validator: isUsernameValid,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: TextStyle(fontSize: 24),
                                          decoration: InputDecoration(
                                              hintText: "Email",
                                              filled: true,
                                              fillColor: Colors.grey[200],
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 16.0)),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 20,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 18,
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Name",
                                            style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 82,
                                        child: TextFormField(
                                          onSaved: (String value) {
                                            _name = value;
                                          },
                                          validator: isNameValid,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: TextStyle(fontSize: 24),
                                          decoration: InputDecoration(
                                              hintText: "Name",
                                              filled: true,
                                              fillColor: Colors.grey[200],
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 16.0)),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(height: 20),
                                  Container(
                                    alignment: Alignment.center,
                                    child: RaisedButton(
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          User data = new User();
                                          data.userType = "PLAYER";
                                          data.username = _username;
                                          data.name = _name;
                                          _bloc.add(
                                              CheckUserExistencyEvent(data));
                                        }
                                      },
                                      child: Text("Join"),
                                    ),
                                  )
                                ],
                              ),
                            ));
                      } else if (state is LoadingState) {
                        return Container(child: Text("Loading...."));
                      }
                      return Container();
                    },
                  )),
            ),
          ),
        ));
  }

  String isUsernameValid(String value) {
    if (value.isEmpty) return "Please provide this data";
    if (errors != null && errors.containsKey("username"))
      return errors["username"][0];
    return null;
  }

  String isNameValid(String value) {
    if (value.isEmpty) return "Please Provide this data";
    if (errors != null && errors.containsKey("name")) return errors["name"][0];
    return null;
  }
}
