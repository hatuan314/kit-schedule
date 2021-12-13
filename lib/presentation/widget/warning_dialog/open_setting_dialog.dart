import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:schedule/presentation/journey/main/main_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';

void openSettingDiaLog(
    {required BuildContext context,
     }) {
  AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      body: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: MainScreenConstants.dialogPaddingVertical,
              horizontal: MainScreenConstants.dialogPaddingHorizontal),
          child:     Text(AppLocalizations.of(context)!.permissonApp,
            style: ThemeText.titleStyle.copyWith(
                color: AppColor.thirdColor,
                fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),),
      btnOk: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          openAppSettings();
        },
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
        onTap: () {
          Navigator.pop(context);
        },
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
