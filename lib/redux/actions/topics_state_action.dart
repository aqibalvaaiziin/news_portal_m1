
import 'package:news/models/topics_model.dart';

class SetTopicsList {
  final List<TopicModel> topicsList;
  SetTopicsList(this.topicsList);
}

class AddItemToTopicsList {
  final String idTopic;
  final String topicName;
  final bool isSelected;

  AddItemToTopicsList(
    this.idTopic,
    this.topicName,
    this.isSelected,
  );
}

class RemoveItemFromTopicsList {
  final String idTopics;

  RemoveItemFromTopicsList(this.idTopics);
}
