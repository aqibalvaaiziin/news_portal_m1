import 'package:news/models/topics_model.dart';
import 'package:news/redux/actions/topics_state_action.dart';
import 'package:news/redux/models/topics_state_model.dart';
import 'package:redux/redux.dart';

final topicsReducer = combineReducers<TopicsState>(
    [TypedReducer<TopicsState, dynamic>(_setTopicsState)]);

TopicsState _setTopicsState(TopicsState state, action) {
  // get list
  if (action is SetTopicsList) {
    return state.copyWith(topicsList: action.topicsList);
  }

  // control list
  else if (action is AddItemToTopicsList) {
    return state.copyWith(
      topicsList: state.topicsList
        ..add(
          TopicModel(
            sId: action.idTopic,
            name: action.topicName,
            isSelected: action.isSelected,
          ),
        ),
    );
  } else if (action is RemoveItemFromTopicsList) {
    return state.copyWith(
      topicsList: state.topicsList
        ..forEach(
          (element) {
            if (element.sId == action.idTopics) {
              element.isSelected = !element.isSelected;
            }
          },
        ),
    );
  }

  return state;
}
