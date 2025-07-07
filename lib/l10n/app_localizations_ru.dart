// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get hello => 'Привет';

  @override
  String get welcome => 'Добро пожаловать';

  @override
  String get splashScreenText => 'Инновационно, удобно и просто';

  @override
  String get getStarted => 'Начать';

  @override
  String get welcomeBack => 'С возвращением!';

  @override
  String get inputError =>
      'Пожалуйста, введите корректные логин и электронную почту';

  @override
  String get userName => 'Имя пользователя';

  @override
  String get password => 'Пароль';

  @override
  String get login => 'Войти';

  @override
  String get signInWidthGoogle => 'Войти через Google';

  @override
  String get dontHaveAccount => 'Нет аккаунта?';

  @override
  String get signUp => 'Зарегистрироваться';

  @override
  String get email => 'Эл. почта';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get haveAccount => 'Уже есть аккаунт?';

  @override
  String get signIn => 'Вход';

  @override
  String get youHave => 'У вас есть задачи на сегодня';

  @override
  String get project => 'Проект';

  @override
  String get work => 'Работа';

  @override
  String get dailyTasks => 'Ежедневные задачи';

  @override
  String get groceries => 'Покупки';

  @override
  String get todayTasks => 'Задачи на сегодня';

  @override
  String get crateNewTask => 'Создать новую задачу';

  @override
  String get taskName => 'Название задачи';

  @override
  String get category => 'Категория';

  @override
  String get education => 'Образование';

  @override
  String get dateTime => 'Дата и время';

  @override
  String get startTime => 'Время начала';

  @override
  String get endTime => 'Время окончания';

  @override
  String get priority => 'Приоритет';

  @override
  String get low => 'Низкий';

  @override
  String get medium => 'Средний';

  @override
  String get high => 'Высокий';

  @override
  String get description => 'Описание';

  @override
  String get save => 'Сохранить';

  @override
  String get editTodo => 'Редактировать задачу';

  @override
  String get requiredInput =>
      'Заполните все поля. (Заголовок, Описание, Дата, Начало, Конец)';

  @override
  String get title => 'Заголовок';

  @override
  String get createTodoVoice => 'Создать задачу голосом';

  @override
  String get validEmailError => 'Пожалуйста, введите корректный адрес почты';

  @override
  String get loginUnknownError =>
      'Произошла ошибка. Пожалуйста, попробуйте ещё раз.';

  @override
  String get loginUserNotFound => 'Пользователь не найден';

  @override
  String get loginWrongPassword => 'Неправильный пароль';

  @override
  String get loginInvalidEmail => 'Неверный формат электронной почты';

  @override
  String get loginUserDisabled => 'Этот пользователь заблокирован';

  @override
  String get loginTooManyRequests => 'Слишком много попыток. Попробуйте позже';

  @override
  String get loginNetworkFailed => 'Проверьте подключение к интернету';

  @override
  String get loginInvalidCredential => 'Неверный email или пароль';

  @override
  String loginUnknownFirebaseError(Object errorCode) {
    return 'Произошла ошибка: $errorCode';
  }

  @override
  String get todoDelete => 'Вы действительно хотите удалить?';

  @override
  String get yes => 'да';

  @override
  String get goBack => 'возвращаться';

  @override
  String get language => 'Переключить язык';
}
