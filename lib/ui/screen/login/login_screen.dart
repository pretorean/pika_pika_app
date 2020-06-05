import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/ui/screen/login/di/login_screen_component.dart';
import 'package:pika_pika_app/ui/screen/login/login_wm.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

class LoginScreen extends MwwmWidget<LoginScreenComponent> {
  LoginScreen([
    WidgetModelBuilder widgetModelBuilder = createLoginScreenWidgetModel,
  ]) : super(
          dependenciesBuilder: (context) => LoginScreenComponent(context),
          widgetStateBuilder: () => _LoginScreenState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _LoginScreenState extends WidgetState<LoginScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<LoginScreenComponent>(context).component.scaffoldKey,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Form(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildLogoImage(),
              _buildEmailField(),
              _buildPasswordField(),
              _buildLoginButton(context),
              _buildButtonToRegisterMode(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoImage() {
    return Icon(
      Icons.lightbulb_outline,
      size: 150,
      color: Colors.indigo,
    );
  }

  Widget _buildEmailField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        key: Key('email'),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        key: Key('password'),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Пароль',
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 60.0,
        child: RaisedButton(
          key: Key('login'),
          child: Text(
            'Войти',
            style: TextStyle(fontSize: 16.0),
          ),
          color: Colors.indigo,
          textColor: Colors.white,
          onPressed: wm.loginButtonAction,
        ),
      ),
    );
  }

  Widget _buildButtonToRegisterMode() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MaterialButton(
          key: Key('toRegister'),
          child: Text(
            'Зарегистрируйтесь',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
          onPressed: wm.switchToRegisterAction,
        ),
        Text('для доступа к сервису'),
      ],
    );
  }
}
