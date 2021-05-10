
import 'package:news/redux/models/app_state_model.dart';
import 'package:news/redux/reducers/news_state_reducer.dart';
import 'package:news/redux/reducers/topics_state_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      newsState: newsReducer(
        state.newsState,
        action,
      ),
      topicsState: topicsReducer(
        state.topicsState,
        action,
      ));
}
