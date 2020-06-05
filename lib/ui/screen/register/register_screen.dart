import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/ui/screen/register/di/register_screen_component.dart';
import 'package:pika_pika_app/ui/screen/register/register_wm.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

class RegisterScreen extends MwwmWidget<RegisterScreenComponent> {
  RegisterScreen([
    WidgetModelBuilder widgetModelBuilder = createRegisterScreenWidgetModel,
  ]) : super(
          dependenciesBuilder: (context) => RegisterScreenComponent(context),
          widgetStateBuilder: () => _RegisterScreenState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _RegisterScreenState extends WidgetState<RegisterScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<RegisterScreenComponent>(context).component.scaffoldKey,
      body: SafeArea(
        child: Center(
          child: StreamedStateBuilder<bool>(
            streamedState: wm.loadState,
            builder: (context, bool isLoading) {
              if (isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return _buildBody();
              }
            },
          ),
        ),
      ),
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
              _buildFirstNameField(),
              _buildLastNameField(),
              _buildPhoneField(),
              _buildPasswordField(),
              _buildRegisterButton(context),
              _buildButtonToLoginMode(),
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

  Widget _buildPhoneField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFieldStateBuilder(
        state: wm.phoneTextState,
        stateBuilder: (context, state) {
          return TextFormField(
            key: Key('phone'),
            controller: wm.phoneChanges.controller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Телефон',
              errorText:
                  state.hasError ? _getFieldErrorText(state.error.e) : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFieldStateBuilder(
        state: wm.passwordTextState,
        stateBuilder: (context, state) {
          return TextFormField(
            key: Key('password'),
            controller: wm.passwordChanges.controller,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Пароль',
              errorText:
                  state.hasError ? _getFieldErrorText(state.error.e) : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: RaisedButton(
        key: Key('register'),
        child: Text(
          'Регистрация',
          style: TextStyle(fontSize: 16.0),
        ),
        color: Colors.indigo,
        textColor: Colors.white,
        onPressed: wm.registerButtonAction,
      ),
    );
  }

  Widget _buildButtonToLoginMode() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Если вы уже зарегистрированы,'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('то выполните'),
              MaterialButton(
                child: Text(
                  'Вход',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                onPressed: wm.switchToLoginAction,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFirstNameField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFieldStateBuilder(
        state: wm.firstNameTextState,
        stateBuilder: (context, state) {
          return TextFormField(
            key: Key('firstName'),
            controller: wm.firstNameChanges.controller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Имя',
              errorText:
                  state.hasError ? _getFieldErrorText(state.error.e) : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildLastNameField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFieldStateBuilder(
        state: wm.lastNameTextState,
        stateBuilder: (context, state) {
          return TextFormField(
            key: Key('lastName'),
            controller: wm.lastNameChanges.controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Фамилия',
              errorText:
                  state.hasError ? _getFieldErrorText(state.error.e) : null,
            ),
          );
        },
      ),
    );
  }

  String _getFieldErrorText(dynamic error) {
    if (error is IncorrectTextException) {
      return error.message;
    }
    return '';
  }
}
