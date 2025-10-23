import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_entity.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object?> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {}

class UserListLoaded extends UserListState {
  final List<UserEntity> users;
  final bool isTickerActive;

  const UserListLoaded({
    required this.users,
    this.isTickerActive = false,
  });

  UserListLoaded copyWith({
    List<UserEntity>? users,
    bool? isTickerActive,
  }) {
    return UserListLoaded(
      users: users ?? this.users,
      isTickerActive: isTickerActive ?? this.isTickerActive,
    );
  }

  @override
  List<Object?> get props => [users, isTickerActive];
}

class UserListError extends UserListState {
  final String message;

  const UserListError({required this.message});

  @override
  List<Object?> get props => [message];
}

