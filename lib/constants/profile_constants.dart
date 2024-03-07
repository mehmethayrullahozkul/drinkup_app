import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:drinkup_app/constants/constants.dart';

enum kProfileSectionType {
  display,
  notifications,
  units,
  dailyGoal,
  reminder,
  language,
  timeFormat,
  share,
  help,
  about,
  deleteData;

  @override
  String toString() => this.name.capitalize();
}

class ProfileSectionItem {
  final IconData icon;
  final String title;
  final String subtitle;
  /* final void Function()? onTap; */
  final bool hasSubtitle;
  final kProfileSectionType section;

  const ProfileSectionItem(
      {required this.icon,
      required this.title,
      required this.subtitle,
      /*  required this.onTap, */
      this.hasSubtitle = false,
      required this.section});
}

const Map<Language, List<String>> kProfileSectionTitles = {
  Language.turkish: [
    'Genel',
    'Uygulama',
    'Güvenlik',
    'Destek',
  ],
  Language.english: [
    'General',
    'Drink Up',
    'About App',
    'Support',
  ]
};

const Map<Language, List<List<ProfileSectionItem>>> kProfileSections = {
  Language.english: [
    [
      ProfileSectionItem(
        icon: Icons.invert_colors,
        title: 'Display',
        subtitle: 'Change the theme',
        hasSubtitle: true,
        section: kProfileSectionType.display,
      ),
      ProfileSectionItem(
        icon: Icons.notifications_none_rounded,
        title: 'Notifications & Sounds',
        subtitle: 'Manage notifications and sounds',
        section: kProfileSectionType.notifications,
      ),
      ProfileSectionItem(
        icon: Ionicons.water,
        title: 'Units',
        subtitle: 'Change the units of measurement',
        hasSubtitle: true,
        section: kProfileSectionType.units,
      ),
      ProfileSectionItem(
        icon: Icons.track_changes,
        title: 'Daily Goal',
        subtitle: 'Set your daily goal',
        hasSubtitle: true,
        section: kProfileSectionType.dailyGoal,
      ),
    ],
    [
      ProfileSectionItem(
          icon: Icons.remember_me,
          title: 'Reminder',
          subtitle: 'Set your daily reminder',
          section: kProfileSectionType.reminder),
      ProfileSectionItem(
          icon: Icons.language_rounded,
          title: 'Language',
          subtitle: 'Change the app language',
          hasSubtitle: true,
          section: kProfileSectionType.language),
      ProfileSectionItem(
        icon: Icons.hourglass_empty,
        title: 'Time Format',
        subtitle: 'Change the time format',
        hasSubtitle: true,
        section: kProfileSectionType.timeFormat,
      ),
      ProfileSectionItem(
        icon: Icons.track_changes,
        title: 'Daily Goal',
        subtitle: 'Set your daily goal',
        section: kProfileSectionType.dailyGoal,
      ),
    ],
    [
      ProfileSectionItem(
        icon: Icons.share_outlined,
        title: 'Share DrinkUp',
        subtitle: 'Share the app with friends',
        section: kProfileSectionType.share,
      ),
      ProfileSectionItem(
        icon: Icons.help_outline_outlined,
        title: 'Help & Feedback',
        subtitle: 'Get help and send feedback',
        section: kProfileSectionType.help,
      ),
      ProfileSectionItem(
        icon: Icons.lightbulb_outline_rounded,
        title: 'About DrinkUp',
        subtitle: 'Learn more about the app',
        section: kProfileSectionType.about,
      ),
      ProfileSectionItem(
        icon: Icons.delete_outline_outlined,
        title: 'Delete Data',
        subtitle: 'Delete all your data',
        section: kProfileSectionType.deleteData,
      ),
    ],
  ],
  Language.turkish: [
    [
      ProfileSectionItem(
        icon: Icons.invert_colors,
        title: 'Görünüm',
        subtitle: 'Tema değiştir',
        hasSubtitle: true,
        section: kProfileSectionType.display,
      ),
      ProfileSectionItem(
        icon: Icons.notifications_none_rounded,
        title: 'Bildirimler ve Sesler',
        subtitle: 'Bildirimleri ve sesleri yönet',
        section: kProfileSectionType.notifications,
      ),
      ProfileSectionItem(
        icon: Ionicons.water,
        title: 'Birimler',
        subtitle: 'Ölçü birimlerini değiştir',
        hasSubtitle: true,
        section: kProfileSectionType.units,
      ),
      ProfileSectionItem(
        icon: Icons.track_changes,
        title: 'Günlük Hedef',
        subtitle: 'Günlük hedefini ayarla',
        section: kProfileSectionType.dailyGoal,
      ),
      ProfileSectionItem(
        icon: Icons.remember_me,
        title: 'Hatırlatma',
        subtitle: 'Hatırlatıcıyı ayarla',
        section: kProfileSectionType.dailyGoal,
      ),
      ProfileSectionItem(
          icon: Icons.language_rounded,
          title: 'Dil',
          subtitle: 'Uygulama dilini değiştir',
          hasSubtitle: true,
          section: kProfileSectionType.language),
      ProfileSectionItem(
        icon: Icons.hourglass_empty,
        title: 'Zaman Biçimi',
        subtitle: 'Zaman biçimini değiştir',
        hasSubtitle: true,
        section: kProfileSectionType.timeFormat,
      ),
    ],
    [
      ProfileSectionItem(
        icon: Icons.track_changes,
        title: 'Günlük Hedef',
        subtitle: 'Günlük hedefini ayarla',
        section: kProfileSectionType.dailyGoal,
      ),
      ProfileSectionItem(
        icon: Icons.remember_me,
        title: 'Hatırlatma',
        subtitle: 'Hatırlatıcıyı ayarla',
        section: kProfileSectionType.dailyGoal,
      ),
      ProfileSectionItem(
          icon: Icons.language_rounded,
          title: 'Dil',
          subtitle: 'Uygulama dilini değiştir',
          hasSubtitle: true,
          section: kProfileSectionType.language),
      ProfileSectionItem(
        icon: Icons.hourglass_empty,
        title: 'Zaman Biçimi',
        subtitle: 'Zaman biçimini değiştir',
        hasSubtitle: true,
        section: kProfileSectionType.timeFormat,
      ),
    ],
    [
      ProfileSectionItem(
        icon: Icons.share_outlined,
        title: 'DrinkUp\'ı Paylaş',
        subtitle: 'Uygulamayı arkadaşlarınızla paylaşın',
        section: kProfileSectionType.share,
      ),
      ProfileSectionItem(
        icon: Icons.help_outline_outlined,
        title: 'Yardım & Geri Bildirim',
        subtitle: 'Yardım alın ve geri bildirim gönderin',
        section: kProfileSectionType.help,
      ),
      ProfileSectionItem(
        icon: Icons.lightbulb_outline_rounded,
        title: 'DrinkUp Hakkında',
        subtitle: 'Uygulama hakkında daha fazla bilgi edinin',
        section: kProfileSectionType.about,
      ),
      ProfileSectionItem(
        icon: Icons.delete_outline_outlined,
        title: 'Verileri Sil',
        subtitle: 'Tüm verilerinizi silin',
        section: kProfileSectionType.deleteData,
      ),
    ]
  ],
};

const Map<AppTheme, List<Color>> kProfileBackgroundColors = {
  AppTheme.light: [
    /* Color.fromARGB(255, 0, 4, 219),
    Color.fromARGB(255, 22, 0, 216),
    Color.fromARGB(255, 10, 23, 199), */
    Color.fromARGB(255, 13, 71, 179),
    /* Color.fromARGB(255, 56, 37, 221), */
    Color.fromARGB(255, 13, 71, 179),
    /* Color.fromARGB(255, 31, 5, 180),
    Color.fromARGB(255, 50, 1, 56),
    Color.fromARGB(255, 4, 50, 150), */
  ],
  AppTheme.dark: [
    Color.fromARGB(255, 20, 20, 20),
    Color.fromARGB(255, 19, 19, 19)
  ],
};

const double kProfileSectionOuterPaddingVerticalFactor = 0.1;
const double kProfileSectionOuterPaddingHorizontalFactor = 0.6;
const double kProfileSectionOuterTopMarginFactor = /* 1 */ 0.2;
const double kProfileSectionOuterMarginHorizontalFactor = 0.2;
const double kProfileSectionInnerPaddingFactor = 0.5;
const Color
    kProfileSectionBackgroundColor = /* Color.fromARGB(96, 0, 132, 255); */
    Color.fromARGB(109, 16, 120, 255);
const double kProfileSectionBorderRadiusFactor = 0.4;
const Color kProfileSectionBorderColor = /* Color.fromARGB(255, 64, 93, 255); */
    Color.fromARGB(24, 255, 255, 255);
const double kProfileSectionBorderWidthFactor = 0.005;
const double kProfileSectionInnerListPaddingFactor = 0.40;

const Map<Language, String> kProfileWelcomeSectionTitle = {
  Language.english: 'Welcome Back,',
  Language.turkish: 'Hoş geldin,',
};

const double kProfileWelcomeSectionInnerPaddingFactor = 0.8;

const String kProfileWelcomeSectionTitleFontFamily = 'Sofia-Pro';
const double kProfileWelcomeSectionTitleFontSizeFactor = 1.6;
const FontWeight kProfileWelcomeSectionTitleFontWeight = FontWeight.w300;
const double kProfileWelcomeSectionUserPaddingFactor = 0;
const double kProfileWelcomeSectionUserIconCircleSizeFactor = 3.225;
const double kProfileWelcomeSectionUserIconBorderRadiusFactor = 2;
const Color kProfileWelcomeSectionUserIconBackgroundColor =
    Color.fromARGB(52, 47, 0, 255);
const IconData kProfileWelcomeSectionUserIcon = Ionicons.person;
const double kProfileWelcomeSectionUserIconSizeFactor = 1.95;
const double kProfileWelcomeSectionTitleSpaceFactor = 0.5;
const Color kProfileWelcomeSectionUserIconColor =
    Color.fromARGB(255, 255, 255, 255);

const double kProfileWelcomeSectionUserRightMarginFactor = 0.66;

const String kProfileWelcomeSectionUsernameFontFamily = 'Sofia-Pro';
const double kProfileWelcomeSectionUsernameFontSizeFactor = 1.63;
const FontWeight kProfileWelcomeSectionUsernameFontWeight = FontWeight.w500;
const double kProfileWelcomeSectionUsernameSpaceFactor = 0.15;
const Color kProfileWelcomeSectionUsernameColor =
    Color.fromARGB(255, 247, 247, 247);

const Map<Language, String> kProfileWelcomeSectionuUserSubtitle = {
  Language.english: 'View Profile',
  Language.turkish: 'Profili Gör',
};

const Color kProfileWelcomeSectionUserSubtitleColor =
    Color.fromARGB(255, 243, 243, 243);

const String kProfileWelcomeSectionUserSubtitleFontFamily = 'Sofia-Pro';
const double kProfileWelcomeSectionUserSubtitleFontSizeFactor = 1.1;
const FontWeight kProfileWelcomeSectionUserSubtitleFontWeight = FontWeight.w300;

const IconData kProfileWelcomeSectionSettingsIcon = Icons.settings;
const double kProfileWelcomeSectionSettingsRightMarginFactor = 0.41;
const double kProfileWelcomeSectionSettingsIconSizeFactor = 1.04;
const Color kProfileWelcomeSectionSettingsIconColor =
    Color.fromARGB(255, 255, 255, 255);

const Color kProfileItemsIconColor = Color.fromARGB(255, 241, 241, 241);
const Color kProfileItemsLabelColor = Color.fromARGB(255, 241, 241, 241);
const Color kProfileItemsButtonColor = Color.fromARGB(255, 235, 235, 235);
const Color kProfileItemsTitleColor = Color.fromARGB(255, 226, 226, 226);
const FontWeight kProfileItemsTitleFontWeight = FontWeight.w700;
const double kProfileItemsTitleFontSizeFactor = 1.3;
/* EdgeInsets.symmetric(vertical: 5, horizontal: 10); */

const Map<Language, String> kProfileAppBarTitle = {
  Language.english: 'Profile',
  Language.turkish: 'Profil',
};
