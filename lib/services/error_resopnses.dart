class ErrorResponses{

  //signIn Ecxeptions

  static String badEmail = '[firebase_auth/invalid-email] The email address is badly formatted.';

  static String badPassword = '[firebase_auth/weak-password] Password should be at least 6 characters';

  static String existingEmail = '[firebase_auth/email-already-in-use] The email address is already in use by another account.';

    //logIn Ecxeptions

  static String notAccount = '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.';

  static String wrongPassword = '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.';

}
