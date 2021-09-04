import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String username;
  final bool hasNoti;
<<<<<<< HEAD
  final bool? isEnglish;

  ProfileState({required this.username, required this.hasNoti, this.isEnglish});

  ProfileState update({ String? username,bool? hasNoti, bool? isEnglish}) =>
      ProfileState(username: username?? this.username,
      hasNoti: hasNoti?? this.hasNoti,
          isEnglish: isEnglish??this.isEnglish);

  @override
  // TODO: implement props
  List<Object?> get props => [this.username, this.hasNoti,this.hasNoti];
=======

  ProfileState({required this.username, required this.hasNoti});

  ProfileState update({ String? username,bool? hasNoti}) =>
      ProfileState(username: username?? this.username,
      hasNoti: hasNoti?? this.hasNoti);

  @override
  // TODO: implement props
  List<Object?> get props => [this.username, this.hasNoti];
>>>>>>> 1943361b048e8fc37b501065a3f7083f81ce4c74
}
