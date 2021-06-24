import 'dart:async';

import 'package:ecommerce_frontend/controller/user_controller.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  final UserController userController = UserController();
  StreamController<List<User>> streamController =
      StreamController<List<User>>();
  List<User> users = null;
  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  void loadUsers() async {
    this.users = await userController.listAll();
    streamController.sink.add(this.users);
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
  }

  void _removeUser(String id) async {
    try {
      await userController.delete(id);
      var list_user = await userController.listAll();
      streamController.sink.add(list_user);
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro ao excluir usuario')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Listagem Usuario'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.USER_FUNCTIONARY);
                },
                icon: Icon(Icons.person_add))
          ],
        ),
        body: Container(
            child: Center(
          child: StreamBuilder<List<User>>(
              stream: streamController.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data[index];
                        return Card(
                          child: ListTile(
                              title: Text(data.name),
                              subtitle: Text(data.email),
                              trailing: Container(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.delete),
                                          color: Colors.red,
                                          onPressed: () async {
                                            showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      title: Text(
                                                          'Excluir usuario'),
                                                      content:
                                                          Text('Tem certeza?'),
                                                      actions: <Widget>[
                                                        ElevatedButton(
                                                          child: Text('Não'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        ElevatedButton(
                                                          child: Text('Sim'),
                                                          onPressed: () {
                                                            print('aqui');
                                                            _removeUser(
                                                                data.id);
                                                          },
                                                        ),
                                                      ],
                                                    ));
                                          }),
                                      IconButton(
                                          onPressed: () {
                                            if (data.role == "cliente") {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      AppRoutes.REGISTER);
                                            } else {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      AppRoutes
                                                          .USER_FUNCTIONARY);
                                            }
                                          },
                                          icon: Icon(Icons.edit),
                                          color: Colors.orange)
                                    ],
                                  ))),
                        );
                      });
                } else {
                  return Text("Sem usuarios cadastrados");
                }
              }),
        )));
  }
}
