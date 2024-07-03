import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:my_editor_app/src/features/authentication/presentation/provider/auth_provider.dart';
import 'package:my_editor_app/src/features/authentication/presentation/screen/confirm_otp_screen.dart';
import 'package:my_editor_app/src/features/authentication/presentation/screen/signin_screen.dart';
import 'package:my_editor_app/src/features/authentication/presentation/screen/signup_screen.dart';
import 'package:my_editor_app/src/features/home/presentation/screen/home_scren.dart';
import 'package:my_editor_app/src/features/home/presentation/screen/page_screen.dart';
import 'package:provider/provider.dart';

class RouterHelper {
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      bool res = await context.read<AuthProvider>().isAuthenticated();
      if (!res) {
        return '/signin';
      }
    },
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return FadeTransition(
                opacity:
                    CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              );
            },
          );
        },
        routes: [
          GoRoute(
            path: 'page/:id',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: PageScreen(id: int.parse(state.pathParameters['id']!)),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // Change the opacity of the screen using a Curve based on the the animation's
                  // value
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                },
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/signin',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const SigninScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return FadeTransition(
                opacity:
                    CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
          path: '/signup',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: SignupScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Change the opacity of the screen using a Curve based on the the animation's
                // value
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
            );
          }),
      GoRoute(
          path: '/otp/:email',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: ConfirmOtpScreen(
                email: state.pathParameters['email']!,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Change the opacity of the screen using a Curve based on the the animation's
                // value
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
            );
          }),
    ],
  );
}
