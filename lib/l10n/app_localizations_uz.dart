// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get hello => 'Salom';

  @override
  String get welcome => 'Xush kelibsiz';

  @override
  String get splashScreenText => 'Innovatsion, qulay va oson';

  @override
  String get getStarted => 'Boshlash';

  @override
  String get welcomeBack => 'Xush kelibsiz!';

  @override
  String get inputError => 'Iltimos, login va emailni to‘g‘ri kiriting';

  @override
  String get userName => 'Foydalanuvchi nomi';

  @override
  String get password => 'Parol';

  @override
  String get login => 'Kirish';

  @override
  String get signInWidthGoogle => 'Google orqali kirish';

  @override
  String get dontHaveAccount => 'Hisobingiz yo‘qmi?';

  @override
  String get signUp => 'Ro‘yxatdan o‘tish';

  @override
  String get email => 'Email';

  @override
  String get confirmPassword => 'Parolni tasdiqlang';

  @override
  String get haveAccount => 'Allaqachon hisobingiz bormi?';

  @override
  String get signIn => 'Kirish';

  @override
  String get youHave => 'Bugun bajariladigan ishingiz bor';

  @override
  String get project => 'Loyiha';

  @override
  String get work => 'Ish';

  @override
  String get dailyTasks => 'Kundalik vazifalar';

  @override
  String get groceries => 'Xaridlar';

  @override
  String get todayTasks => 'Bugungi vazifalar';

  @override
  String get crateNewTask => 'Yangi vazifa yarating';

  @override
  String get taskName => 'Vazifa nomi';

  @override
  String get category => 'Kategoriya';

  @override
  String get education => 'Ta\'lim';

  @override
  String get dateTime => 'Sana va vaqt';

  @override
  String get startTime => 'Boshlanish vaqti';

  @override
  String get endTime => 'Tugash vaqti';

  @override
  String get priority => 'Muhimlik darajasi';

  @override
  String get low => 'Past';

  @override
  String get medium => 'O‘rta';

  @override
  String get high => 'Yuqori';

  @override
  String get description => 'Tavsif';

  @override
  String get save => 'Saqlash';

  @override
  String get editTodo => 'Vazifani tahrirlash';

  @override
  String get requiredInput =>
      'Barcha maydonlarni to‘ldiring. (Sarlavha, Tavsif, Sana, Boshlanish va Tugash vaqti)';

  @override
  String get title => 'Sarlavha';

  @override
  String get createTodoVoice => 'Vazifani ovoz bilan yarating';

  @override
  String get validEmailError => 'Iltimos, to‘g‘ri email manzilini kiriting';

  @override
  String get loginUnknownError =>
      'Xatolik yuz berdi. Iltimos, qayta urinib ko‘ring.';

  @override
  String get loginUserNotFound => 'Bunday foydalanuvchi topilmadi';

  @override
  String get loginWrongPassword => 'Noto‘g‘ri parol';

  @override
  String get loginInvalidEmail => 'Noto‘g‘ri email format';

  @override
  String get loginUserDisabled => 'Foydalanuvchi hisobi o‘chirilgan';

  @override
  String get loginTooManyRequests =>
      'Juda ko‘p urinish. Biroz kutib qayta urinib ko‘ring';

  @override
  String get loginNetworkFailed => 'Internet ulanishini tekshiring';

  @override
  String get loginInvalidCredential => 'Email yoki parol noto‘g‘ri';

  @override
  String loginUnknownFirebaseError(Object errorCode) {
    return 'Xatolik yuz berdi: $errorCode';
  }

  @override
  String get todoDelete => 'Siz rostdan ham o\'chirmoqchimisiz';

  @override
  String get yes => 'Ha';

  @override
  String get goBack => 'Ortga qaytish';

  @override
  String get language => 'Tilni almashtirish';
}
