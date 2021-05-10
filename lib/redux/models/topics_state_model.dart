
import 'package:news/models/topics_model.dart';

class TopicsState {
  final List<TopicModel> topicsList;
  final String idTopic;
  final String topicName;
  final bool isSelected;

  TopicsState({
    this.topicsList,
    this.idTopic,
    this.topicName,
    this.isSelected,
  });

  factory TopicsState.initial() {
    return TopicsState(
      // ignore: deprecated_member_use
      topicsList: List<TopicModel>(),
      idTopic: "",
      topicName: "",
      isSelected: false,
    );
  }

  TopicsState copyWith({
    List<TopicModel> topicsList,
    String idTopic,
    String topicName,
    bool isSelected,
  }) {
    return TopicsState(
      topicsList: topicsList ?? this.topicsList,
      idTopic: idTopic ?? this.idTopic,
      topicName: topicName ?? this.topicName,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopicsState &&
          runtimeType == other.runtimeType &&
          topicsList == other.topicsList &&
          idTopic == other.idTopic &&
          topicName == other.topicName &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      topicsList.hashCode ^
      idTopic.hashCode ^
      topicName.hashCode ^
      isSelected.hashCode;
}
