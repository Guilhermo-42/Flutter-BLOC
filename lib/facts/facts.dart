import 'package:bloc/facts/facts_bloc.dart';
import 'package:bloc/models/fact.dart';
import 'package:bloc/models/http_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FactsScreen extends StatefulWidget {
  _FactsScreenState createState() => _FactsScreenState();
}

class _FactsScreenState extends State<FactsScreen> {
  FactsBloc _bloc;
  String _factText = "";

  @override
  void initState() {
    super.initState();
    _bloc = FactsBloc();
    _bloc.stream.listen(_onDataChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  void _onDataChanged(HttpEvent<Fact> fact) {
    if (fact != null && fact.state == EventState.done) {
      setState(() {
        _factText = fact.data.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              _factText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
                ),
            ),
          ),
          ButtonTheme(
            height: 30.0,
            minWidth: double.maxFinite,
            child: FlatButton(
              child: Text("Get a Fact"),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                _bloc.getAFact();
              },
            ),
          )
        ],
      ),
    );
  }
}
