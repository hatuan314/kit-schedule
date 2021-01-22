import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/common/app_constance.dart';
import 'package:schedule/common/themes/theme_border.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/presentation/screen/search_screen/bloc/search_bloc.dart';
import 'package:schedule/presentation/screen/search_screen/bloc/search_event.dart';
import 'package:schedule/presentation/screen/search_screen/bloc/search_state.dart';
import 'package:schedule/presentation/screen/search_screen/search_screen_constance.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  final searchFormKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.secondColor,
      body: SafeArea(
          child: Form(
        key: searchFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: SearchScreenConstance.paddingVertical,
              horizontal: SearchScreenConstance.paddingHorizontal),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: SearchScreenConstance.search,
                        hintStyle: ThemeText.textStyle,
                        border: ThemBorder.outlineInputBorder,
                      ),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        size: AppConstance.iconSize,
                      ),
                      onPressed: () {
                        BlocProvider.of<SearchBloc>(context)
                          ..add(SearchScheduleEvent(
                              eventName: searchController.text));
                      }),
                ],
              ),
              BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
                if (state is SearchInitState)
                  return _historyListView(state);
                else if (state is SearchSuccessState)
                  return eventListView(state);
                else
                  return SizedBox();
              })
            ],
          ),
        ),
      )),
    );
  }

  Widget _historyListView(SearchInitState state) {
    return Expanded(
      child: ListView.builder(
          itemCount: state.searchHistory.length,
          itemBuilder: (context, index) =>
              (state.searchHistory.isEmpty || state.searchHistory.length == 0)
                  ? SizedBox()
                  : GestureDetector(
                      onTap: () {
                        BlocProvider.of<SearchBloc>(context)
                          ..add(SearchScheduleEvent(
                              eventName: state.searchHistory[index]));
                      },
                      child: ListTile(
                        title: Text(state.searchHistory[index]),
                      ),
                    )),
    );
  }

  Widget eventListView(SearchSuccessState state) {
    return Expanded(
      child: ListView.builder(
          itemCount: state.listSchedule.length,
          itemBuilder: (context, index) =>
              (state.listSchedule.isEmpty || state.listSchedule.length == 0)
                  ? Center(
                      child: Text(
                        SearchScreenConstance.noSchedule,
                        style: ThemeText.textStyle,
                      ),
                    )
                  : ListTile(
                      title: Text(state.listSchedule[index].title,
                          style: ThemeText.textStyle),
                      subtitle: Text(state.listSchedule[index].note,
                          style: ThemeText.textStyle),
                    )),
    );
  }
}
