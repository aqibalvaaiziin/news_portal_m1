import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/api/services/user_service.dart';
import 'package:news/helpers/preferences/preferences_data.dart';
import 'package:news/models/topics_model.dart';
import 'package:news/redux/actions/topics_state_action.dart';
import 'package:news/redux/models/app_state_model.dart';
import 'package:news/screens/navigator_page/navigator_page.dart';
import 'package:news/widgets/reoute_navigator.dart';
import 'package:redux/redux.dart';
import './topic_list_page.dart';

abstract class TopicListPageViewModel extends State<TopicListPage> {
  double width;
  double height;
  UserServices userServices = UserServices();
  Store<AppState> store;
  PreferencesData preferencesData = PreferencesData();
  bool isLoading = false;
  // ignore: deprecated_member_use
  List<TopicModel> defaultValue = List<TopicModel>();

  getListTopics() {
    store.dispatch(SetTopicsList(defaultValue));
    userServices.getListTopic().then((value) {
      var jsonObject = TopicListResponse.fromJson(value.data);
      if (jsonObject.statusCode == 200) {
        jsonObject.data.forEach((element) {
          setState(() {
            if (element.name == "News") {
              store.dispatch(AddItemToTopicsList(
                element.sId,
                element.name,
                true,
              ));
            } else {
              store.dispatch(AddItemToTopicsList(
                element.sId,
                element.name,
                false,
              ));
            }
          });
        });
      }
    });
  }

  chooseTopicAction() async {
    setState(() {
      isLoading = true;
    });
    var dataSelectedTopic = store.state.topicsState.topicsList;
    dataSelectedTopic.forEach((element) async {
      if (element.isSelected) {
        await userServices.addTopic(element.sId);
      }
    });
    await Future.delayed(Duration(seconds: 4), () {
      preferencesData.setIsUserHasTopic(true);
      nextPageRemove(context, NavigatorPage(currentPage: 0));
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context);
      getListTopics();
    });
  }
}
