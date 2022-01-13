import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/common/enums/view_state.dart';
import 'package:schedule/common/injector/injector.dart';
import 'package:schedule/presentation/journey/add_scores/add_score_constants.dart';
import 'package:schedule/presentation/journey/search_subject/bloc/search_subject_bloc.dart';
import 'package:schedule/presentation/journey/search_subject/bloc/search_subject_event.dart';
import 'package:schedule/presentation/journey/search_subject/bloc/search_subject_state.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/presentation/widget/text_field_widget/text_field_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchSubjectDialog extends StatelessWidget {
  SearchSubjectDialog({Key? key, required this.grade}) : super(key: key);

  final String grade;

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchSubjectBloc>(
      create: (context) =>
          Injector.getIt<SearchSubjectBloc>()..add(GetSubjectListEvent(grade)),
      child: BlocBuilder<SearchSubjectBloc, SearchSubjectState>(
          builder: (context, searchSubjectState) => SafeArea(
                child: Scaffold(
                  backgroundColor: AppColor.secondColor,
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.clear,
                        color: AppColor.personalScheduleColor,
                      ),
                    ),
                    elevation: 0,
                    backgroundColor: AppColor.secondColor,
                    title: Text(
                      AppLocalizations.of(context)!.chooseSubject,
                      style: ThemeText.labelStyle
                          .copyWith(fontSize: AddScoreConstants.fontSize),
                    ),
                  ),
                  body: Padding(
                    padding: EdgeInsets.all(AddScoreConstants.padding),
                    child: Column(
                      children: [
                        TextFieldWidget(
                          controller: _controller,
                          textStyle: ThemeText.labelStyle,
                          colorBoder: AppColor.personalScheduleColor,
                          onChanged: (value) {
                            BlocProvider.of<SearchSubjectBloc>(context)
                                .add(SearchEvent(keyword: value));
                          },
                          seffixIcon: IconButton(
                              onPressed: () {
                                BlocProvider.of<SearchSubjectBloc>(context)
                                    .add(UpdateSubjectFromFirebaseEvent(grade));
                              },
                              icon: Icon(
                                Icons.update,
                                color: AppColor.personalScheduleColor,
                              )),
                        ),
                        searchSubjectState.viewState == ViewState.busy
                            ? Container(
                                height: 150.h,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ))
                            : Expanded(
                                child: ListView.builder(
                                    itemCount:
                                        searchSubjectState.subjectsList.length,
                                    itemBuilder: (context, index) {
                                      //
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pop(
                                              context,
                                              searchSubjectState
                                                  .subjectsList[index]);
                                        },
                                        child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                AddScoreConstants.padding),
                                            child: Text(
                                              searchSubjectState
                                                  .subjectsList[index]
                                                  .subjectName!,
                                              style: ThemeText.labelStyle
                                                  .copyWith(fontSize: 14.sp),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
