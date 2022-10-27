import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/config/local_config.dart';
import 'package:schedule/common/constants/key_constants.dart';
import 'package:schedule/common/injector/injector.dart';
import 'package:schedule/l10n/l10n.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/snackbar_type.dart';
import 'package:schedule/presentation/route.dart';
import 'package:schedule/presentation/widget/loader_widget/loader_widget.dart';
import 'package:schedule/presentation/widget/snackbar_widget/snackbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import ' language_select/ language_select.dart';
import 'bloc/loader_bloc/loader_bloc.dart';
import 'bloc/snackbar_bloc/bloc.dart';

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();

  List<BlocProvider> _getProviders() => [
        BlocProvider<LoaderBloc>(
            create: (context) => Injector.getIt<LoaderBloc>()),
        BlocProvider<SnackbarBloc>(
            create: (context) => Injector.getIt<SnackbarBloc>())
      ];

  @override
  void initState() {
    Injector.getIt<LanguageSelect>().addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    bool? isEng = widget.prefs.getBool(KeyConstants.language);
    bool isEnglish() {
      if (AppLocalizations.of(context)?.localeName == 'en') {
        return true;
      }
      return false;
    }

    if (isEng == null) {
      LanguageSelect.isEnglish = isEnglish();
    } else {
      LanguageSelect.isEnglish = isEng;
      if (isEng) {
        LanguageSelect.locale = Locale('en');
      } else {
        LanguageSelect.locale = Locale('vi');
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812), //iPhone X size
        builder: (context, child) => MultiBlocProvider(
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
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                locale: LanguageSelect.locale,
                supportedLocales: L10n.all,
                debugShowCheckedModeBanner: true,
                navigatorKey: _navigator,
                builder: (context, widget) => LoadingContainer(
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

  BlocListener<SnackbarBloc, SnackbarState> _buildBlocListener(
      Widget widget, BuildContext context) {
    return BlocListener<SnackbarBloc, SnackbarState>(
      listener: (context, state) {
        if (state is ShowSnackBarState) {
          TopSnackBar(
            title: titleTopSnackBar(state, context),
            type: state.type ?? SnackBarType.success,
            key: state.key,
          ).showWithNavigator(
              _navigator.currentState ?? NavigatorState(), context);
        }
      },
      child: widget,
    );
  }

  String titleTopSnackBar(ShowSnackBarState state, BuildContext context) {
    String title = '';
    if (state.title == '${SnackBarTitle.CreateSuccess}') {
      title = AppLocalizations.of(context)!.createSuccess;
    } else if (state.title == '${SnackBarTitle.CreateFailed}') {
      title = AppLocalizations.of(context)!.createFailed;
    } else if (state.title == '${SnackBarTitle.NoData}') {
      title = AppLocalizations.of(context)!.dataTryAgain;
    } else if (state.title == '${SnackBarTitle.ConnectionFailed}') {
      title = AppLocalizations.of(context)!.connectionFailed;
    }
    return title;
  }

  @override
  void dispose() {
    Injector.getIt<LocalConfig>().dispose();
    super.dispose();
  }
}
