import 'dart:convert';

import 'package:bloc/models/fact.dart';
import 'package:http/http.dart' as http;

class FactsApi {
  static const String _baseUrl = "https://e9812ae4-8099-4188-ae0b-c3eda354b90b.mock.pstmn.io";
  static const String _factsPath = "/only/facts";

  Future<Fact> getFact() async {
    final _factUrl = '$_baseUrl$_factsPath';

    final factResopnse = await http.get(_factUrl);

    if (factResopnse.statusCode != 200 || factResopnse.body == null) {
      return null;
    }

    final factJson = jsonDecode(factResopnse.body);

    final fact = Fact.fromJson(factJson);

    return fact;
  }

}