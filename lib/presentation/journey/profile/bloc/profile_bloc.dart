import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/presentation/journey/profile/bloc/profile_event.dart';
import 'package:schedule/presentation/journey/profile/bloc/profile_state.dart';
import 'package:schedule/service/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  ProfileBloc(  ) : super(ProfileState(username: ''));

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async*{
    if(event is GetUserNameEvent)
      //(await ShareService().getUsername() as String)
     yield state.update(username:(await ShareService().getUsername() as String) );
   if(event is ChangeLanguageEvent){

   }
  }

}