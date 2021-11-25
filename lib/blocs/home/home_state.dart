part of "home_bloc.dart";

abstract class HomeState extends Equatable {
  final MainItem item;
  final bool isSynch;

  HomeState(this.item, [this.isSynch = true]);
}

class HomeInitialState extends HomeState {
  HomeInitialState(MainItem mainItem) : super(mainItem);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class HomeOnChangeTabState extends HomeState {
  HomeOnChangeTabState(MainItem mainItem, bool isSynch)
      : super(mainItem, isSynch);

  List<Object> get props => [this.item];
}

class SignOutSuccessState extends HomeState {
  SignOutSuccessState(MainItem mainItem) : super(mainItem);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SignOutFailureState extends HomeState {
  SignOutFailureState(MainItem mainItem) : super(mainItem);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
