import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/redux/models/app_state_model.dart';
import 'package:news/redux/store_data.dart';
import 'package:news/widgets/splash_scree.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Store<AppState> _store = await createStore();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp(store: _store));
  });
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;

  const MyApp({Key key, this.store}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: widget.store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreenPage(),
      ),
    );
  }
}
