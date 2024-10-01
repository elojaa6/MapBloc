import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text('Espere por favor'),
              content: Container(
                width: 100.0,
                height: 100.0,
                margin: const EdgeInsets.only(top: 10.0),
                child: const Column(
                  children: [
                    Text('Calculando ruta'),
                    SizedBox(height: 15.0),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            ));
    return;
  }

  showCupertinoDialog(
    context: context,
    builder: (context) => const CupertinoAlertDialog(
      title: Text('Espere por favor'),
      content: CupertinoActivityIndicator(),
    ),
  );
}
