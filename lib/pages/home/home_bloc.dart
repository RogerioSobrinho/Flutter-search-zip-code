import 'dart:async';

import 'package:busca_cep/models/endereco.dart';
import 'package:dio/dio.dart';

class HomeBloc {
  StreamController<String> _streamController = StreamController<String>();
  Sink<String> get input => _streamController.sink;
  Stream<Endereco> get output => _streamController.stream
      .where((cep) => cep.length > 7)
      .asyncMap((cep) => _buscaCEP(cep));

  String url(String cep) {
    return "https://viacep.com.br/ws/$cep/json/";
  }

  Future<Endereco> _buscaCEP(String cep) async {
    Response response = await Dio().get(url(cep));
    return Endereco.fromJson(response.data);
  }
}
