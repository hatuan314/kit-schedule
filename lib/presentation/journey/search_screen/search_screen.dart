import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/common/app_constance.dart';
import 'package:schedule/common/themes/theme_border.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/presentation/journey/search_screen/bloc/search_bloc.dart';
import 'package:schedule/presentation/journey/search_screen/bloc/search_event.dart';
import 'package:schedule/presentation/journey/search_screen/bloc/search_state.dart';
import 'package:schedule/presentation/journey/search_screen/search_screen_constance.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.secondColor,
      appBar: AppBar(
        title: TextFormField(
          controller: searchController,
          style:  ThemeText.textStyle.copyWith(color: ThemeColor.secondColor),
          decoration: InputDecoration(
            hintText: SearchScreenConstance.search,
            hintStyle:
                ThemeText.textStyle.copyWith(color: ThemeColor.secondColor),
            border: ThemeBorder.outlineInputBorder,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: AppConstance.iconSize,
              ),
              onPressed: () {
                BlocProvider.of<SearchBloc>(context)
                  ..add(SearchScheduleEvent(eventName: searchController.text));
              }),
        ],
      ),
      body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                if (state is SearchInitState)
                  return _historyListView(state);
                else if (state is SearchSuccessState)
                  return eventListView(state);
                else
                  return SizedBox();
              })
            ],
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
            itemBuilder: (context, index) => (state.listSchedule.isEmpty ||
                    state.listSchedule.length == 0)
                ? Center(
                    child: Text(
                      SearchScreenConstance.noSchedule,
                      style: ThemeText.textStyle,
                    ),
                  )
                : SearchEventItem()));
  }
}
