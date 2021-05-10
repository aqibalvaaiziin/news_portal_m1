import 'package:flutter/material.dart';
import 'profile_page_view.dart';

class ProfilePage extends StatefulWidget {
  final bool isFromRegister;

  const ProfilePage({Key key, this.isFromRegister=false}) : super(key: key);

  @override
  ProfilePageView createState() => new ProfilePageView();
}
