import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:schedule/presentation/journey/main/main_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';

void warningDialog(
    {required BuildContext context,
    required bool isSynch,
    String? name,
    required Function(BuildContext) btnOk,
    required Function(BuildContext) btnCancel}) {
  AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      body: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: MainScreenConstants.dialogPaddingVertical,
              horizontal: MainScreenConstants.dialogPaddingHorizontal),
          child: Column(
            children: [
              isSynch
                  ? SizedBox()
                  : Text(
                      AppLocalizations.of(context)!.synchronizedTxt,
                      style: ThemeText.titleStyle.copyWith(
                          fontSize: MainScreenConstants.synchronizedSize),
                    ),
              RichText(
                text: TextSpan(
                    text: AppLocalizations.of(context)!.doYouWant,
                    style: ThemeText.titleStyle.copyWith(
                      color: AppColor.thirdColor,
                    ),
                    children: [
                      TextSpan(
                        text: name == null
                            ? AppLocalizations.of(context)!.logOut
                            : AppLocalizations.of(context)!.delete,
                        style: ThemeText.titleStyle.copyWith(
                          color: AppColor.errorColor,
                        ),
                      ),
                      TextSpan(
                        text: MainScreenConstants.punctuationMarkTxt,
                        style: ThemeText.titleStyle.copyWith(
                            color: AppColor.thirdColor,
                            fontWeight: FontWeight.normal),
                      ),
                    ]),
              ),
              name == null
                  ? SizedBox()
                  : Text(
                      '$name',
                      style: ThemeText.titleStyle.copyWith(
                        color: AppColor.thirdColor,
                        fontWeight: FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    )
            ],
          )),
      btnOk: GestureDetector(
        onTap: () => btnOk(context),
        child: Container(
          margin: const EdgeInsets.only(
              bottom: MainScreenConstants.containerMarginBottom),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.fourthColor,
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(
                  0,
                  3,
                ),
              )
            ],
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: MainScreenConstants.paddingVertical,
                horizontal: MainScreenConstants.paddingHorizontal),
            child: Text(
              AppLocalizations.of(context)!.yes,
              style: ThemeText.buttonLabelStyle.copyWith(
                  color: AppColor.secondColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      btnCancel: GestureDetector(
        onTap: () => btnCancel(context),
        child: Container(
          margin: const EdgeInsets.only(
              bottom: MainScreenConstants.containerMarginBottom),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.errorColor,
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(
                  0,
                  3,
                ),
              )
            ],
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: MainScreenConstants.paddingVertical,
                horizontal: MainScreenConstants.paddingHorizontal),
            child: Text(AppLocalizations.of(context)!.no,
                style: ThemeText.buttonLabelStyle.copyWith(
                    color: AppColor.secondColor, fontWeight: FontWeight.bold)),
          ),
        ),
      )).show();
}
