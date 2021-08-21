import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String username;

  ProfileState({required this.username});

  ProfileState update({required String username}) =>
      ProfileState(username: username);

  @override
  // TODO: implement props
  List<Object?> get props => [this.username];
}
