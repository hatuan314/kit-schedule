import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/blocs/blocs.dart';
import 'package:schedule/presentation/journey/search/search_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/presentation/widget/loading_widget/loading_widget.dart';
import 'package:schedule/presentation/widget/personal_schedule_widget.dart';
import 'package:schedule/presentation/widget/school_schedule_widget.dart';
class SearchScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /*final circleShape = Shape(
      size: 8,
      shape: DotShape.Circle,
      spacing: 8,
    );*/
    return Scaffold(
      backgroundColor: AppColor.secondColor,
      body: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchSuccessState) {

          }
        },
        child: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                height:MediaQuery.of(context).size.height*3/4,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    _buildPageView(state),
                    //todo buildExampleIndicatorWithShapeAndBottomPos(circleShape, 8),
                  ],
                ),
              ),
              _searchWidget(context, state),
              // Expanded(
              //   flex: 85,
              //   child:
              // ),
              // Expanded(
              //   flex: 15,
              //   child:
              // )

            ],
          );
        }),
      ),
    );
  }

  Padding _searchWidget(BuildContext context, SearchState state) {
    return Padding(
      padding:const
      EdgeInsets.symmetric(horizontal: SearchConstains.paddingHorizontal,
 ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            SearchConstains.searchTxt,
            style:ThemeText.titleStyle.copyWith( color: AppColor.searchColor, )
          ),
          InkWell(
            onTap: () => _btnSearchOnPress(context),
            child: Container(
              width: double.infinity,
              margin: const
              EdgeInsets.only(bottom:SearchConstains.containerMagrinBottom),
              child: Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            color: AppColor.searchBorderColor,
                            width: SearchConstains.borderWidth)),
                    alignment: Alignment.center,
                      padding:const EdgeInsets.symmetric(
                         vertical: SearchConstains.searchContainerPaddingVertical),
                    child: Text(
                      '${state.selectDay}',
                      style: ThemeText.titleStyle.copyWith( color:AppColor.searchColor,
                )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SearchConstains.paddingHorizontal),
                    child: Icon(
                      Icons.search,
                      color: AppColor.searchColor,
                      size: SearchConstains.iconSize,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /*Widget buildExampleIndicatorWithShapeAndBottomPos(
      Shape shape, double bottomPos) {
    return Positioned(
      bottom: bottomPos,
      left: 0,
      right: 0,
      child: WormIndicator(
        length: 2,
        controller: _pageController,
        shape: shape,
      ),
    );}*/


  _buildPageView(SearchState state) {
    return Container(
      margin:
      EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
          vertical: ScreenUtil().setHeight(20)),
      alignment: Alignment.center,
      child: PageView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _pageController,
        itemBuilder: (BuildContext context, index) {
          if (state is SearchLoadingState)
            return LoadingWidget();
          else if (state is SearchSuccessState) {
            if (index == 0)
              return SchoolScheduleWidget(state: state);
            else
              return PersonalScheduleWidget(state: state);
          } else {
            return SizedBox();
          }
        },
        itemCount: 2,
      ),
    );
  }


  _btnSearchOnPress(BuildContext context) async {
    DateTime? selectDay = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime
          .now()
          .year - 10),
      lastDate: DateTime(DateTime
          .now()
          .year + 10),
      borderRadius: 20,
      fontFamily: 'MR',
      imageHeader: AssetImage("assets/img/calendar_header.jpg"),
    );
    BlocProvider.of<SearchBloc>(context)
      ..add(SearchButtonOnPress(selectDay!));
  }

}