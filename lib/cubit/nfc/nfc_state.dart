abstract class NfcState {}

class NfcUnknown extends NfcState {}

class NfcLoading extends NfcState {}

class NfcLoaded extends NfcState {
  final String message;
  NfcLoaded(this.message);
}

class NfcFailed extends NfcState {
  final Object reason;
  NfcFailed(this.reason);
}
