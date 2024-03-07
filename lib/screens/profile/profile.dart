import 'package:drinkup_app/blocs/water_progress/water_progress.dart';
import 'package:drinkup_app/models/water_unit/water_unit_model.dart';
import 'package:drinkup_app/screens/profile/profile_items.dart';
import 'package:drinkup_app/services/size/size_service.dart';
import 'package:drinkup_app/constants/constants.dart' as Constants;
import 'package:drinkup_app/services/user/user_service.dart';
import 'package:drinkup_app/utils/utils.dart';
import 'package:drinkup_app/constants/route_constants.dart';
import 'package:drinkup_app/screens/progress/target_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:drinkup_app/constants/profile_constants.dart'
    as ProfileConstants;
import 'package:flutter/material.dart';
import 'package:drinkup_app/blocs/config/config.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:drinkup_app/models/water_data/water_data_model.dart';
import 'package:drinkup_app/repositories/data/data_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: ProfileConstants.kProfileBackgroundColors[
                  BlocProvider.of<ConfigBloc>(context)
                      .state
                      .config
                      .appTheme]!)),
      child: SingleChildScrollView(
        child: Column(children: [
          // AppBar
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: Constants.kAppBarBackgroundColor[
                      BlocProvider.of<ConfigBloc>(context)
                          .state
                          .config
                          .appTheme]!),
              boxShadow: [
                BoxShadow(
                  color: Constants.kAppBarShadowColor,
                  blurRadius: Constants.kAppBarShadowBlurRadiusFactor *
                      SizeService().heightUnit,
                )
              ],
            ),
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    SizeService().heightUnit *
                        Constants.kAppBarOuterPaddingTopFactor,
                bottom: SizeService().heightUnit *
                    Constants.kAppBarOuterPaddingBottomFactor,
                left: SizeService().widthUnit *
                    Constants.kAppBarOuterPaddingHorizontalFactor,
                right: SizeService().widthUnit *
                    Constants.kAppBarOuterPaddingHorizontalFactor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    padding: EdgeInsets.only(
                        left: SizeService().widthUnit *
                            Constants.kAppBarTitleLeftPaddingFactor),
                    child: Text(
                      ProfileConstants.kProfileAppBarTitle[
                          BlocProvider.of<ConfigBloc>(context)
                              .state
                              .config
                              .language]!,
                      style: TextStyle(
                        color: Constants.kAppBarTitleColor,
                        fontFamily: Constants.kAppBarTitleFontFamily,
                        fontSize: Constants.kAppBarTitleFontSizeFactor *
                            SizeService().fontSize,
                        fontWeight: Constants.kAppBarTitleFontWeight,
                      ),
                    )),
                Container(
                  padding: EdgeInsets.only(
                      right: SizeService().widthUnit *
                          Constants.kAppBarIconRightPaddingFactor),
                  child: InkWell(
                    onTap: () {
                      GoRouter.of(context).pushNamed(Routes.settings.name);
                    },
                    child: Icon(
                      Constants.kAppBarIcon,
                      size: Constants.kAppBarIconSizeFactor *
                          SizeService().iconSize,
                      color: Constants.kAppBarIconColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Profile Section
          /* SizedBox(height: SizeService().heightUnit * 2), */
          Container(
              padding: EdgeInsets.symmetric(
                  vertical: SizeService().heightUnit *
                      ProfileConstants
                          .kProfileSectionOuterPaddingVerticalFactor,
                  horizontal: SizeService().widthUnit *
                      ProfileConstants
                          .kProfileSectionOuterPaddingHorizontalFactor),
              margin: EdgeInsets.only(
                top: SizeService().heightUnit *
                    ProfileConstants.kProfileSectionOuterTopMarginFactor,
                left: SizeService().widthUnit *
                    ProfileConstants.kProfileSectionOuterMarginHorizontalFactor,
                right: SizeService().widthUnit *
                    ProfileConstants.kProfileSectionOuterMarginHorizontalFactor,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeService().widthUnit *
                              ProfileConstants
                                  .kProfileWelcomeSectionInnerPaddingFactor,
                          horizontal: SizeService().widthUnit *
                              ProfileConstants
                                  .kProfileSectionInnerPaddingFactor),
                      decoration: BoxDecoration(
                          color:
                              ProfileConstants.kProfileSectionBackgroundColor,
                          borderRadius: BorderRadius.circular(
                              SizeService().heightUnit *
                                  ProfileConstants
                                      .kProfileSectionBorderRadiusFactor),
                          border: Border.all(
                              color:
                                  ProfileConstants.kProfileSectionBorderColor,
                              width: SizeService().heightUnit *
                                  ProfileConstants
                                      .kProfileSectionBorderWidthFactor)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeService().widthUnit *
                                    ProfileConstants
                                        .kProfileWelcomeSectionUserPaddingFactor,
                                horizontal: SizeService().widthUnit *
                                    ProfileConstants
                                        .kProfileWelcomeSectionUserPaddingFactor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: SizeService().iconSize *
                                            ProfileConstants
                                                .kProfileWelcomeSectionUserIconCircleSizeFactor,
                                        width: SizeService().iconSize *
                                            ProfileConstants
                                                .kProfileWelcomeSectionUserIconCircleSizeFactor,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              SizeService().iconSize *
                                                  ProfileConstants
                                                      .kProfileWelcomeSectionUserIconBorderRadiusFactor),
                                          color: ProfileConstants
                                              .kProfileWelcomeSectionUserIconBackgroundColor,
                                        ),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          child: Image.asset(
                                            'assets/images/profile-pictures/blue-waves-circle-1.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),

                                        /* child: Icon(
                                          ProfileConstants
                                              .kProfileWelcomeSectionUserIcon,
                                          size: ProfileConstants
                                                  .kProfileWelcomeSectionUserIconSizeFactor *
                                              SizeService().iconSize,
                                          color: ProfileConstants
                                              .kProfileWelcomeSectionUserIconColor,
                                        ), */
                                      ),
                                      SizedBox(
                                          width: SizeService().widthUnit *
                                              ProfileConstants
                                                  .kProfileWelcomeSectionUserRightMarginFactor),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                                UserService()
                                                    .currentUser
                                                    .username,
                                                style: TextStyle(
                                                  color: ProfileConstants
                                                      .kProfileWelcomeSectionUsernameColor,
                                                  fontFamily: ProfileConstants
                                                      .kProfileWelcomeSectionUsernameFontFamily,
                                                  fontSize: ProfileConstants
                                                          .kProfileWelcomeSectionUsernameFontSizeFactor *
                                                      SizeService().fontSize,
                                                  fontWeight: ProfileConstants
                                                      .kProfileWelcomeSectionUsernameFontWeight,
                                                )),
                                          ),
                                          SizedBox(
                                              height: ProfileConstants
                                                      .kProfileWelcomeSectionUsernameSpaceFactor *
                                                  SizeService().heightUnit),
                                          InkWell(
                                            onTap: () {
                                              RepositoryProvider.of<
                                                      DataRepository>(context)
                                                  .resetLocalAll();
                                            },
                                            child: Container(
                                              child: Text(
                                                  ProfileConstants
                                                          .kProfileWelcomeSectionuUserSubtitle[
                                                      BlocProvider.of<
                                                                  ConfigBloc>(
                                                              context)
                                                          .state
                                                          .config
                                                          .language]!,
                                                  style: TextStyle(
                                                    color: ProfileConstants
                                                        .kProfileWelcomeSectionUserSubtitleColor,
                                                    fontFamily: ProfileConstants
                                                        .kProfileWelcomeSectionUserSubtitleFontFamily,
                                                    fontSize: ProfileConstants
                                                            .kProfileWelcomeSectionUserSubtitleFontSizeFactor *
                                                        SizeService().fontSize,
                                                    fontWeight: ProfileConstants
                                                        .kProfileWelcomeSectionUserSubtitleFontWeight,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: SizeService().widthUnit *
                                          ProfileConstants
                                              .kProfileWelcomeSectionSettingsRightMarginFactor),
                                  child: InkWell(
                                    onTap: () {
                                      GoRouter.of(context)
                                          .pushNamed(Routes.settings.name);
                                    },
                                    child: Icon(
                                      ProfileConstants
                                          .kProfileWelcomeSectionSettingsIcon,
                                      size: ProfileConstants
                                              .kProfileWelcomeSectionSettingsIconSizeFactor *
                                          SizeService().iconSize,
                                      color: ProfileConstants
                                          .kProfileWelcomeSectionSettingsIconColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])),
          const ProfileItems(),
          SizedBox(
              height: SizeService().heightUnit *
                  Constants.kBottomNavigationBarHeightFactor)
        ]),
      ),
    );
  }
}
