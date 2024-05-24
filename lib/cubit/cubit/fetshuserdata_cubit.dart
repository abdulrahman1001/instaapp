import 'package:bloc/bloc.dart';
import 'package:instaapp/helpermethods/firestoremethos.dart';

import 'package:instaapp/models/usermodel.dart';
import 'package:meta/meta.dart';

part 'fetshuserdata_state.dart';

class FetshuserdataCubit extends Cubit<FetshuserdataState> {
  FetshuserdataCubit() : super(FetshuserdataInitial());

  usermodel? userdata;

  usermodel? getuserdata() {
    return userdata;
  }

  Future<void> fetshuserdata() async {
    emit(FetshuserdataLoading());
    print("Fetching user data...");

    try {
      usermodel user = await FirestoreMethods().getUser();
      userdata = user;
      emit(FetshuserdataLoaded(user));
      print("User data fetched successfully: ${user.email}");
    } catch (e) {
      print("Error fetching user data: $e");
      emit(FetshuserdataError(e.toString()));
    }
  }
}
