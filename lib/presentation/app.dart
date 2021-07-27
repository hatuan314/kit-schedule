import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/injector/injector.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/snackbar_type.dart';
import 'package:schedule/presentation/route.dart';
import 'package:schedule/presentation/widget/loader_widget/loader_widget.dart';
import 'package:schedule/presentation/widget/snackbar_widget/snackbar_widget.dart';
import 'bloc/loader_bloc/loader_bloc.dart';
import 'bloc/snackbar_bloc/bloc.dart';
import 'bloc/snackbar_bloc/snackbar_bloc.dart';

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  List<BlocProvider> _getProviders() =>
      [
        BlocProvider<LoaderBloc>(
            create: (context) => Injector.getIt<LoaderBloc>()),
        BlocProvider<SnackbarBloc>(
            create: (context) => Injector.getIt<SnackbarBloc>())
      ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812), //iPhone X size
        builder: () =>
            MultiBlocProvider(
                providers: _getProviders(),
                child: GestureDetector(
                  onTap: () {
                    final currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus &&
                        currentFocus.focusedChild != null) {
                      FocusManager.instance.primaryFocus!.unfocus();
                    }
                  },
                  child: MaterialApp(
                    debugShowCheckedModeBanner: true,
                    navigatorKey: _navigator,
                    builder: (context, widget) =>
                        LoadingContainer(
                            key: const ValueKey('LoadingContainer'),
                            child: _buildBlocListener(
                                widget ?? const SizedBox(), context)),
                    theme: ThemeData(
                      brightness: Brightness.light,
                      primaryColor: Colors.blue[900],
                    ),
                    onGenerateRoute: router(),
                  ),
                )));
  }

  BlocListener<SnackbarBloc, SnackbarState> _buildBlocListener(Widget widget,
      BuildContext context) {
    return BlocListener<SnackbarBloc, SnackbarState>(
      listener: (context, state) {
        if (state is ShowSnackBarState) {
          TopSnackBar(
            title: state.title ?? '',
            type: state.type ?? SnackBarType.success,
            key: state.key,
          ).showWithNavigator(
              _navigator.currentState ?? NavigatorState(), context);
        }
      },
      child: widget,
    );
  }
}