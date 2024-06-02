import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:qcarder/cubit/nfc/nfc_state.dart';
import 'package:qcarder/utils/models/nfc_record.dart';

class NfcCubit extends Cubit<NfcState> {
  NfcCubit() : super(NfcUnknown());

  Future<void> handleLockTag(NfcTag tag) async {
    emit(NfcLoading());

    final tech = Ndef.from(tag);

    if (tech == null) {
      emit(NfcFailed('Tag is not ndef'));
      return;
    }

    // Check android-specific property.
    if (tech.additionalData['canMakeReadOnly'] == false) {
      emit(NfcFailed('This operation is not allowed on this tag'));
      return;
    }

    try {
      await tech.writeLock();
      emit(NfcLoaded('[Ndef - Write Lock] is completed'));
    } catch (e) {
      emit(NfcFailed(e.toString()));
    }
  }

  Future<void> handleWriteTag(NfcTag tag, Iterable<WriteRecord> recordList) async {
    final tech = Ndef.from(tag);

    if (tech == null) {
      NfcFailed('Tag is not ndef');
      return;
    }

    if (!tech.isWritable) {
      NfcFailed('Tag is not ndef writable');
      return;
    }

    try {
      final message = NdefMessage(recordList.map((e) => e.record).toList());
      await tech.write(message);
    } catch (e) {
      emit(NfcFailed('Some error has occurred'));
    }

    return emit(NfcLoaded('[Ndef - Write] is completed.'));
  }

  Future<void> handleReadTag(NfcTag tag) async {
    Object? tech;
    final additionalData = {};

    // todo: more additional data
    if (Platform.isIOS) {
      tech = FeliCa.from(tag);
      if (tech is FeliCa) {
        final polling = await tech.polling(
          systemCode: tech.currentSystemCode,
          requestCode: FeliCaPollingRequestCode.noRequest,
          timeSlot: FeliCaPollingTimeSlot.max1,
        );
        additionalData['manufacturerParameter'] = polling.manufacturerParameter;
      }
    }
    emit(NfcLoaded('[Tag - Read] is completed'));
  }
}
