abstract class BannerState {}

class BannerUnknown extends BannerState {}

class BannerLoading extends BannerState {}

class BannerLoaded extends BannerState {
  BannerLoaded();
}

class BannerFailed extends BannerState {
  final Object reason;
  BannerFailed(this.reason);
}
