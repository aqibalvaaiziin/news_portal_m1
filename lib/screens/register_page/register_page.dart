import 'package:flutter/material.dart';
import './register_page_view.dart';

class RegisterPage extends StatefulWidget {
  final String from;

  const RegisterPage({Key key, this.from}) : super(key: key);

  @override
  RegisterPageView createState() => new RegisterPageView();
}
