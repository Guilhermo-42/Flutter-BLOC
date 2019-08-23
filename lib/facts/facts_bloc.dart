import 'dart:async';

import 'package:bloc/models/fact.dart';
import 'package:bloc/models/http_event.dart';
import 'package:bloc/network/fact_api.dart';

class FactsBloc {
  final StreamController _controller = StreamController<HttpEvent<Fact>>();

  Stream<HttpEvent<Fact>> get stream => _controller.stream;

  dispose() => _controller.close();

  getAFact() async {
    try {
      _controller.sink.add(HttpEvent<Fact>(state: EventState.loading));

      final fact = await FactsApi().getFact();

      if (fact == null) {
        _controller.sink.add(HttpEvent<Fact>(state: EventState.error));
        return;
      }

      _controller.sink.add(HttpEvent<Fact>(state: EventState.done, data: fact));
    } catch (error) {
      _controller.sink.add(HttpEvent<Fact>(state: EventState.error));
    }
  }
}
