import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'id', 'ms'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? idText = '',
    String? msText = '',
  }) =>
      [enText, idText, msText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Login
  {
    'to9hgnb5': {
      'en': 'Welle',
      'id': '',
      'ms': '',
    },
    '3p97u62u': {
      'en': 'Get Started',
      'id': 'Selamat Datang kembali!',
      'ms': 'Selamat kembali!',
    },
    'xkz4xjo6': {
      'en': 'Use the form below to access your account.',
      'id': 'Gunakan formulir di bawah ini untuk mengakses akun Anda.',
      'ms': 'Gunakan borang di bawah untuk mengakses akaun anda.',
    },
    'wkv69t7b': {
      'en': 'Continue with Google',
      'id': '',
      'ms': '',
    },
    'i2ehnfc9': {
      'en': 'Continue with Apple',
      'id': '',
      'ms': '',
    },
    'zy328lg7': {
      'en': 'Use a social platform to continue',
      'id': 'Gunakan platform sosial untuk melanjutkan',
      'ms': 'Gunakan platform sosial untuk meneruskan',
    },
    'tcu0c8bu': {
      'en': 'Don\'t have an account?',
      'id': 'Tidak punya akun?',
      'ms': 'Tiada akaun?',
    },
    'kk2rdqi2': {
      'en': 'Create Account',
      'id': 'Buat Akun',
      'ms': 'Buat akaun',
    },
    'iha5socs': {
      'en': 'Home',
      'id': 'Rumah',
      'ms': 'Rumah',
    },
  },
  // forgotPassword
  {
    '3hcuc8v6': {
      'en': 'Forgot Password',
      'id': 'Tidak ingat kata sandi',
      'ms': 'Lupa kata laluan',
    },
    'sjjd1jb9': {
      'en':
          'Don\'t remember your password? Enter the email associated with your account below and we will send you a new link.',
      'id':
          'Tidak ingat kata sandi Anda? Masukkan email yang terkait dengan akun Anda di bawah ini dan kami akan mengirimkan tautan baru kepada Anda.',
      'ms':
          'Tidak ingat kata laluan anda? Masukkan e-mel yang dikaitkan dengan akaun anda di bawah dan kami akan menghantar pautan baharu kepada anda.',
    },
    'tzm5opaa': {
      'en': 'Email Address',
      'id': 'Alamat email',
      'ms': 'Alamat emel',
    },
    'uvsotzng': {
      'en': 'Please enter a valid email...',
      'id': 'Tolong masukkan email yang benar...',
      'ms': 'Sila masukkan e-mel yang sah...',
    },
    '3sdzjivm': {
      'en': 'Send Reset Link',
      'id': 'Kirim Setel Ulang Tautan',
      'ms': 'Hantar Pautan Tetapan Semula',
    },
    '8p6xd6cl': {
      'en': 'Home',
      'id': 'Rumah',
      'ms': 'Rumah',
    },
  },
  // Home
  {
    'mgxq2qyz': {
      'en': 'Home',
      'id': 'Dasbor',
      'ms': 'Papan pemuka',
    },
    'q4v6wfwh': {
      'en': '7900.00',
      'id': '',
      'ms': '',
    },
    'luiqkd7s': {
      'en': 'mins',
      'id': '',
      'ms': '',
    },
    '8hwzehp0': {
      'en': 'Search...',
      'id': '',
      'ms': '',
    },
    'xrso6rib': {
      'en': 'Frequent Callers',
      'id': '',
      'ms': '',
    },
    'dzdqw9bb': {
      'en': '604-428-4319',
      'id': '',
      'ms': '',
    },
    'zhas45fk': {
      'en': 'bring all',
      'id': '',
      'ms': '',
    },
    '5uo3qjlc': {
      'en': '604-428-4319',
      'id': '',
      'ms': '',
    },
    'a3vdnvr6': {
      'en': 'bring all',
      'id': '',
      'ms': '',
    },
    'tlil6q4h': {
      'en': '604-428-4319',
      'id': '',
      'ms': '',
    },
    'd7lrs2hm': {
      'en': 'bring all',
      'id': '',
      'ms': '',
    },
    'tfhc07bg': {
      'en': '604-428-4319',
      'id': '',
      'ms': '',
    },
    'accpjwx8': {
      'en': 'bring all',
      'id': '',
      'ms': '',
    },
    'bxucu1g4': {
      'en': 'Recent Calls',
      'id': '',
      'ms': '',
    },
    'rkuzj1lr': {
      'en': 'Task Type',
      'id': '',
      'ms': '',
    },
    'nsubd3sr': {
      'en':
          'Task Description here this one is really long and it goes over maybe? And goes to two lines.',
      'id': '',
      'ms': '',
    },
    'zrkace4l': {
      'en': 'Due',
      'id': '',
      'ms': '',
    },
    'o3h1mfti': {
      'en': 'Today, 5:30pm',
      'id': '',
      'ms': '',
    },
    'tck2wvct': {
      'en': 'Update',
      'id': '',
      'ms': '',
    },
    'c04dnntd': {
      'en': '1',
      'id': '',
      'ms': '',
    },
    'cfdl1890': {
      'en': 'Task Type',
      'id': '',
      'ms': '',
    },
    'fa0rwy2b': {
      'en':
          'Task Description here this one is really long and it goes over maybe? And goes to two lines.',
      'id': '',
      'ms': '',
    },
    'd4xrkzxq': {
      'en': 'Due',
      'id': '',
      'ms': '',
    },
    'psvonapl': {
      'en': 'Today, 5:30pm',
      'id': '',
      'ms': '',
    },
    'yrjblp21': {
      'en': 'Update',
      'id': '',
      'ms': '',
    },
    'o09po239': {
      'en': '1',
      'id': '',
      'ms': '',
    },
    'xdxbdj20': {
      'en': '__',
      'id': '__',
      'ms': '__',
    },
  },
  // Dashboard
  {
    'ck4s887c': {
      'en': 'Dashboard',
      'id': '',
      'ms': '',
    },
    't94uix4m': {
      'en': 'Call Log',
      'id': '',
      'ms': '',
    },
    'aaqzxk1y': {
      'en': 'Contact',
      'id': '',
      'ms': '',
    },
    'nylhjf4j': {
      'en': 'Calendar',
      'id': '',
      'ms': '',
    },
    'nh7786w7': {
      'en': 'Stats',
      'id': '',
      'ms': '',
    },
    'j08eiorc': {
      'en': '__',
      'id': '__',
      'ms': '__',
    },
  },
  // ProfilePage
  {
    'ouf1pg9p': {
      'en': 'My Profile',
      'id': '',
      'ms': '',
    },
    'ejribcl3': {
      'en': 'Andrea Davis',
      'id': '',
      'ms': '',
    },
    '8mhy5v1a': {
      'en': '300.00',
      'id': '',
      'ms': '',
    },
    'cjx0m47s': {
      'en': 'Minutes Balance',
      'id': '',
      'ms': '',
    },
    'kyx9dlyr': {
      'en': 'Account Information',
      'id': '',
      'ms': '',
    },
    'qw1nibaz': {
      'en': 'Your Numbers',
      'id': '',
      'ms': '',
    },
    'xy5qen2a': {
      'en': 'Add Balance',
      'id': '',
      'ms': '',
    },
    'k6nu4lut': {
      'en': 'Subscription',
      'id': '',
      'ms': '',
    },
    '1tylep7e': {
      'en': 'Purchase History',
      'id': '',
      'ms': '',
    },
    '0mpqzrgv': {
      'en': 'Language',
      'id': '',
      'ms': '',
    },
    'faq4kkjn': {
      'en': 'Notification',
      'id': '',
      'ms': '',
    },
    'q4kd22f1': {
      'en': 'Settings',
      'id': '',
      'ms': '',
    },
    'yy264ngy': {
      'en': 'Feedback',
      'id': '',
      'ms': '',
    },
    'bkxff7sk': {
      'en': 'Log Out',
      'id': '',
      'ms': '',
    },
    'o3dp9tss': {
      'en': '__',
      'id': '__',
      'ms': '__',
    },
  },
  // ProfilePage_accountInformation
  {
    '20uycztj': {
      'en': 'Account Information',
      'id': '',
      'ms': '',
    },
    '6ufpspv1': {
      'en': 'Change Photo',
      'id': '',
      'ms': '',
    },
    'tlgpgz22': {
      'en': 'Your Name',
      'id': '',
      'ms': '',
    },
    'fj3ppxfo': {
      'en': 'Business Name',
      'id': '',
      'ms': '',
    },
    'zvwapsbt': {
      'en': 'The email associated with this account is:',
      'id': '',
      'ms': '',
    },
    'w3r4islg': {
      'en': 'Save Changes',
      'id': '',
      'ms': '',
    },
  },
  // Design_prompt
  {
    'i3dv1ryy': {
      'en': 'Give your AI a short title',
      'id': '',
      'ms': '',
    },
    'wvh1p7xs': {
      'en': 'Describe how you want the AI to respond.',
      'id': '',
      'ms': '',
    },
    'lxy19f81': {
      'en': 'Character limit exceeded',
      'id': '',
      'ms': '',
    },
    't1i6uxat': {
      'en': '0/1000 Characters',
      'id': '',
      'ms': '',
    },
    '70jnsx6d': {
      'en': 'Voice',
      'id': '',
      'ms': '',
    },
    'hxp1cccu': {
      'en': 'Lulu',
      'id': '',
      'ms': '',
    },
    'z56nqsrt': {
      'en': 'Lulu',
      'id': '',
      'ms': '',
    },
    '7397zig1': {
      'en': 'Search...',
      'id': '',
      'ms': '',
    },
    'h9nkdild': {
      'en': 'Lulu',
      'id': '',
      'ms': '',
    },
    'jgflfnn4': {
      'en': 'Tuttut',
      'id': '',
      'ms': '',
    },
    '7mcpec5c': {
      'en': 'Pipi',
      'id': '',
      'ms': '',
    },
    'ni8j9nvq': {
      'en': 'Add tags',
      'id': '',
      'ms': '',
    },
    '3z42bwc8': {
      'en': 'General',
      'id': '',
      'ms': '',
    },
    'fr48pxfz': {
      'en': 'Appointment',
      'id': '',
      'ms': '',
    },
    's1u2dlym': {
      'en': 'Customer Support',
      'id': '',
      'ms': '',
    },
    '61wvrivn': {
      'en': 'FAQ',
      'id': '',
      'ms': '',
    },
    '5x73mnyy': {
      'en': 'Order',
      'id': '',
      'ms': '',
    },
    'i8rt6q27': {
      'en': 'General',
      'id': '',
      'ms': '',
    },
    'vv4z4d2a': {
      'en': 'Set as the default project',
      'id': '',
      'ms': '',
    },
    'tga5op98': {
      'en': 'Get Started',
      'id': '',
      'ms': '',
    },
    'tuk0mw7l': {
      'en': 'Add Projects',
      'id': 'Tambahkan Anggota',
      'ms': 'Tambah Ahli',
    },
    'pqq1n229': {
      'en': '__',
      'id': '__',
      'ms': '__',
    },
  },
  // Dashboard_calendar
  {
    'wqvy04jy': {
      'en': 'Month',
      'id': '',
      'ms': '',
    },
    't9yocaqa': {
      'en': 'Coming Up',
      'id': '',
      'ms': '',
    },
    'iitxtiov': {
      'en': 'Open source Table Calaendar로 교체하기',
      'id': '',
      'ms': '',
    },
    'in0dupmb': {
      'en': '2:20pm',
      'id': '',
      'ms': '',
    },
    '6pe93hbe': {
      'en': 'Wed, 03/08/2022',
      'id': '',
      'ms': '',
    },
    'rvhu58sc': {
      'en': 'Past Due',
      'id': '',
      'ms': '',
    },
    'c5xne56e': {
      'en': 'Only show daily schedules here.....',
      'id': '',
      'ms': '',
    },
    '167hjbsf': {
      'en': '2:20pm',
      'id': '',
      'ms': '',
    },
    '83snlijf': {
      'en': 'Wed, 03/08/2022',
      'id': '',
      'ms': '',
    },
    '0gn2jgaf': {
      'en': 'Week',
      'id': '',
      'ms': '',
    },
    'vvzr57qp': {
      'en': 'Coming Up',
      'id': '',
      'ms': '',
    },
    'mcgbk0ff': {
      'en': 'Doctors Check In',
      'id': '',
      'ms': '',
    },
    'tctpeis3': {
      'en': '2:20pm',
      'id': '',
      'ms': '',
    },
    'd67z9be9': {
      'en': 'Wed, 03/08/2022',
      'id': '',
      'ms': '',
    },
    'a0rpp3vt': {
      'en': 'Past Due',
      'id': '',
      'ms': '',
    },
    'mbi4z709': {
      'en': 'Check In',
      'id': '',
      'ms': '',
    },
    'f9qgwafd': {
      'en': '2:20pm',
      'id': '',
      'ms': '',
    },
    'sc4pxpnn': {
      'en': 'Wed, 03/08/2022',
      'id': '',
      'ms': '',
    },
    '0561dbzs': {
      'en': 'Calendar',
      'id': '',
      'ms': '',
    },
    'utbe06o4': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
  },
  // Notification
  {
    'ldojmdfs': {
      'en': 'Friend Request',
      'id': '',
      'ms': '',
    },
    'j7zq6go2': {
      'en': 'John Smith has requested to be friends.',
      'id': '',
      'ms': '',
    },
    'o7nuzu9b': {
      'en': 'Haily Brown',
      'id': '',
      'ms': '',
    },
    'nsqw8pso': {
      'en': '@brownisthenewblack',
      'id': '',
      'ms': '',
    },
    'gsnx91aa': {
      'en': '2 hours ago',
      'id': '',
      'ms': '',
    },
    '01ak2am5': {
      'en': 'Friend Request',
      'id': '',
      'ms': '',
    },
    'zrnxfwfv': {
      'en': 'John Smith has requested to be friends.',
      'id': '',
      'ms': '',
    },
    '2z453j8v': {
      'en': 'John Smith',
      'id': '',
      'ms': '',
    },
    '5nwnt2rg': {
      'en': '@johnsmithly',
      'id': '',
      'ms': '',
    },
    'jrn0r5qa': {
      'en': '2 hours ago',
      'id': '',
      'ms': '',
    },
    'fnkuruzi': {
      'en': 'New Like!',
      'id': '',
      'ms': '',
    },
    'dnaz696u': {
      'en': 'You have a new like from John Smith.',
      'id': '',
      'ms': '',
    },
    '8157l58e': {
      'en': '2 hours ago',
      'id': '',
      'ms': '',
    },
    'rn2krffg': {
      'en': 'Notification',
      'id': 'Tambahkan Anggota',
      'ms': 'Tambah Ahli',
    },
    'ctdge7ub': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
  },
  // Design_promptEdit
  {
    'aoi6y8ti': {
      'en': 'Character limit exceeded',
      'id': '',
      'ms': '',
    },
    'n8zbiz1e': {
      'en': '0/1000 Characters',
      'id': '',
      'ms': '',
    },
    'jmbvwi2n': {
      'en': 'Voice',
      'id': '',
      'ms': '',
    },
    'gcuwg0s2': {
      'en': 'Lulu',
      'id': '',
      'ms': '',
    },
    'bfwhz989': {
      'en': 'Lulu',
      'id': '',
      'ms': '',
    },
    'bivc3t6z': {
      'en': 'Search...',
      'id': '',
      'ms': '',
    },
    'fhti7f6o': {
      'en': 'Lulu',
      'id': '',
      'ms': '',
    },
    'tow3inrg': {
      'en': 'Tuttut',
      'id': '',
      'ms': '',
    },
    'su5dzezx': {
      'en': 'Pipi',
      'id': '',
      'ms': '',
    },
    '7cbs2yjj': {
      'en': 'Add tags',
      'id': '',
      'ms': '',
    },
    'd9530dma': {
      'en': 'General',
      'id': '',
      'ms': '',
    },
    'j52dkuvy': {
      'en': 'Appointment',
      'id': '',
      'ms': '',
    },
    'a1sjfz8k': {
      'en': 'Customer Support',
      'id': '',
      'ms': '',
    },
    'kw652ct4': {
      'en': 'FAQ',
      'id': '',
      'ms': '',
    },
    'zuz10f7r': {
      'en': 'Order',
      'id': '',
      'ms': '',
    },
    '7yeuh5ip': {
      'en': 'Set as the default project',
      'id': '',
      'ms': '',
    },
    'wx5j30ta': {
      'en': 'Save',
      'id': 'Kirim Setel Ulang Tautan',
      'ms': 'Hantar Pautan Tetapan Semula',
    },
    '6w4tap2f': {
      'en': 'Add Projects',
      'id': 'Tambahkan Anggota',
      'ms': 'Tambah Ahli',
    },
    '4zzgc25n': {
      'en': '__',
      'id': '__',
      'ms': '__',
    },
  },
  // Subscription
  {
    'smbwk1uj': {
      'en': 'Essential',
      'id': '',
      'ms': '',
    },
    'k2wna1om': {
      'en': '\$25,250',
      'id': '',
      'ms': '',
    },
    'dyksxjha': {
      'en': 'Bank Address\n',
      'id': '',
      'ms': '',
    },
    '1gdk6rtk': {
      'en': '459 West Hollywood Blvd. Los Angeles California, 98201',
      'id': '',
      'ms': '',
    },
    'c9e1g4ki': {
      'en': 'Bank Name: ',
      'id': '',
      'ms': '',
    },
    'zsrhvd7g': {
      'en': 'Bankisimo.io',
      'id': '',
      'ms': '',
    },
    't848gr95': {
      'en': 'Account #: ',
      'id': '',
      'ms': '',
    },
    '0yw8rhln': {
      'en': '123456789',
      'id': '',
      'ms': '',
    },
    'ovly2vom': {
      'en': 'IBAN: ',
      'id': '',
      'ms': '',
    },
    '1xjp4oyn': {
      'en': '1234567890123',
      'id': '',
      'ms': '',
    },
    'pfryw46r': {
      'en': 'Recipient',
      'id': '',
      'ms': '',
    },
    '60rxuzll': {
      'en': 'Abigail Rogers',
      'id': '',
      'ms': '',
    },
    'ii3kgaol': {
      'en': 'abigail.rogers@domain.com',
      'id': '',
      'ms': '',
    },
    'tqlkfuuf': {
      'en': 'Subscription',
      'id': '',
      'ms': '',
    },
    'dnioosne': {
      'en': 'Upgrade now',
      'id': '',
      'ms': '',
    },
    '4ztv2v6d': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
  },
  // receipt
  {
    'nnx3yrop': {
      'en': 'Transaction Success!',
      'id': '',
      'ms': '',
    },
    'ih9ywfek': {
      'en': '\$25,250',
      'id': '',
      'ms': '',
    },
    'wps5b44v': {
      'en': 'Bank Address\n',
      'id': '',
      'ms': '',
    },
    '3j8s57re': {
      'en': '459 West Hollywood Blvd. Los Angeles California, 98201',
      'id': '',
      'ms': '',
    },
    'urrwpkov': {
      'en': 'Bank Name: ',
      'id': '',
      'ms': '',
    },
    's6ikp5ef': {
      'en': 'Bankisimo.io',
      'id': '',
      'ms': '',
    },
    'diarpw5e': {
      'en': 'Account #: ',
      'id': '',
      'ms': '',
    },
    'i2kc6lge': {
      'en': '123456789',
      'id': '',
      'ms': '',
    },
    'p4jpp3vg': {
      'en': 'IBAN: ',
      'id': '',
      'ms': '',
    },
    '7hleo5fz': {
      'en': '1234567890123',
      'id': '',
      'ms': '',
    },
    '0rhx7yt3': {
      'en': 'Recipient',
      'id': '',
      'ms': '',
    },
    'tpkt0okh': {
      'en': 'Abigail Rogers',
      'id': '',
      'ms': '',
    },
    '695shai8': {
      'en': 'abigail.rogers@domain.com',
      'id': '',
      'ms': '',
    },
    '0er0cukb': {
      'en': 'Confirm',
      'id': '',
      'ms': '',
    },
    'cwajdjbn': {
      'en': 'Receipt Details',
      'id': '',
      'ms': '',
    },
    'ojuc97oc': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
  },
  // ProfilePage_add
  {
    'v71j09wi': {
      'en': 'Minutes',
      'id': '',
      'ms': '',
    },
    'gf2b426b': {
      'en': '100',
      'id': '',
      'ms': '',
    },
    's8d09exn': {
      'en': '100 minutes are the minimum balance',
      'id': '',
      'ms': '',
    },
    'e678hrik': {
      'en': 'Flat Rate',
      'id': '',
      'ms': '',
    },
    '4j8aaiaw': {
      'en': '\$0.016/min',
      'id': '',
      'ms': '',
    },
    'oo7ce9w8': {
      'en': 'Price Breakdown',
      'id': '',
      'ms': '',
    },
    'iq71zq35': {
      'en': 'Base Price',
      'id': '',
      'ms': '',
    },
    'as1w16vh': {
      'en': 'Discount',
      'id': '',
      'ms': '',
    },
    'zm9uhk26': {
      'en': 'Total',
      'id': '',
      'ms': '',
    },
    'cccotn3b': {
      'en': '\$230.20',
      'id': '',
      'ms': '',
    },
    'k2t1z8xe': {
      'en': 'Add',
      'id': '',
      'ms': '',
    },
    'e8bd79wi': {
      'en': 'Add Balance',
      'id': '',
      'ms': '',
    },
    'p1h18u0c': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
  },
  // Settings
  {
    'yn3uloow': {
      'en': 'Settings Page',
      'id': '',
      'ms': '',
    },
    'jxtno8ch': {
      'en':
          'Choose what notifcations you want to recieve below and we will update the settings.',
      'id': '',
      'ms': '',
    },
    'quj3xo0g': {
      'en': 'Push Notifications',
      'id': '',
      'ms': '',
    },
    'lubfvmxl': {
      'en':
          'Receive Push notifications from our application on a semi regular basis.',
      'id': '',
      'ms': '',
    },
    '8tsq8cy4': {
      'en': 'Email Notifications',
      'id': '',
      'ms': '',
    },
    'kt8vw1sh': {
      'en':
          'Receive email notifications from our marketing team about new features.',
      'id': '',
      'ms': '',
    },
    '9cufy842': {
      'en': 'Location Services',
      'id': '',
      'ms': '',
    },
    'eiqmulyt': {
      'en':
          'Allow us to track your location, this helps keep track of spending and keeps you safe.',
      'id': '',
      'ms': '',
    },
    'ncbu0ihi': {
      'en': 'Change Changes',
      'id': '',
      'ms': '',
    },
    'col4maqc': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
  },
  // ProfilePageLanguage
  {
    'syin35l0': {
      'en': 'Deutsch',
      'id': '',
      'ms': '',
    },
    'evnkdqcq': {
      'en': 'English',
      'id': '',
      'ms': '',
    },
    'ifhhb49o': {
      'en': 'Español',
      'id': '',
      'ms': '',
    },
    '2p366v7y': {
      'en': 'Français',
      'id': '',
      'ms': '',
    },
    '56xt5abq': {
      'en': 'Nederlands',
      'id': '',
      'ms': '',
    },
    '223mw579': {
      'en': '日本語',
      'id': '',
      'ms': '',
    },
    'ezceeszz': {
      'en': 'Language',
      'id': '',
      'ms': '',
    },
    'zmwfdxdn': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
  },
  // DashboardCalllog
  {
    '2jpr3rph': {
      'en': 'Search for numbers...',
      'id': '',
      'ms': '',
    },
    '7e81rerq': {
      'en': 'Today 11. 5. Wednesday',
      'id': '',
      'ms': '',
    },
    'zmtxsnxw': {
      'en': '604-123-456',
      'id': '',
      'ms': '',
    },
    '5ztb2eh2': {
      'en': '10:02',
      'id': '',
      'ms': '',
    },
    'm13y3ast': {
      'en': 'Booked an appointment at 7:00pm Monday',
      'id': '',
      'ms': '',
    },
    '5ocyc55y': {
      'en': '604-123-456',
      'id': '',
      'ms': '',
    },
    '76q2aavn': {
      'en': '09:30',
      'id': '',
      'ms': '',
    },
    'j3rz0ufb': {
      'en': 'Demanded urgent reply. Call ASAP',
      'id': '',
      'ms': '',
    },
    'z2afr7iz': {
      'en': '604-123-456',
      'id': '',
      'ms': '',
    },
    '7r1u5s0t': {
      'en': '07:17',
      'id': '',
      'ms': '',
    },
    '8ebqg4c4': {
      'en': 'Booked an appointment at 7:00pm Monday',
      'id': '',
      'ms': '',
    },
    'fma6vbyu': {
      'en': '11. 1  Saturday',
      'id': '',
      'ms': '',
    },
    '53q5gnds': {
      'en': '604-123-456',
      'id': '',
      'ms': '',
    },
    '9sewtpnd': {
      'en': '21:07',
      'id': '',
      'ms': '',
    },
    'uxep2qnc': {
      'en': 'Left the conversation before booking appointment',
      'id': '',
      'ms': '',
    },
    '4yemg68l': {
      'en': '604-123-456',
      'id': '',
      'ms': '',
    },
    'f6dj6ku6': {
      'en': '15:23',
      'id': '',
      'ms': '',
    },
    '0tlbma4y': {
      'en': 'Ordered two pieces of pizza pie',
      'id': '',
      'ms': '',
    },
    'aj7aeztb': {
      'en': '604-123-456',
      'id': '',
      'ms': '',
    },
    '0ld7jlxd': {
      'en': '12:30',
      'id': '',
      'ms': '',
    },
    '2pjf1cuk': {
      'en': 'Booked an appointment at 11:00pm Monday',
      'id': '',
      'ms': '',
    },
    '6yu445eu': {
      'en': 'Call Log',
      'id': '',
      'ms': '',
    },
    'bvl6nzzq': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
  },
  // DashboardContact_view
  {
    'dq9umgv7': {
      'en': 'Contact',
      'id': '',
      'ms': '',
    },
    '75wsrhoh': {
      'en': 'Sarah Johnson',
      'id': '',
      'ms': '',
    },
    '3fgkzk1e': {
      'en': 'Mobile',
      'id': '',
      'ms': '',
    },
    '3edkfcnz': {
      'en': '+1 (555) 123-4567',
      'id': '',
      'ms': '',
    },
    '1rztr3eo': {
      'en': 'Work',
      'id': '',
      'ms': '',
    },
    'iqvkqgu7': {
      'en': '+1 (555) 987-6543',
      'id': '',
      'ms': '',
    },
    '0kowhrub': {
      'en': 'Email',
      'id': '',
      'ms': '',
    },
    'xfvkbu7l': {
      'en': 'sarah.johnson@company.com',
      'id': '',
      'ms': '',
    },
    '27hxgeus': {
      'en': 'Address',
      'id': '',
      'ms': '',
    },
    'fuhuwtjz': {
      'en': '123 Oak Street, San Francisco, CA',
      'id': '',
      'ms': '',
    },
    '12wusn3y': {
      'en': 'Birthday',
      'id': '',
      'ms': '',
    },
    'b6kkpnvh': {
      'en': 'March 15, 1990',
      'id': '',
      'ms': '',
    },
    '5vr066a8': {
      'en': 'Special day',
      'id': '',
      'ms': '',
    },
    'n9n7mevk': {
      'en': 'March 15, 1990',
      'id': '',
      'ms': '',
    },
    'qx4z7vjm': {
      'en': 'Notes',
      'id': '',
      'ms': '',
    },
    'wi38p3xb': {
      'en':
          'Met at the marketing conference in Austin.\n Great insights on digital strategy.',
      'id': '',
      'ms': '',
    },
    '4uulhxqk': {
      'en': 'Edit',
      'id': '',
      'ms': '',
    },
    'zhibufui': {
      'en': 'Share Contact',
      'id': '',
      'ms': '',
    },
  },
  // DashboardContact_Addcontact
  {
    'ndh7v95l': {
      'en': 'Name',
      'id': '',
      'ms': '',
    },
    'nll854s0': {
      'en': 'Nickname',
      'id': '',
      'ms': '',
    },
    '35dpfmlb': {
      'en': 'Company',
      'id': '',
      'ms': '',
    },
    'trxsxxks': {
      'en': 'Title',
      'id': '',
      'ms': '',
    },
    'ni02ioxv': {
      'en': 'Phone',
      'id': '',
      'ms': '',
    },
    'n97621vt': {
      'en': 'Mobile',
      'id': '',
      'ms': '',
    },
    'k9e7153n': {
      'en': 'Mobile',
      'id': '',
      'ms': '',
    },
    'zsva41lv': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
    '3pb79cfj': {
      'en': 'Work',
      'id': '',
      'ms': '',
    },
    'sm2yx60q': {
      'en': 'Email',
      'id': '',
      'ms': '',
    },
    'okeso4q3': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
    'ffy5evoj': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
    'utpxp3x9': {
      'en': 'Work',
      'id': '',
      'ms': '',
    },
    'csb576xe': {
      'en': 'Other',
      'id': '',
      'ms': '',
    },
    'n6uxddg2': {
      'en': 'Address',
      'id': '',
      'ms': '',
    },
    'wdidm1rs': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
    'dky4bduj': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
    'twnaw7vq': {
      'en': 'Work',
      'id': '',
      'ms': '',
    },
    'mvjy0t2j': {
      'en': 'Other',
      'id': '',
      'ms': '',
    },
    'fgiea6vk': {
      'en': 'Significant Date',
      'id': '',
      'ms': '',
    },
    'egvzawmb': {
      'en': 'Birthday',
      'id': '',
      'ms': '',
    },
    '3yzsvbl4': {
      'en': 'Birthday',
      'id': '',
      'ms': '',
    },
    'me1y0yxl': {
      'en': 'Anniversary',
      'id': '',
      'ms': '',
    },
    '8q692y0f': {
      'en': 'Other',
      'id': '',
      'ms': '',
    },
    'pqqrvlv9': {
      'en': 'Notes',
      'id': '',
      'ms': '',
    },
    'x3cxgtt4': {
      'en': 'Save',
      'id': '',
      'ms': '',
    },
    '4m39jizt': {
      'en': 'Cancel',
      'id': '',
      'ms': '',
    },
    'f91pvv3d': {
      'en': 'New contact',
      'id': '',
      'ms': '',
    },
  },
  // DashboardCalllog_Detail
  {
    'lkdegdr0': {
      'en': '604-123-456',
      'id': '',
      'ms': '',
    },
    'hpbhka2t': {
      'en': '10:21',
      'id': '',
      'ms': '',
    },
    'tgperkma': {
      'en': '7 min 23 sec',
      'id': '',
      'ms': '',
    },
    'vbw8ebcn': {
      'en': 'Mood',
      'id': '',
      'ms': '',
    },
    '0dg6r9i4': {
      'en': 'Overview',
      'id': '',
      'ms': '',
    },
    'kw2dghpx': {
      'en': 'Call Summary',
      'id': '',
      'ms': '',
    },
    'efyxkmtd': {
      'en':
          'The crypto XRP climbs to 2nd place in the Kaiko ranking, alongside Ethereum. Liquidity, institutional adoption, and market depth make the difference.',
      'id': '',
      'ms': '',
    },
    '0hieli17': {
      'en': 'Resolution',
      'id': '',
      'ms': '',
    },
    'r7d9yf18': {
      'en':
          'The crypto XRP climbs to 2nd place in the Kaiko ranking, alongside Ethereum. Liquidity, institutional adoption, and market depth make the difference.',
      'id': '',
      'ms': '',
    },
    'mz0mq8pf': {
      'en': 'Issue Raised',
      'id': '',
      'ms': '',
    },
    '3kcc8du8': {
      'en':
          'The crypto XRP climbs to 2nd place in the Kaiko ranking, alongside Ethereum. Liquidity, institutional adoption, and market depth make the difference.',
      'id': '',
      'ms': '',
    },
    'udi3mggi': {
      'en': 'Key Topics',
      'id': '',
      'ms': '',
    },
    '0nrlehlj': {
      'en': 'Hello World',
      'id': '',
      'ms': '',
    },
    'a3hxmen5': {
      'en': 'Hello World',
      'id': '',
      'ms': '',
    },
    '5r4c82hw': {
      'en': 'Hello World',
      'id': '',
      'ms': '',
    },
    '8xuhorah': {
      'en': 'Full Text',
      'id': '',
      'ms': '',
    },
    'puncfvkx': {
      'en': 'Small message',
      'id': '',
      'ms': '',
    },
    'jmoe15rz': {
      'en':
          'This is a long message. The container  is limited to 70% max width and the text will start floating',
      'id': '',
      'ms': '',
    },
    '2i3j2cor': {
      'en': 'Recording',
      'id': '',
      'ms': '',
    },
    '21bh492z': {
      'en':
          'This recording will be automatically deleted after 14 days. Please save it if needed.',
      'id': '',
      'ms': '',
    },
    'hlvj9ssg': {
      'en': 'Call Log Detail',
      'id': '',
      'ms': '',
    },
    'uz40hmfa': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
  },
  // DashboardStats
  {
    'sar88xkb': {
      'en': 'Day',
      'id': '',
      'ms': '',
    },
    'js60vsa4': {
      'en': 'Total Call Volume',
      'id': 'pelanggan baru',
      'ms': 'pelanggan baru',
    },
    'rmb86a1h': {
      'en': '24',
      'id': '24',
      'ms': '24',
    },
    '3w0u3j8x': {
      'en': 'Average Talk Time',
      'id': 'pelanggan baru',
      'ms': 'pelanggan baru',
    },
    '676lb4de': {
      'en': '08:11',
      'id': '24',
      'ms': '24',
    },
    'k1qihpnq': {
      'en': 'Average Turns',
      'id': '',
      'ms': '',
    },
    'q42akw11': {
      'en': 'You’re using 80% of available requests.',
      'id': '',
      'ms': '',
    },
    'w5mp6vrt': {
      'en': '7',
      'id': '24',
      'ms': '24',
    },
    'crx20qqj': {
      'en': 'You’ve almost reached your limit',
      'id': '',
      'ms': '',
    },
    'vanbcfyu': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'id': '',
      'ms': '',
    },
    '2xlvr9kx': {
      'en': 'Hourly Call Volume',
      'id': '',
      'ms': '',
    },
    'sl856tm7': {
      'en': 'You’re using 80% of available requests.',
      'id': '',
      'ms': '',
    },
    'hi846m3t': {
      'en': 'Time',
      'id': '',
      'ms': '',
    },
    'x7wwzih9': {
      'en': 'Calls',
      'id': '',
      'ms': '',
    },
    'oibbmo4n': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'id': '',
      'ms': '',
    },
    'nucku3sx': {
      'en': 'Task Completion Rate',
      'id': '',
      'ms': '',
    },
    '32jlj5hk': {
      'en': 'You’re using 80% of available requests.',
      'id': '',
      'ms': '',
    },
    '5w9aoad6': {
      'en': '82%',
      'id': '',
      'ms': '',
    },
    'vykjut8u': {
      'en': 'You’ve almost reached your limit',
      'id': '',
      'ms': '',
    },
    'rfddz7qr': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'id': '',
      'ms': '',
    },
    'uhcy7yv8': {
      'en': 'Top Keywords',
      'id': '',
      'ms': '',
    },
    'ty2txd11': {
      'en': 'You’re using 80% of available requests.',
      'id': '',
      'ms': '',
    },
    'uhpd1qny': {
      'en': 'Hello World',
      'id': '',
      'ms': '',
    },
    '7efw4xgb': {
      'en': 'Hello World',
      'id': '',
      'ms': '',
    },
    'yawqlbau': {
      'en': 'Hello World',
      'id': '',
      'ms': '',
    },
    '51iqmms2': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'id': '',
      'ms': '',
    },
    'pizqqsi9': {
      'en': 'Sentiment Analysis',
      'id': '',
      'ms': '',
    },
    '0egsaet0': {
      'en': 'You’re using 80% of available requests.',
      'id': '',
      'ms': '',
    },
    'thqoj79l': {
      'en': 'Mood',
      'id': '',
      'ms': '',
    },
    '4jy0xonc': {
      'en': 'You’ve almost reached your limit',
      'id': '',
      'ms': '',
    },
    'y9s43biu': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'id': '',
      'ms': '',
    },
    'hwa0l683': {
      'en': 'Week',
      'id': '',
      'ms': '',
    },
    '5dpebv00': {
      'en': 'Total Call Volume',
      'id': 'pelanggan baru',
      'ms': 'pelanggan baru',
    },
    'o3pla907': {
      'en': '24',
      'id': '24',
      'ms': '24',
    },
    'imtp1dba': {
      'en': 'Average Talk Time',
      'id': 'pelanggan baru',
      'ms': 'pelanggan baru',
    },
    'mut6o4vj': {
      'en': '08:11',
      'id': '24',
      'ms': '24',
    },
    'uwley31i': {
      'en': 'Average Turns',
      'id': '',
      'ms': '',
    },
    'oq5onqbi': {
      'en': 'You’re using 80% of available requests.',
      'id': '',
      'ms': '',
    },
    '052yrto1': {
      'en': '7',
      'id': '24',
      'ms': '24',
    },
    '3nl7bu7n': {
      'en': 'You’ve almost reached your limit',
      'id': '',
      'ms': '',
    },
    'nx6tc4e6': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'id': '',
      'ms': '',
    },
    'hqbw0mf6': {
      'en': 'Hourly Call Volume',
      'id': '',
      'ms': '',
    },
    'yhg2tuf8': {
      'en': 'You’re using 80% of available requests.',
      'id': '',
      'ms': '',
    },
    'li3lbyjb': {
      'en': 'Time',
      'id': '',
      'ms': '',
    },
    'zq36lbnj': {
      'en': 'Calls',
      'id': '',
      'ms': '',
    },
    '67cx8k3w': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'id': '',
      'ms': '',
    },
    '2wvzysde': {
      'en': 'Task Completion Rate',
      'id': '',
      'ms': '',
    },
    'd55jjt5p': {
      'en': 'You’re using 80% of available requests.',
      'id': '',
      'ms': '',
    },
    '4bowifbo': {
      'en': '82%',
      'id': '',
      'ms': '',
    },
    '4newcbxw': {
      'en': 'You’ve almost reached your limit',
      'id': '',
      'ms': '',
    },
    'tcjm3clo': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'id': '',
      'ms': '',
    },
    '6fd9ih8s': {
      'en': 'Top Keywords',
      'id': '',
      'ms': '',
    },
    'f8gljvsy': {
      'en': 'You’re using 80% of available requests.',
      'id': '',
      'ms': '',
    },
    'jx8d7nch': {
      'en': 'Hello World',
      'id': '',
      'ms': '',
    },
    'eahpborn': {
      'en': 'Hello World',
      'id': '',
      'ms': '',
    },
    'jda1q0hu': {
      'en': 'Hello World',
      'id': '',
      'ms': '',
    },
    'jh30wzjr': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'id': '',
      'ms': '',
    },
    '9mi0fw3p': {
      'en': 'Sentiment Analysis',
      'id': '',
      'ms': '',
    },
    'oaz7h65g': {
      'en': 'You’re using 80% of available requests.',
      'id': '',
      'ms': '',
    },
    'xx68zsvl': {
      'en': 'Mood',
      'id': '',
      'ms': '',
    },
    'o7a6x7at': {
      'en': 'You’ve almost reached your limit',
      'id': '',
      'ms': '',
    },
    'okji54kz': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'id': '',
      'ms': '',
    },
    'jsdkl4km': {
      'en': 'Month',
      'id': '',
      'ms': '',
    },
    'qdaax94e': {
      'en': 'Total Call Volume',
      'id': 'pelanggan baru',
      'ms': 'pelanggan baru',
    },
    'ymebqknu': {
      'en': '24',
      'id': '24',
      'ms': '24',
    },
    '812cmc22': {
      'en': 'Average Talk Time',
      'id': 'pelanggan baru',
      'ms': 'pelanggan baru',
    },
    'wd4vphe7': {
      'en': '08:11',
      'id': '24',
      'ms': '24',
    },
    '5ns1tfjs': {
      'en': 'Average Turns',
      'id': '',
      'ms': '',
    },
    'r9tulpvq': {
      'en': 'You’re using 80% of available requests.',
      'id': '',
      'ms': '',
    },
    'hzxcjzwa': {
      'en': '7',
      'id': '24',
      'ms': '24',
    },
    '0rvru2jg': {
      'en': 'You’ve almost reached your limit',
      'id': '',
      'ms': '',
    },
    'cpg2jj67': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'id': '',
      'ms': '',
    },
    'r5zwb1xs': {
      'en': 'Hourly Call Volume',
      'id': '',
      'ms': '',
    },
    'veyrohd4': {
      'en': 'You’re using 80% of available requests.',
      'id': '',
      'ms': '',
    },
    'k8i6pu59': {
      'en': 'Time',
      'id': '',
      'ms': '',
    },
    'q862hp3m': {
      'en': 'Calls',
      'id': '',
      'ms': '',
    },
    'pn39ze5r': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'id': '',
      'ms': '',
    },
    'urtjd005': {
      'en': 'Task Completion Rate',
      'id': '',
      'ms': '',
    },
    'bwrlih1e': {
      'en': 'You’re using 80% of available requests.',
      'id': '',
      'ms': '',
    },
    'w9ouwnxq': {
      'en': '82%',
      'id': '',
      'ms': '',
    },
    'dwruh1q6': {
      'en': 'You’ve almost reached your limit',
      'id': '',
      'ms': '',
    },
    'tfegq4q6': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'id': '',
      'ms': '',
    },
    '1fbarhs2': {
      'en': 'Top Keywords',
      'id': '',
      'ms': '',
    },
    '06qbmr11': {
      'en': 'You’re using 80% of available requests.',
      'id': '',
      'ms': '',
    },
    '43hpv4fk': {
      'en': 'Hello World',
      'id': '',
      'ms': '',
    },
    'pitfyqz9': {
      'en': 'Hello World',
      'id': '',
      'ms': '',
    },
    'd50get7c': {
      'en': 'Hello World',
      'id': '',
      'ms': '',
    },
    'kgvqnco1': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'id': '',
      'ms': '',
    },
    'c8t6cxl9': {
      'en': 'Sentiment Analysis',
      'id': '',
      'ms': '',
    },
    'njgcj83o': {
      'en': 'You’re using 80% of available requests.',
      'id': '',
      'ms': '',
    },
    '83okausf': {
      'en': 'Mood',
      'id': '',
      'ms': '',
    },
    'n9m5mrhp': {
      'en': 'You’ve almost reached your limit',
      'id': '',
      'ms': '',
    },
    'z2rxyfon': {
      'en':
          'You have used 80% of your available requests. Upgrade plan to make more network requests.',
      'id': '',
      'ms': '',
    },
    'rmdy9gpj': {
      'en': 'Statistics',
      'id': '',
      'ms': '',
    },
  },
  // DashboardContact
  {
    'ztbu6foa': {
      'en': 'Contacts',
      'id': '',
      'ms': '',
    },
    'o4i4lo3k': {
      'en': 'TextField',
      'id': '',
      'ms': '',
    },
    'sgva6vx5': {
      'en': 'Search for numbers...',
      'id': '',
      'ms': '',
    },
    'jtvs0wmt': {
      'en': '#',
      'id': '',
      'ms': '',
    },
    '31dbbd02': {
      'en': '+1 (555) 123-4567',
      'id': '',
      'ms': '',
    },
    'gpp09v0i': {
      'en': 'A',
      'id': '',
      'ms': '',
    },
    '8jvfeojw': {
      'en': 'Alice Johnson',
      'id': '',
      'ms': '',
    },
    'wphml2h6': {
      'en': 'Andrew Miller',
      'id': '',
      'ms': '',
    },
    'm28mmazr': {
      'en': 'Anna Davis',
      'id': '',
      'ms': '',
    },
    'o81stx5d': {
      'en': 'C',
      'id': '',
      'ms': '',
    },
    '1o7yy9wn': {
      'en': 'Chris Wilson',
      'id': '',
      'ms': '',
    },
    'sxqyj420': {
      'en': 'Christina Brown',
      'id': '',
      'ms': '',
    },
    'ocsmcf1s': {
      'en': 'Connor Martinez',
      'id': '',
      'ms': '',
    },
    'iyq1ctlu': {
      'en': 'Cynthia Garcia',
      'id': '',
      'ms': '',
    },
  },
  // DashboardContact_Editcontact
  {
    'quvu30em': {
      'en': 'Name',
      'id': '',
      'ms': '',
    },
    'qpr3po73': {
      'en': 'Nickname',
      'id': '',
      'ms': '',
    },
    '8balnxf7': {
      'en': 'Company',
      'id': '',
      'ms': '',
    },
    'ra18mvnk': {
      'en': 'Title',
      'id': '',
      'ms': '',
    },
    'iwbz4bw8': {
      'en': 'Phone',
      'id': '',
      'ms': '',
    },
    '851uy5sl': {
      'en': 'Mobile',
      'id': '',
      'ms': '',
    },
    'df7b1tvg': {
      'en': 'Mobile',
      'id': '',
      'ms': '',
    },
    'sd3g266o': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
    'h2q9w03n': {
      'en': 'Work',
      'id': '',
      'ms': '',
    },
    'dv7tgedv': {
      'en': 'Email',
      'id': '',
      'ms': '',
    },
    'djwuvv86': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
    'pclfm7ja': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
    'npli404e': {
      'en': 'Work',
      'id': '',
      'ms': '',
    },
    'v933rbc9': {
      'en': 'Other',
      'id': '',
      'ms': '',
    },
    'adk7y6j7': {
      'en': 'Address',
      'id': '',
      'ms': '',
    },
    'k01vqggx': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
    'brnb4nj1': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
    'br7ybtji': {
      'en': 'Work',
      'id': '',
      'ms': '',
    },
    'ajlchw3c': {
      'en': 'Other',
      'id': '',
      'ms': '',
    },
    'k0jw5be8': {
      'en': 'Significant Date',
      'id': '',
      'ms': '',
    },
    'svaaxtst': {
      'en': 'Birthday',
      'id': '',
      'ms': '',
    },
    'u1cqewhw': {
      'en': 'Birthday',
      'id': '',
      'ms': '',
    },
    '5x7eocy9': {
      'en': 'Anniversary',
      'id': '',
      'ms': '',
    },
    'zslmsuxi': {
      'en': 'Other',
      'id': '',
      'ms': '',
    },
    'y28ynb0t': {
      'en': 'Notes',
      'id': '',
      'ms': '',
    },
    'flybqsx7': {
      'en': 'Save',
      'id': '',
      'ms': '',
    },
    'cvpr7sya': {
      'en': 'Cancel',
      'id': '',
      'ms': '',
    },
    'rwbrcgqr': {
      'en': 'Edit contact',
      'id': '',
      'ms': '',
    },
  },
  // ProfilePage_purchaseHistory
  {
    '37p85qvg': {
      'en': 'Below are your most recent orders',
      'id': '',
      'ms': '',
    },
    '016xx43r': {
      'en': 'Order #: ',
      'id': '',
      'ms': '',
    },
    'r92ddcek': {
      'en': '429242424',
      'id': '',
      'ms': '',
    },
    'dbhpd366': {
      'en': 'Mon. July 3rd',
      'id': '',
      'ms': '',
    },
    '7qxk183x': {
      'en': 'Google Play Purchase 5 USD',
      'id': '',
      'ms': '',
    },
    'fdo6cz9m': {
      'en': 'Order #: ',
      'id': '',
      'ms': '',
    },
    'kfrqvhi1': {
      'en': '429242424',
      'id': '',
      'ms': '',
    },
    'l0gdju58': {
      'en': 'Mon. July 3rd',
      'id': '',
      'ms': '',
    },
    'lixy3giv': {
      'en': 'Google Play Purchase 5 USD',
      'id': '',
      'ms': '',
    },
    'ujaqoyey': {
      'en': 'Order #: ',
      'id': '',
      'ms': '',
    },
    'uodt36cf': {
      'en': '429242424',
      'id': '',
      'ms': '',
    },
    '3cyzywxb': {
      'en': 'Mon. July 3rd',
      'id': '',
      'ms': '',
    },
    'd8j2ciqp': {
      'en': 'Google Play Purchase 5 USD',
      'id': '',
      'ms': '',
    },
    'pug7jvfv': {
      'en': 'Order #: ',
      'id': '',
      'ms': '',
    },
    'fmdmic66': {
      'en': '429242424',
      'id': '',
      'ms': '',
    },
    'evv9ybp5': {
      'en': 'Mon. July 3rd',
      'id': '',
      'ms': '',
    },
    '8igtcveq': {
      'en': 'Google Play Purchase 5 USD',
      'id': '',
      'ms': '',
    },
    '4nz50sh7': {
      'en': 'Order History',
      'id': '',
      'ms': '',
    },
    'w5p06u7i': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
  },
  // ProfilePage_purchaseHistory_billDetail
  {
    'nhba6l6x': {
      'en': 'Order History',
      'id': '',
      'ms': '',
    },
    '3qscqwki': {
      'en': 'Billed to:',
      'id': '',
      'ms': '',
    },
    'so0txzqw': {
      'en': 'Sena Lala',
      'id': '',
      'ms': '',
    },
    '7i356h2o': {
      'en':
          'FlutterFlow Inc. 456 Tech Avenue San Francisco, CA 94105 United States',
      'id': '',
      'ms': '',
    },
    'euq8r0f2': {
      'en': 'Issued by:',
      'id': '',
      'ms': '',
    },
    'z71y2juv': {
      'en': 'Telecome',
      'id': '',
      'ms': '',
    },
    'tpa2kana': {
      'en':
          'FlutterFlow Inc. 456 Tech Avenue San Francisco, CA 94105 United States',
      'id': '',
      'ms': '',
    },
    '9wa90qds': {
      'en': 'Successful',
      'id': '',
      'ms': '',
    },
    'esoqf29k': {
      'en': 'Order No.:',
      'id': '',
      'ms': '',
    },
    'taed1r52': {
      'en': '#FF2024001',
      'id': '',
      'ms': '',
    },
    'i0spu1ku': {
      'en': 'Paid with:',
      'id': '',
      'ms': '',
    },
    '3tq7rakj': {
      'en': 'Visa ****1234',
      'id': '',
      'ms': '',
    },
    'sslf1j59': {
      'en': 'Date:',
      'id': '',
      'ms': '',
    },
    '86ypl8pj': {
      'en': 'Jan 15, 2024',
      'id': '',
      'ms': '',
    },
    'iyi8wa8t': {
      'en': 'Details:',
      'id': '',
      'ms': '',
    },
    'bfq3wrl0': {
      'en': 'FlutterFlow Pro Plan',
      'id': '',
      'ms': '',
    },
    'vdnudtkm': {
      'en': '\$30.00',
      'id': '',
      'ms': '',
    },
    'iayuwsty': {
      'en': 'Monthly subscription - Premium features included',
      'id': '',
      'ms': '',
    },
    'eawgwhah': {
      'en': 'Total',
      'id': '',
      'ms': '',
    },
    'cugx0h1z': {
      'en': '\$30.00',
      'id': '',
      'ms': '',
    },
  },
  // receiptFailed
  {
    '1sz9o71b': {
      'en': 'Transaction Failed',
      'id': '',
      'ms': '',
    },
    'e2r0amab': {
      'en':
          'We\'re sorry, but your payment could not be processed. Please check your payment details and try again.',
      'id': '',
      'ms': '',
    },
    'flmubn3v': {
      'en': 'Try Again',
      'id': '',
      'ms': '',
    },
    '593zi95e': {
      'en': 'Receipt Details',
      'id': '',
      'ms': '',
    },
    'kmyajvak': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
  },
  // Design
  {
    'k6nuxbz4': {
      'en': 'Design',
      'id': 'Dasbor',
      'ms': 'Papan pemuka',
    },
    'h78no44p': {
      'en': 'AI Style',
      'id': '',
      'ms': '',
    },
    'wjmc137m': {
      'en': 'Choose your AI’s tone and personality.',
      'id': '',
      'ms': '',
    },
    '7076ukoe': {
      'en': 'ID#: ',
      'id': '',
      'ms': '',
    },
    'p6zdkx2m': {
      'en': 'ID#: ',
      'id': '',
      'ms': '',
    },
    'frlvlxlj': {
      'en': 'Default',
      'id': '',
      'ms': '',
    },
    'ip12qxz7': {
      'en': 'Information',
      'id': '',
      'ms': '',
    },
    'q0ccjpb2': {
      'en': 'Add the info your AI uses to answer callers for you',
      'id': '',
      'ms': '',
    },
    '5t6fi608': {
      'en': 'Give your AI a short title',
      'id': '',
      'ms': '',
    },
    '0siby6ij': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'ckuhmi63': {
      'en': 'Character limit exceeded',
      'id': '',
      'ms': '',
    },
    'psvfm18a': {
      'en': '0/1000 Characters',
      'id': '',
      'ms': '',
    },
    '81oyv0wa': {
      'en': '+Add',
      'id': '',
      'ms': '',
    },
    '18odghh7': {
      'en': 'Give your AI a short title',
      'id': '',
      'ms': '',
    },
    '6h7m4zq5': {
      'en': '',
      'id': '',
      'ms': '',
    },
    '7o52unhp': {
      'en': 'Character limit exceeded',
      'id': '',
      'ms': '',
    },
    'yclrlswv': {
      'en': '0/1000 Characters',
      'id': '',
      'ms': '',
    },
    'kowv4cxd': {
      'en': '+Add',
      'id': '',
      'ms': '',
    },
    'ul2ihd5j': {
      'en': '-Delete',
      'id': '',
      'ms': '',
    },
    'ybdq5tel': {
      'en': 'Save',
      'id': '',
      'ms': '',
    },
    'e74ll7bq': {
      'en': '__',
      'id': '__',
      'ms': '__',
    },
  },
  // ProfilePage_yourNumbers
  {
    'zwo5anh3': {
      'en': 'Below are your active numbers',
      'id': '',
      'ms': '',
    },
    'a5loej34': {
      'en': 'Phone #: ',
      'id': '',
      'ms': '',
    },
    '8jmu67aj': {
      'en': '604-299-1234',
      'id': '',
      'ms': '',
    },
    'ralyjnsh': {
      'en': 'Your number is active until',
      'id': '',
      'ms': '',
    },
    'jcvrsdan': {
      'en': '1:25pm,  January 12, 2026',
      'id': '',
      'ms': '',
    },
    'k0vqxlvl': {
      'en': '2번쨰부터 auto랑',
      'id': '',
      'ms': '',
    },
    'mhtj0emy': {
      'en': 'Remove 표시',
      'id': '',
      'ms': '',
    },
    'l9bw37ld': {
      'en': 'Phone #: ',
      'id': '',
      'ms': '',
    },
    'v4i4bpfc': {
      'en': '604-299-1234',
      'id': '',
      'ms': '',
    },
    '2znlpe9a': {
      'en': 'Your number is active until',
      'id': '',
      'ms': '',
    },
    'p7lavbjq': {
      'en': '2:03am, March 12, 2026',
      'id': '',
      'ms': '',
    },
    'yap8eujb': {
      'en': 'Auto-subscribe',
      'id': '',
      'ms': '',
    },
    'nnhcgsjq': {
      'en': 'Remove',
      'id': '',
      'ms': '',
    },
    'c12g38h0': {
      'en': 'Phone #: ',
      'id': '',
      'ms': '',
    },
    'wwqxqade': {
      'en': '604-299-1234',
      'id': '',
      'ms': '',
    },
    'wwgskskn': {
      'en': 'Your number is active until',
      'id': '',
      'ms': '',
    },
    'saz932lg': {
      'en': '2:03am, March 12, 2026',
      'id': '',
      'ms': '',
    },
    'm8gtxu0y': {
      'en': 'Auto-subscribe',
      'id': '',
      'ms': '',
    },
    'd1pc40l7': {
      'en': 'Remove',
      'id': '',
      'ms': '',
    },
    'dhmj8ums': {
      'en': 'Phone #: ',
      'id': '',
      'ms': '',
    },
    'pcvhlnni': {
      'en': '604-299-1234',
      'id': '',
      'ms': '',
    },
    '34cfzdej': {
      'en': 'Your number is active until',
      'id': '',
      'ms': '',
    },
    '4cs3wyr1': {
      'en': '2:03am, March 12, 2026',
      'id': '',
      'ms': '',
    },
    '9sow2tka': {
      'en': 'Auto-subscribe',
      'id': '',
      'ms': '',
    },
    'z3yw77l1': {
      'en': 'Remove',
      'id': '',
      'ms': '',
    },
    'v1grd4d8': {
      'en': 'Your Numbers',
      'id': '',
      'ms': '',
    },
    'xrtukr7j': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
  },
  // Authentiction
  {
    'u53u360k': {
      'en': 'Phone Verification',
      'id': '',
      'ms': '',
    },
    'ide6v8p2': {
      'en': 'Enter your phone number to continue',
      'id': '',
      'ms': '',
    },
    'qe34h6lv': {
      'en': '🇺🇸 United States',
      'id': '',
      'ms': '',
    },
    '965cwgpl': {
      'en': '🇺🇸 United States',
      'id': '',
      'ms': '',
    },
    '2rd8e2y4': {
      'en': '🇨🇦 Canada',
      'id': '',
      'ms': '',
    },
    'oachqvvb': {
      'en': '🇬🇧 United Kingdom',
      'id': '',
      'ms': '',
    },
    'zy9rk6yz': {
      'en': '🇦🇺 Australia',
      'id': '',
      'ms': '',
    },
    'ecj05xs0': {
      'en': '🇩🇪 Germany',
      'id': '',
      'ms': '',
    },
    'zfgcts65': {
      'en': '🇫🇷 France',
      'id': '',
      'ms': '',
    },
    'cz66x3l3': {
      'en': '+1',
      'id': '',
      'ms': '',
    },
    '98irpuh9': {
      'en': 'Phone number',
      'id': '',
      'ms': '',
    },
    '0e4qo6y8': {
      'en': 'Verify',
      'id': '',
      'ms': '',
    },
  },
  // VerifyCode
  {
    '83193hnr': {
      'en': 'Verify',
      'id': '',
      'ms': '',
    },
    'lssehfdp': {
      'en': 'Please enter the 4-digit code sent to you at +1 (555) 123-4567',
      'id': '',
      'ms': '',
    },
    't25sodm9': {
      'en': 'Invalid code. Please try again',
      'id': '',
      'ms': '',
    },
    'i52p1tvg': {
      'en': 'Resend will be available in 0s',
      'id': '',
      'ms': '',
    },
    '35fxugbj': {
      'en': 'Continue',
      'id': '',
      'ms': '',
    },
    'dqncjq2h': {
      'en': 'Didn\'t receive the code? ',
      'id': '',
      'ms': '',
    },
    'p9vl1zdn': {
      'en': 'Resend',
      'id': '',
      'ms': '',
    },
  },
  // Calendar_detail
  {
    'ri44kx96': {
      'en': 'Lulu is in danger.',
      'id': '',
      'ms': '',
    },
    'skg55yom': {
      'en': 'Due',
      'id': '',
      'ms': '',
    },
    'g6sb1fun': {
      'en': 'In Progress',
      'id': '',
      'ms': '',
    },
    'jy5d1gf7': {
      'en': 'Wed, Nov 26, 2025',
      'id': '',
      'ms': '',
    },
    '5avqo4s6': {
      'en': '13:00',
      'id': '',
      'ms': '',
    },
    '3gc3ibcf': {
      'en': 'Wed, Nov 26, 2025',
      'id': '',
      'ms': '',
    },
    'jd4pza8a': {
      'en': '13:00',
      'id': '',
      'ms': '',
    },
    '1bvvhd3d': {
      'en': 'Details',
      'id': '',
      'ms': '',
    },
    'n1fxpqr8': {
      'en': 'Lulu needs more exercise tomorrow.',
      'id': '',
      'ms': '',
    },
    '4fm6x018': {
      'en': 'Mark as Complete',
      'id': '',
      'ms': '',
    },
    '70y7qqoj': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
  },
  // Calendar_detailPost
  {
    'qttf81r6': {
      'en': 'Add title',
      'id': '',
      'ms': '',
    },
    'z4b82phs': {
      'en': 'Due',
      'id': '',
      'ms': '',
    },
    'qzrl2c55': {
      'en': 'Wed, Nov 26, 2025',
      'id': '',
      'ms': '',
    },
    '7aohklwh': {
      'en': '13:00',
      'id': '',
      'ms': '',
    },
    'pi66zcyq': {
      'en': 'Wed, Nov 26, 2025',
      'id': '',
      'ms': '',
    },
    '4v0rbn2f': {
      'en': '13:00',
      'id': '',
      'ms': '',
    },
    'ldhfndjr': {
      'en': 'Details',
      'id': '',
      'ms': '',
    },
    'm14gggsj': {
      'en': 'Add details',
      'id': '',
      'ms': '',
    },
    '443zlhgu': {
      'en': 'Save',
      'id': '',
      'ms': '',
    },
    '1j9o7q9m': {
      'en': 'Home',
      'id': '',
      'ms': '',
    },
  },
  // Blockednumbers
  {
    'a9vchath': {
      'en': 'Blocked numbers',
      'id': '',
      'ms': '',
    },
    'fgi8ciiw': {
      'en': 'Calls from these numbers will be blocked.',
      'id': '',
      'ms': '',
    },
    '03tf7q1g': {
      'en': '010-1234-5647',
      'id': '',
      'ms': '',
    },
    'oga9a6ol': {
      'en': '604-123-3456',
      'id': '',
      'ms': '',
    },
    'bhijuy32': {
      'en': '306-234-4512',
      'id': '',
      'ms': '',
    },
  },
  // CreateAccount
  {
    'ctfmnqfv': {
      'en': 'Welle',
      'id': '',
      'ms': '',
    },
    'r04biird': {
      'en': 'Create an account',
      'id': 'Selamat Datang kembali!',
      'ms': 'Selamat kembali!',
    },
    's7vjzhnz': {
      'en': 'Use the form below to get started.',
      'id': 'Gunakan formulir di bawah ini untuk mengakses akun Anda.',
      'ms': 'Gunakan borang di bawah untuk mengakses akaun anda.',
    },
    'e9rkhtl4': {
      'en': 'Sign up with Google',
      'id': '',
      'ms': '',
    },
    'hhg3ge63': {
      'en': 'Sign up with Apple',
      'id': '',
      'ms': '',
    },
    'zkhi22bz': {
      'en': 'Use a social platform to continue',
      'id': 'Gunakan platform sosial untuk melanjutkan',
      'ms': 'Gunakan platform sosial untuk meneruskan',
    },
    'c2sf1y6y': {
      'en': 'Already have an account?',
      'id': 'Tidak punya akun?',
      'ms': 'Tiada akaun?',
    },
    'fn3cc1s1': {
      'en': 'Log In',
      'id': 'Buat Akun',
      'ms': 'Buat akaun',
    },
    'skl334v4': {
      'en': 'Home',
      'id': 'Rumah',
      'ms': 'Rumah',
    },
  },
  // modal_Message
  {
    'wa4vkne2': {
      'en': 'Congratulations!',
      'id': 'Selamat!',
      'ms': 'tahniah!',
    },
    '3hf2ocig': {
      'en':
          'Now that a contract has been generated for this customer please contact them with the date you will send the signed agreement.',
      'id':
          'Sekarang kontrak telah dibuat untuk pelanggan ini, silakan hubungi mereka dengan tanggal Anda akan mengirim perjanjian yang ditandatangani.',
      'ms':
          'Memandangkan kontrak telah dijana untuk pelanggan ini, sila hubungi mereka dengan tarikh anda akan menghantar perjanjian yang ditandatangani.',
    },
    'q0jvi1lp': {
      'en': 'Okay',
      'id': 'Oke',
      'ms': 'baik',
    },
    'oo4y13nf': {
      'en': 'Continue',
      'id': 'Melanjutkan',
      'ms': 'teruskan',
    },
  },
  // mobileNav
  {
    'sy0pxvma': {
      'en': 'Home',
      'id': 'Dasbor',
      'ms': 'Papan pemuka',
    },
    'nkz3c58a': {
      'en': 'Design',
      'id': 'Pelanggan',
      'ms': 'Pelanggan',
    },
    '1mkyyjwj': {
      'en': 'Dashboard',
      'id': 'Kontrak',
      'ms': 'Kontrak',
    },
    'eg79coc6': {
      'en': 'Profile',
      'id': 'Profil',
      'ms': 'Profil',
    },
  },
  // webNav
  {
    'xai8ocja': {
      'en': 'Search',
      'id': 'Mencari',
      'ms': 'Cari',
    },
    'yg07zi4c': {
      'en': 'Home',
      'id': 'Dasbor',
      'ms': 'Papan pemuka',
    },
    'lbojdpxg': {
      'en': 'Design',
      'id': 'Pelanggan',
      'ms': 'Pelanggan',
    },
    '9pjba90p': {
      'en': 'Dashboard',
      'id': 'Kontrak',
      'ms': 'Kontrak',
    },
    '01nu9cy0': {
      'en': 'Profile',
      'id': 'Profil',
      'ms': 'Profil',
    },
  },
  // editProfilePhoto
  {
    '6bnefz1c': {
      'en': 'Change Photo',
      'id': '',
      'ms': '',
    },
    'yaxe7q8v': {
      'en':
          'Upload a new photo below in order to change your avatar seen by others.',
      'id': '',
      'ms': '',
    },
    're4x0sz7': {
      'en': 'Upload Image',
      'id': '',
      'ms': '',
    },
    'sr54fsk6': {
      'en': 'Save Changes',
      'id': '',
      'ms': '',
    },
  },
  // avartar2
  {
    'lp52flai': {
      'en': 'Change Photo',
      'id': '',
      'ms': '',
    },
    '7d3ywe1k': {
      'en': 'Avartar',
      'id': '',
      'ms': '',
    },
    'nw9zvgka': {
      'en': 'Upload',
      'id': '',
      'ms': '',
    },
    'kzmklubx': {
      'en': 'Upload your photo',
      'id': '',
      'ms': '',
    },
    'sb6k5usx': {
      'en': 'Select',
      'id': '',
      'ms': '',
    },
  },
  // numberselection
  {
    'l2c184ej': {
      'en': 'Choose your number',
      'id': '',
      'ms': '',
    },
    'qr5msdk3': {
      'en': '604-299-1234',
      'id': '',
      'ms': '',
    },
    '4nlbhlhw': {
      'en': '604-299-1234',
      'id': '',
      'ms': '',
    },
    'b35wpr0k': {
      'en': 'Select',
      'id': '',
      'ms': '',
    },
  },
  // Welcome
  {
    'aixscrc4': {
      'en': 'You\'re all set!',
      'id': '',
      'ms': '',
    },
    'msjp4ovv': {
      'en': 'Your journey starts now.\n Explore all the amazing features.',
      'id': '',
      'ms': '',
    },
    '1ihtqium': {
      'en': 'Get Started',
      'id': '',
      'ms': '',
    },
  },
  // Dropdown8Options
  {
    'ac7tcaqx': {
      'en': 'Options',
      'id': '',
      'ms': '',
    },
    'e2wn6h7l': {
      'en': 'Edit',
      'id': '',
      'ms': '',
    },
    '3t74ef34': {
      'en': 'Assign',
      'id': '',
      'ms': '',
    },
    '89l1rsl6': {
      'en': 'Share',
      'id': '',
      'ms': '',
    },
    'erdtypxi': {
      'en': 'Delete',
      'id': '',
      'ms': '',
    },
  },
  // popup
  {
    'uky77nfb': {
      'en': 'Options',
      'id': '',
      'ms': '',
    },
    'bzibjuld': {
      'en': 'Import from Device',
      'id': '',
      'ms': '',
    },
    'mmrdm3js': {
      'en': 'Blocked numbers',
      'id': '',
      'ms': '',
    },
    'h6kwfz11': {
      'en': 'Delete numbers',
      'id': '',
      'ms': '',
    },
  },
  // blockednumbers_popup
  {
    'huetkbcr': {
      'en': 'Add to blocked numbers',
      'id': '',
      'ms': '',
    },
    'ze9ye0l2': {
      'en': 'Contacts',
      'id': '',
      'ms': '',
    },
    '0tbqkaou': {
      'en': 'New number',
      'id': '',
      'ms': '',
    },
  },
  // Delete_popup
  {
    'xm64s59c': {
      'en': 'Delete',
      'id': 'Selamat!',
      'ms': 'tahniah!',
    },
    '7wsrq2rt': {
      'en': 'Are you sure you want to delete?',
      'id':
          'Sekarang kontrak telah dibuat untuk pelanggan ini, silakan hubungi mereka dengan tanggal Anda akan mengirim perjanjian yang ditandatangani.',
      'ms':
          'Memandangkan kontrak telah dijana untuk pelanggan ini, sila hubungi mereka dengan tarikh anda akan menghantar perjanjian yang ditandatangani.',
    },
    'a9l0zl5n': {
      'en': 'Cancel',
      'id': 'Oke',
      'ms': 'baik',
    },
    'wrxo36l0': {
      'en': 'Confirm',
      'id': 'Melanjutkan',
      'ms': 'teruskan',
    },
  },
  // feedback
  {
    '58fzryni': {
      'en': 'I Want Your Feedback!',
      'id': '',
      'ms': '',
    },
    '6x6w8h9s': {
      'en': 'We\'d love to hear about your recent experience with us.',
      'id': '',
      'ms': '',
    },
    'uxiqwg03': {
      'en': 'Please share your thoughts...',
      'id': '',
      'ms': '',
    },
    '1wuunmde': {
      'en': 'Submit',
      'id': '',
      'ms': '',
    },
  },
  // Miscellaneous
  {
    'qp2pd7cg': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'qhydar07': {
      'en': '',
      'id': '',
      'ms': '',
    },
    '65e2tfs2': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'ddazihx4': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'db03cpjj': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'fdb9078p': {
      'en': '',
      'id': '',
      'ms': '',
    },
    '80ouzj9q': {
      'en': '',
      'id': '',
      'ms': '',
    },
    '6rzhptp9': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'ce8c4ty0': {
      'en': '',
      'id': '',
      'ms': '',
    },
    '4dbladme': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'y9xcgi7f': {
      'en': '',
      'id': '',
      'ms': '',
    },
    's32eai3e': {
      'en': '',
      'id': '',
      'ms': '',
    },
    '2eyvp0ek': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'kcvqa08x': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'dqrzd6sq': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'dpqtohyf': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'v01vf71s': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'gcv6def1': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'um9es99m': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'o4enbz4j': {
      'en': '',
      'id': '',
      'ms': '',
    },
    '8z4tvfh7': {
      'en': '',
      'id': '',
      'ms': '',
    },
    '2ybzla8x': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'd1wdf5i1': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'wgkkyizp': {
      'en': '',
      'id': '',
      'ms': '',
    },
    '2py80kgi': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'p6lsrh2a': {
      'en': '',
      'id': '',
      'ms': '',
    },
    'ne8cclp9': {
      'en': '',
      'id': '',
      'ms': '',
    },
  },
].reduce((a, b) => a..addAll(b));
