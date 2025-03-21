import 'package:flutter_bloc/flutter_bloc.dart';
/// BlocObserver is a class that can observe the behavior of all Blocs and Cubits in the application.
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('${bloc.runtimeType} Created!');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('$bloc Changed - $change');
  }
}
