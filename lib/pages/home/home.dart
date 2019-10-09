import 'package:busca_cep/models/endereco.dart';
import 'package:flutter/material.dart';

import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (value) {
                  bloc.input.add(value);
                },
                decoration: InputDecoration(labelText: "CEP"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: StreamBuilder<Endereco>(
                  stream: bloc.output,
                  initialData: Endereco(logradouro: ""),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Erro ao buscar CEP");
                    }

                    Endereco endereco = snapshot.data;
                    return Text(endereco.logradouro);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
