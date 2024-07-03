import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:my_editor_app/core/data/usecase/usecase.dart';
import 'package:my_editor_app/src/features/authentication/business/param/confirm_email_param.dart';
import 'package:my_editor_app/src/features/authentication/business/param/sign_in_param.dart';
import 'package:my_editor_app/src/features/authentication/business/param/sign_up_param.dart';
import 'package:my_editor_app/src/features/authentication/business/usecases/confirm_email_with_otp_usecase.dart';
import 'package:my_editor_app/src/features/authentication/business/usecases/get_user_usecase.dart';
import 'package:my_editor_app/src/features/authentication/business/usecases/listen_on_auth_state_change_usecase.dart';
import 'package:my_editor_app/src/features/authentication/business/usecases/sign_out_usecase.dart';
import 'package:my_editor_app/src/features/authentication/business/usecases/signin_with_email_and_password_usecase.dart';
import 'package:my_editor_app/src/features/authentication/business/usecases/signup_with_email_and_password_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider with ChangeNotifier {
  final ConfirmEmailWithOtpUseCase _confirmEmailWithOtpUseCase =
      ConfirmEmailWithOtpUseCase();
  final SignOutUseCase _signOutUseCase = SignOutUseCase();
  final GetUserUseCase _getUserUseCase = GetUserUseCase();
  final SignUpWithEmailAndPasswordUseCase _signUpWithEmailAndPasswordUseCase =
      SignUpWithEmailAndPasswordUseCase();
  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase =
      SignInWithEmailAndPasswordUseCase();
  final ListenOnAuthStateChangeUseCase _listenOnAuthStateChangeUseCase =
      ListenOnAuthStateChangeUseCase();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  void setIsLoggedIn(bool isLoggedIn) {
    _isLoggedIn = isLoggedIn;
    notifyListeners();
  }

  User? _user;
  User? get user => _user;
  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  AuthProvider() {
    getUser();
    print('auth provider');
    print('isLoggedIn : $isLoggedIn');
    print('user : $user');

    listenOnAuthStateChange();
  }

  void signOut() async {
    await _signOutUseCase.call(NoParams());
  }

  Future<bool> isAuthenticated() async {
    bool isAuth = false;
    final res = await _getUserUseCase.call(NoParams());
    res.fold((failure) {
      isAuth = false;
    }, (user) {
      isAuth = true;
    });
    return isAuth;
  }

  void getUser() async {
    final res = await _getUserUseCase.call(NoParams());
    res.fold((failure) {
      print('fail : ${failure.errorMessage}');
      setUser(null);
    }, (user) {
      setUser(user);
    });
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    setIsLoading(true);
    bool isSuccess = false;
    final res = await _signInWithEmailAndPasswordUseCase
        .call(SignInParam(email: email, password: password));
    res.fold((failure) {
      print('fail : ${failure.errorMessage}');
      isSuccess = false;
    }, (isSignedIn) {
      isSuccess = true;
    });
    setIsLoading(false);
    return isSuccess;
  }

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    setIsLoading(true);
    bool isSuccess = false;
    final res = await _signUpWithEmailAndPasswordUseCase
        .call(SignUpParam(email: email, password: password));
    res.fold((failure) {
      print('fail : ${failure.errorMessage}');
      isSuccess = false;
    }, (isSignedIn) {
      isSuccess = true;
    });
    setIsLoading(false);
    return isSuccess;
  }

  Future<bool> confirmEmailWithOtp(
      String email, String otp, OtpType otpType) async {
    print('confirmEmailWithOtp');
    print('email : $email');
    print('otp : $otp');
    print('otpType : $otpType');
    setIsLoading(true);
    bool isSuccess = false;
    final res = await _confirmEmailWithOtpUseCase
        .call(ConfirmEmailParam(email: email, otp: otp, otpType: otpType));
    res.fold((failure) {
      print('fail : ${failure.errorMessage}');
      isSuccess = false;
    }, (isSignedIn) {
      isSuccess = true;
    });
    setIsLoading(false);
    return isSuccess;
  }

  StreamSubscription<AuthState> listenOnAuthStateChange() {
    return _listenOnAuthStateChangeUseCase
        .call(NoParams())
        .listen((AuthState event) {
      print('event : ${event.session?.user}');
      AuthChangeEvent authChangeEvent = event.event;
      switch (authChangeEvent) {
        case AuthChangeEvent.initialSession:
          setIsLoading(false);
          setUser(event.session?.user);
          setIsLoggedIn(true);
          break;
        case AuthChangeEvent.signedIn:
          setIsLoggedIn(true);
          setUser(event.session?.user);

          break;
        case AuthChangeEvent.signedOut:
          setIsLoggedIn(false);
          setUser(event.session?.user);
          break;
        case AuthChangeEvent.passwordRecovery:
          setUser(event.session?.user);
          break;
        case AuthChangeEvent.tokenRefreshed:
          setUser(event.session?.user);
          break;
        case AuthChangeEvent.userUpdated:
          setUser(event.session?.user);
          break;
        case AuthChangeEvent.userDeleted:
          setUser(event.session?.user);
          break;
        case AuthChangeEvent.mfaChallengeVerified:
          setUser(event.session?.user);
          break;
        default:
          break;
      }
    });
  }
}
