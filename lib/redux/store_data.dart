import 'package:news/redux/models/app_state_model.dart';
import 'package:news/redux/reducers/app_state_reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

Future<Store<AppState>> createStore() async {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    distinct: true,
    middleware: [LoggingMiddleware.printer()],
  );
}
