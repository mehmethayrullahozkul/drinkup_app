import 'package:drinkup_app/constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drinkup_app/blocs/config/config.dart';
import 'package:drinkup_app/blocs/water_progress/water_progress.dart';
import 'package:drinkup_app/services/size/size_service.dart';
import 'package:go_router/go_router.dart';
import 'package:drinkup_app/constants/constants.dart' as Constants;
import 'package:drinkup_app/constants/profile_constants.dart'
    as ProfileConstants;

class ProfileItems extends StatefulWidget {
  const ProfileItems({super.key});

  @override
  State<ProfileItems> createState() => _ProfileItemsState();
}

class _ProfileItemsState extends State<ProfileItems> {
  @override
  void initState() {
    super.initState();
  }

  void Function() _profileFunctions(ProfileConstants.kProfileSectionType type) {
    switch (type) {
      case ProfileConstants.kProfileSectionType.display:
        break;
      case ProfileConstants.kProfileSectionType.notifications:
        break;
      case ProfileConstants.kProfileSectionType.units:
        break;
      case ProfileConstants.kProfileSectionType.dailyGoal:
        break;
      case ProfileConstants.kProfileSectionType.reminder:
        break;
      case ProfileConstants.kProfileSectionType.language:
        return () =>
            GoRouter.of(context).pushNamed(Routes.changeLanguageDialog.name);
      case ProfileConstants.kProfileSectionType.timeFormat:
        break;
      case ProfileConstants.kProfileSectionType.share:
        break;
      case ProfileConstants.kProfileSectionType.help:
        break;
      case ProfileConstants.kProfileSectionType.about:
        break;
      case ProfileConstants.kProfileSectionType.deleteData:
        break;
    }
    return () {};
  }

  @override
  Widget build(BuildContext context) {
    ProfileConstants.ProfileSectionItem sectionItem;

    print(ProfileConstants
        .kProfileSections[
            BlocProvider.of<ConfigBloc>(context).state.config.language]!
        .length);
    print(ProfileConstants
        .kProfileSections[
            BlocProvider.of<ConfigBloc>(context).state.config.language]![0][0]
        .section);
    return SizedBox(
      height: 12 * 48.0 + 240,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemExtent: 4 * 48 + 68,
          itemCount: ProfileConstants
              .kProfileSections[
                  BlocProvider.of<ConfigBloc>(context).state.config.language]!
              .length,
          itemBuilder: (context, index) {
            if (index > ProfileConstants.kProfileSectionTitles.length) {
              return Container();
            }

            return Container(
                padding: EdgeInsets.symmetric(
                    vertical: SizeService().heightUnit *
                        ProfileConstants
                            .kProfileSectionOuterPaddingVerticalFactor,
                    horizontal: SizeService().widthUnit *
                        ProfileConstants
                            .kProfileSectionOuterPaddingHorizontalFactor),
                margin: EdgeInsets.only(
                  left: SizeService().widthUnit *
                      ProfileConstants
                          .kProfileSectionOuterMarginHorizontalFactor,
                  right: SizeService().widthUnit *
                      ProfileConstants
                          .kProfileSectionOuterMarginHorizontalFactor,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: ProfileConstants
                                    .kProfileSectionInnerPaddingFactor *
                                SizeService().widthUnit,
                            horizontal: ProfileConstants
                                    .kProfileSectionInnerPaddingFactor *
                                0.1 *
                                SizeService().widthUnit),
                        decoration: BoxDecoration(
                            color:
                                ProfileConstants.kProfileSectionBackgroundColor,
                            borderRadius: BorderRadius.circular(ProfileConstants
                                    .kProfileSectionBorderRadiusFactor *
                                SizeService().heightUnit),
                            border: Border.all(
                                color:
                                    ProfileConstants.kProfileSectionBorderColor,
                                width: ProfileConstants
                                        .kProfileSectionBorderWidthFactor *
                                    SizeService().heightUnit)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ProfileConstants
                                              .kProfileSectionBorderRadiusFactor *
                                          SizeService().widthUnit))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: ProfileConstants
                                                .kProfileSectionInnerPaddingFactor *
                                            SizeService().widthUnit *
                                            0.9,
                                        horizontal: ProfileConstants
                                                .kProfileSectionInnerPaddingFactor *
                                            SizeService().widthUnit *
                                            0.8),
                                    /* decoration: BoxDecoration(), */
                                    child: Text(
                                        ProfileConstants.kProfileSectionTitles[
                                            BlocProvider.of<ConfigBloc>(context)
                                                .state
                                                .config
                                                .language]![index],
                                        style: TextStyle(
                                            color: ProfileConstants
                                                .kProfileItemsTitleColor,
                                            fontSize: SizeService().fontSize *
                                                ProfileConstants
                                                    .kProfileItemsTitleFontSizeFactor,
                                            letterSpacing: 0.5,
                                            fontFamily: 'Sofia-Pro',
                                            fontWeight: ProfileConstants
                                                .kProfileItemsTitleFontWeight)),
                                  ),
                                  SizedBox(
                                    height: /* ProfileConstants
                                                .kProfileSections[
                                                    BlocProvider.of<ConfigBloc>(
                                                            context)
                                                        .state
                                                        .config
                                                        .language]![index]
                                                .length  */
                                        4 * 48.0 + 0.0,
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemExtent: 48.0,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: ProfileConstants
                                            .kProfileSections[
                                                BlocProvider.of<ConfigBloc>(
                                                        context)
                                                    .state
                                                    .config
                                                    .language]![index]
                                            .length,
                                        itemBuilder: (context, subindex) {
                                          sectionItem = ProfileConstants
                                                  .kProfileSections[
                                              BlocProvider.of<ConfigBloc>(
                                                      context)
                                                  .state
                                                  .config
                                                  .language]![index][subindex];

                                          return Material(
                                            color: const Color.fromARGB(
                                                0, 255, 255, 255),
                                            child: InkWell(
                                              onTap: _profileFunctions(
                                                  sectionItem.section),
                                              child: Container(
                                                height: 48,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                          ProfileConstants
                                                              .kProfileSections[
                                                                  BlocProvider.of<
                                                                              ConfigBloc>(
                                                                          context)
                                                                      .state
                                                                      .config
                                                                      .language]![
                                                                  index]
                                                                  [subindex]
                                                              .icon,
                                                          size: 22,
                                                          color: ProfileConstants
                                                              .kProfileItemsIconColor),
                                                      SizedBox(width: 20),
                                                      Expanded(
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              ProfileConstants
                                                                  .kProfileSections[
                                                                      BlocProvider.of<ConfigBloc>(
                                                                              context)
                                                                          .state
                                                                          .config
                                                                          .language]![
                                                                      index]
                                                                      [subindex]
                                                                  .title,
                                                              style: TextStyle(
                                                                fontSize: 13,
                                                                color: ProfileConstants
                                                                    .kProfileItemsLabelColor,
                                                                fontFamily:
                                                                    'Sofia-Pro',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                DefaultTextStyle(
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            10.0),
                                                                    child: _ProfileSectionWidget(
                                                                        index:
                                                                            index,
                                                                        subindex:
                                                                            subindex),
                                                                  ),
                                                                ),
                                                                Icon(
                                                                    Icons
                                                                        .keyboard_arrow_right_rounded,
                                                                    size: 20,
                                                                    color: ProfileConstants
                                                                        .kProfileItemsButtonColor),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ),
                              /** */
                            ),
                          ],
                        ),
                      ),
                    ]));
          }),
    );
  }
}

class _ProfileSectionWidget extends StatefulWidget {
  final int index;
  final int subindex;

  const _ProfileSectionWidget({
    super.key,
    required this.index,
    required this.subindex,
  });

  @override
  _ProfileSectionWidgetState createState() => _ProfileSectionWidgetState();
}

class _ProfileSectionWidgetState extends State<_ProfileSectionWidget> {
  @override
  Widget build(BuildContext context) {
    final configBloc = BlocProvider.of<ConfigBloc>(context);
    final waterProgressBloc = BlocProvider.of<WaterProgressBloc>(context);

    final sectionData = ProfileConstants
            .kProfileSections[configBloc.state.config.language]![widget.index]
        [widget.subindex];

    if (sectionData.hasSubtitle) {
      switch (sectionData.section) {
        case ProfileConstants.kProfileSectionType.display:
          return Text(configBloc.state.config.appTheme
              .toStringInLanguage(configBloc.state.config.language));
        case ProfileConstants.kProfileSectionType.notifications:
          return Text('');
        case ProfileConstants.kProfileSectionType.units:
          return Text(waterProgressBloc.state.target.toString());
        case ProfileConstants.kProfileSectionType.dailyGoal:
          return Text(waterProgressBloc.state.target.toString());
        case ProfileConstants.kProfileSectionType.reminder:
          return Text('');
        case ProfileConstants.kProfileSectionType.language:
          return Text(configBloc.state.config.language.toStringInLanguage());
        case ProfileConstants.kProfileSectionType.timeFormat:
          return Text('');
        case ProfileConstants.kProfileSectionType.share:
          return Text('');
        case ProfileConstants.kProfileSectionType.help:
          return Text('');
        case ProfileConstants.kProfileSectionType.about:
          return Text('');
        case ProfileConstants.kProfileSectionType.deleteData:
          return Text('');
      }
    }

    return Container();
  }
}
