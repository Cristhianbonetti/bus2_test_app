import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_entity.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object?> get props => [];
}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailLoaded extends UserDetailState {
  final UserEntity user;
  final bool isSaved;

  const UserDetailLoaded({
    required this.user,
    required this.isSaved,
  });

  UserDetailLoaded copyWith({
    UserEntity? user,
    bool? isSaved,
  }) {
    return UserDetailLoaded(
      user: user ?? this.user,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [user, isSaved];
}

class UserDetailError extends UserDetailState {
  final String message;

  const UserDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}

class UserDetailSaved extends UserDetailState {
  const UserDetailSaved();
}

class UserDetailDeleted extends UserDetailState {
  const UserDetailDeleted();
}

