import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_entity.dart';

abstract class SavedUsersState extends Equatable {
  const SavedUsersState();

  @override
  List<Object?> get props => [];
}

class SavedUsersInitial extends SavedUsersState {}

class SavedUsersLoading extends SavedUsersState {}

class SavedUsersLoaded extends SavedUsersState {
  final List<UserEntity> users;

  const SavedUsersLoaded({required this.users});

  @override
  List<Object?> get props => [users];
}

class SavedUsersError extends SavedUsersState {
  final String message;

  const SavedUsersError({required this.message});

  @override
  List<Object?> get props => [message];
}

