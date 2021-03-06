import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_firebase_auth/commen/util/validation/email_validator.dart';
import 'package:flutter_firebase_auth/commen/util/validation/password_validator.dart';
import 'package:flutter_firebase_auth/features/auth/application/services/auth_service.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final AuthService _service;

  LoginCubit(AuthService signInService)
      : _service = signInService,
        super(const LoginState());

  emailChanged(String email) {
    final _email = Email.dirty(email);
    emit(
      state.copyWith(
        email: _email,
        status: Formz.validate([state.password, _email]),
      ),
    );
  }

  passwordChanged(String password) {
    final _password = Password.dirty(password);
    emit(
      state.copyWith(
        password: _password,
        status: Formz.validate([_password, state.email]),
      ),
    );
  }

  visibilityChanged() {
    emit(
      state.copyWith(
        showPassword: !state.showPassword,
      ),
    );
  }

  Future<void> validate() async {
    if (state.status.isValidated) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionInProgress,
          message: '',
        ),
      );
      var _result = await _service.signInWithEmailAndPassword(
        state.email.value,
        state.password.value,
      );
      _result.fold(
        (l) {
          emit(
            state.copyWith(
              status: FormzStatus.submissionFailure,
              message: l.message,
            ),
          );
        },
        (r) {
          emit(
            state.copyWith(
              status: FormzStatus.submissionSuccess,
              message: '',
            ),
          );
        },
      );
    } else {
      emit(
        state.copyWith(
          checkField: true,
          status: FormzStatus.submissionFailure,
          message: 'Check the input',
        ),
      );
    }
  }
}
