// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello';

  @override
  String get welcome => 'Welcome';

  @override
  String get splashScreenText => 'Innovative, user-friendly, and easy';

  @override
  String get getStarted => 'Get Started';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get inputError => 'Please enter a valid login and email';

  @override
  String get userName => 'User Name';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get signInWidthGoogle => 'Sign In With Google';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign up';

  @override
  String get email => 'Email';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get haveAccount => 'Already have an account?';

  @override
  String get signIn => 'Sign in';

  @override
  String get youHave => 'You have work today';

  @override
  String get project => 'Project';

  @override
  String get work => 'Work';

  @override
  String get dailyTasks => 'Daily Tasks';

  @override
  String get groceries => 'Groceries';

  @override
  String get todayTasks => 'Today tasks';

  @override
  String get crateNewTask => 'Create New Task';

  @override
  String get taskName => 'Task name';

  @override
  String get category => 'Category';

  @override
  String get education => 'Education';

  @override
  String get dateTime => 'Date & Time';

  @override
  String get startTime => 'Start time';

  @override
  String get endTime => 'End time';

  @override
  String get priority => 'Priority';

  @override
  String get low => 'Low';

  @override
  String get medium => 'Medium';

  @override
  String get high => 'High';

  @override
  String get description => 'Description';

  @override
  String get save => 'Save';

  @override
  String get editTodo => 'Edit todo';

  @override
  String get requiredInput =>
      'Fill in all fields. (Title, Description, Date, Start, End Time)';

  @override
  String get title => 'Title';

  @override
  String get createTodoVoice => 'Create Todo by Voice';

  @override
  String get validEmailError => 'Please enter a valid email address';

  @override
  String get loginUnknownError => 'An error occurred. Please try again.';

  @override
  String get loginUserNotFound => 'No user found with this email';

  @override
  String get loginWrongPassword => 'Incorrect password';

  @override
  String get loginInvalidEmail => 'Invalid email format';

  @override
  String get loginUserDisabled => 'This user has been disabled';

  @override
  String get loginTooManyRequests =>
      'Too many requests. Please try again later';

  @override
  String get loginNetworkFailed => 'Please check your internet connection';

  @override
  String get loginInvalidCredential => 'Invalid email or password';

  @override
  String loginUnknownFirebaseError(Object errorCode) {
    return 'Error occurred: $errorCode';
  }

  @override
  String get todoDelete => 'Do you really want to delete?';

  @override
  String get yes => 'Yes';

  @override
  String get goBack => 'Go back';

  @override
  String get language => 'Switch language';
}
