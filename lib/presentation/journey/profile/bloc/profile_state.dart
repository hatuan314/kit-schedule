import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String username;
 final bool? isEnglish;
  ProfileState({required this.username,this.isEnglish});

  ProfileState update({required String username,bool? isEnglish}) =>
      ProfileState(username: username,isEnglish: isEnglish??this.isEnglish);

  @override
  // TODO: implement props
  List<Object?> get props => [this.username,this.isEnglish];
}
