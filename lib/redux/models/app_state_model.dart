
import 'package:news/redux/models/news_state_model.dart';
import 'package:news/redux/models/topics_state_model.dart';

class AppState {
  final NewsState newsState;
  final TopicsState topicsState;

  AppState({
    this.newsState,
    this.topicsState,
  });

  factory AppState.initial() {
    return AppState(
      newsState: NewsState.initial(),
      topicsState: TopicsState.initial(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          topicsState == other.topicsState &&
          newsState == other.newsState;

  @override
  int get hashCode => newsState.hashCode ^ topicsState.hashCode;
}
