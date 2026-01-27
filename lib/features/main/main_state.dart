import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  final int currentPage;

  const MainState({required this.currentPage});

  MainState copyWith({int? currentPage}) {
    return MainState(currentPage: currentPage ?? this.currentPage);
  }

  @override
  List<Object?> get props => [currentPage];
}
