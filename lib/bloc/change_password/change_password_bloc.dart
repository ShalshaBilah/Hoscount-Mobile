import 'package:bloc/bloc.dart';
import 'package:hoscountmobile/data/model/requests/password_model.dart';
import 'package:meta/meta.dart';

import '../../data/datasources/auth_datasources.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final AuthDatasource authDatasource;

  ChangePasswordBloc(this.authDatasource) : super(ChangePasswordInitial()) {
    on<ChangePasswordEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is ChangePassword) {
        emit(ChangePasswordLoading());
        try {
          await authDatasource.changePassword(event.passwordModel);
          emit(ChangePasswordSuccess());
        } catch (e) {
          emit(ChangePasswordFailure(e.toString()));
        }
      }
    });
  }
}
