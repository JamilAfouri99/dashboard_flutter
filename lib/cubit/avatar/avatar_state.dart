abstract class AvatarState {}

class AvatarUnknown extends AvatarState {}

class AvatarLoading extends AvatarState {}

class AvatarLoaded extends AvatarState {
  AvatarLoaded();
}

class AvatarFailed extends AvatarState {
  final Object reason;
  AvatarFailed(this.reason);
}
