import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String username;
  final bool hasNoti;

  ProfileState({required this.username, required this.hasNoti});

  ProfileState update({ String? username,bool? hasNoti}) =>
      ProfileState(username: username?? this.username,
      hasNoti: hasNoti?? this.hasNoti);

  @override
  // TODO: implement props
  List<Object?> get props => [this.username, this.hasNoti];
}
