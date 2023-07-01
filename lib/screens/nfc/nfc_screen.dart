import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NfcScreenState();
}

class NfcScreenState extends State<NfcScreen> {
  ValueNotifier<dynamic> result = ValueNotifier(null);

  static const platform = MethodChannel('qcarder/nfc');

  String _nfcStatus = 'NFC Emulation Inactive';

  Future<void> _startNFCEmulation() async {
    try {
      final result = await platform.invokeMethod('startNFCEmulation');
      setState(() {
        _nfcStatus = result;
      });
    } on PlatformException catch (e) {
      setState(() {
        _nfcStatus = 'Error: ${e.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log('************************************************************************************');
    log(_nfcStatus);
    log('***********************************************************************************');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('NfcManager Plugin Example')),
        body: SafeArea(
          child: FutureBuilder<bool>(
            future: NfcManager.instance.isAvailable(),
            builder: (context, ss) => ss.data != true
                ? Center(child: Text('NfcManager.isAvailable(): ${ss.data}'))
                : Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.vertical,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.all(4),
                          constraints: BoxConstraints.expand(),
                          decoration: BoxDecoration(border: Border.all()),
                          child: SingleChildScrollView(
                            child: ValueListenableBuilder<dynamic>(
                              valueListenable: result,
                              builder: (context, value, _) => Text('${value ?? ''}'),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: GridView.count(
                          padding: EdgeInsets.all(4),
                          crossAxisCount: 2,
                          childAspectRatio: 4,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          children: [
                            ElevatedButton(child: Text('Tag Read'), onPressed: _tagRead),
                            ElevatedButton(child: Text('Ndef Write'), onPressed: _ndefWrite),
                            ElevatedButton(
                                child: Text('Ndef Write Lock'), onPressed: _ndefWriteLock),
                            ElevatedButton(
                                child: Text('Native NFC'), onPressed: _startNFCEmulation),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      // Extract identifier from isodep
      result.value = tag.data;
      NfcManager.instance.stopSession();
    });
  }

  String bytesToString(List<int> bytes) {
    return utf8.decode(bytes);
  }

  void _ndefWrite() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: result.value);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createText('Jamil Afouri'),
        NdefRecord.createUri(Uri.parse('https://www.facebook.com/jamelhesham/')),
        NdefRecord.createMime('text/plain', Uint8List.fromList('Hello'.codeUnits)),
        NdefRecord.createExternal(
          'https://www.facebook.com/jamelhesham/',
          'mytype',
          Uint8List.fromList('mydata'.codeUnits),
        ),
      ]);

      try {
        await ndef.write(message);
        result.value = 'Success to "Ndef Write"';
        NfcManager.instance.stopSession();
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }

  void _ndefWriteLock() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null) {
        result.value = 'Tag is not ndef';
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }

      try {
        await ndef.writeLock();
        result.value = 'Success to "Ndef Write Lock"';
        NfcManager.instance.stopSession();
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }
}
