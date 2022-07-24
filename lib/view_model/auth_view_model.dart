import 'dart:async';
import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/widgets.dart';
import 'package:students_details_online/services/auth_service.dart';
import 'package:students_details_online/services/error_resopnses.dart';
import 'package:students_details_online/services/response_status.dart';
import 'package:students_details_online/utils/navigation_utils.dart';

class AuthViewModel extends ChangeNotifier {

  String _logingEmail = '';
  String _loginPassword = '' ;

  String _signInEmail = '';
  String _signInName = '';
  String _signInPassword = '';
  String _signConfirmInPassword = '';

  bool _authLoading = false ;  
  
  String _dialogMessage = '';
  String _dialogTitle = '';
  ContentType _dialogTop = ContentType.failure;
  bool _dialogShow = false;
  
  bool get authLoading => _authLoading ;
  bool get dialogShow => _dialogShow;
  String get dialogMessage => _dialogMessage;
  ContentType get dialogTop => _dialogTop;
  String get dialogTitle => _dialogTitle;

  setAuthLoading(loading){
    _authLoading = loading ;
    notifyListeners();
  }

  setLogingEmail(String email) {
    _logingEmail = email;
  }

  setLoginPassword(String password) {
    _loginPassword = password;
  }

  setSignInName(String name) {
    _signInName = name;
  }

  setSignInEmail(String email) {
    _signInEmail = email;
  }

  setSignInPassword(String password) {
    _signInPassword = password;
  }

  setSignInConfirmPassword(String confirmPassword) {
    _signConfirmInPassword = confirmPassword;
  }

    _setDialogShow(dialogShow){
    _dialogShow = dialogShow;
    notifyListeners();
  }

  removeValues(){
  _signInEmail = '';
  _signInName = '';
  _signInPassword = '';
  _signConfirmInPassword = '';
  }
 
  _callDialog({required seconds}) {

    _setDialogShow(true);

    Timer(Duration(seconds: seconds), () =>_setDialogShow(false));

  }

  checkLogInValid(context) {
    if (_logingEmail == '' || _loginPassword == '') {

      isInValid();

    } else {

      isValid(_logingEmail,_loginPassword,null,context);

    }
  }

  setDialog(String dialog , ContentType dialogTop, String dialogTitle){
    _dialogMessage = dialog;
    _dialogTop = dialogTop ;
    _dialogTitle = dialogTitle;
    notifyListeners();
  }

  checkSignInValid(context) {

    if (_signInName == '' ||
        _signInEmail == '' ||
        _signConfirmInPassword == '' ||
        _signInPassword == '' || 
        _signInPassword != _signConfirmInPassword
        ) {

      isInValid();

    } else {

      isValid(_signInEmail,_signInPassword,_signInName,context);

    }
  }

  isValid(String email,String password,String? name, context) async{

    log('...........isValid');

    Object response;

    setAuthLoading(true);

    if (name == null) {

    response = await AuthServices.loginUser(email, password);

    }else{

    response = await AuthServices.createUser(email, password, name);

    }

    if(response is AuthSuccess){

      log('................authSuccess');

      setAuthLoading(false);

      openHomeScreen(context);
      
    }

    if (response is NetworkError) {

      log('................badConnection');

      setAuthLoading(false);

      setDialog('Bad Connection ! , Make  sure about connection !', ContentType.failure, 'Network Error !');

      _callDialog(seconds: 3);

    }

    if (response is AuthFailed) {

      final String error = response.response.toString();

      log('................authFailed');

      setAuthLoading(false);

      if (name != null) {

        if (error == ErrorResponses.badEmail) {

          setDialog('Enter valid Email ! , Make sure This is your Email !',ContentType.failure,'Oh snap!');
          
        }else if(error == ErrorResponses.badPassword){

          setDialog('Fields Required Minmum 6 values , Enter password Morethan 6 !',ContentType.warning,'Warning?');

        }else if(error == ErrorResponses.existingEmail){

          setDialog('Email Already Registered ! , Make sure This is Your mail ?',ContentType.warning,'Warning');

        }

        

      } else {

        if (error == ErrorResponses.notAccount) {

          setDialog('Email not Registered ! , Make sure This Youre Email? ',ContentType.warning,'Warning?');
          
        }else if(error == ErrorResponses.wrongPassword){

          setDialog('Wrong password ! , Enter valid password',ContentType.failure,'Oh snap!');

        }else if(error == ErrorResponses.badEmail){

          setDialog('The Email occures problem , Enter valid email !',ContentType.warning,'Warning?');

        }

        
      }

      if (_dialogMessage == '') {

        setDialog('Can\'t make Action Now ! try Again Later',ContentType.help,'Problem?');

      }

      _callDialog(seconds: 3);

    }

  }

  isInValid(){

    log('...........isInValid');
    
    setDialog('The fields are empty , Fill all values', ContentType.warning,'Warning?');

    _callDialog(seconds: 3);

  }


}
