
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';

import '../add_score_constants.dart';


// ignore: must_be_immutable
class CustomSelectMultiItem extends StatefulWidget {
  final BuildContext context;
  final List<String> items;
  String? title;
  final Function(List<int>) onChange;
  Function(int)? onSelectItem;
  Function(int)? onRemoveItem;
  CustomSelectMultiItem({
    Key? key,
    this.onSelectItem,
    this.onRemoveItem,
    this.title,
    required this.context,
    required this.items,
    required this.onChange,
  }) : super(key: key);

  @override
  _CustomSelectMultiItemsState createState() => _CustomSelectMultiItemsState();
}

class _CustomSelectMultiItemsState extends State<CustomSelectMultiItem> {
  List<String> selectedItems = [];
  List<String> searchList = [];
  bool isSearching = false;
  double sizeWitdhTag = 0;
  // BehaviorSubject<List<String>> searchItemSubject = BehaviorSubject();

  void showListItem(BuildContext context) {
    // searchItemSubject = BehaviorSubject.seeded(widget.items);
    showDialog(
        context: context,
        builder: (context) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).viewInsets.bottom <= 160
                        ? 200
                        : 10,
                    horizontal: AddScoreConstants.padding),
                child: Container(
                  decoration: BoxDecoration(
                      color:  AppColor.secondColor,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 56,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom:
                                  BorderSide(color: Color(0xffEDF0FD)))),
                          padding: const EdgeInsets.only(left: 28, right: 19),
                          child: Stack(
                            children: [
                              Align(
                                child: Text(
                                  widget.title??'Chọn đơn vị',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                bottom: 0,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: const Color(0xffA2AEBD),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // BaseSearchBar(onChange: (keySearch) async {
                        //   searchList = widget.items
                        //       .where((item) => item
                        //       .trim()
                        //       .toLowerCase()
                        //       .removeDiacritics()
                        //       .contains(keySearch
                        //       .trim()
                        //       .toLowerCase()
                        //       .removeDiacritics()))
                        //       .toList();
                        //   searchItemSubject.sink.add(searchList);
                        // }),
                        Expanded(
                          child:ListView.separated(
                            itemBuilder: (context, index) {
                              final itemTitle = '';
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (selectedItems
                                        .contains(itemTitle)) {
                                      selectedItems
                                          .remove(itemTitle);
                                    } else {
                                      selectedItems
                                          .add(itemTitle);
                                    }
                                  });
                                  widget
                                      .onChange(selectedIndex());
                                  if (widget.onSelectItem !=
                                      null) {
                                    widget.onSelectItem!(index);
                                  }
                                  Navigator.of(context).pop();
                                  // searchItemSubject.close();
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  padding:
                                  const EdgeInsets.symmetric(
                                      vertical: 8),
                                  child: Text(
                                    itemTitle,
                                    style: TextStyle(
                                      color:
                                      const Color(0xff586B8B),
                                      fontWeight: selectedItems
                                          .contains(itemTitle)
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: Color(0xffDBDFEF),
                              );
                            },
                            itemCount:3,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildTagView() {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: _listTag(),
    );
  }

  List<Widget> _listTag() {
    final listWidget = <Widget>[];
    for (int index = 0; index < selectedItems.length; index++) {
      listWidget.add(_buildTagItem(selectedItems[index], index));
    }
    return listWidget;
  }

  Widget _buildTagItem(String content, int index) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffDB353A),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            constraints: BoxConstraints(
              maxWidth: sizeWitdhTag - 60,
            ),
            child: Text(
              content,
              style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 16,color: Colors.white)
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedItems.removeAt(index);
              });
              widget.onChange(selectedIndex());
              if (widget.onRemoveItem != null) {
                widget.onRemoveItem!(widget.items.indexOf(content));
              }
            },
            child: const Icon(
              Icons.close,
              size: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  List<int> selectedIndex() {
    final indexes = <int>[];
    for (final selectedItem in selectedItems) {
      indexes.add(widget.items.indexOf(selectedItem));
    }
    return indexes;
  }

  final GlobalKey keyDiaLog = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      sizeWitdhTag = keyDiaLog.currentContext?.size?.width ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // showBottomSheet(Widgets.context);
        showListItem(widget.context);
      },
      child: Container(
        key: keyDiaLog,
        padding:  EdgeInsets.symmetric(vertical: 18.w, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 0.5, color:AppColor.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: selectedItems.isNotEmpty
            ? _buildTagView()
            : Text('Chọn môn học',style: ThemeText.labelStyle,),
      ),
    );
  }
}
