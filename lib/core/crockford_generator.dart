  // Crockford code generator
  import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String generateCrockfordCode() {
    const alphabet = '0123456789ABCDEFGHJKMNPQRSTVWXYZ';
    final random = Random.secure();
    String randomChar() => alphabet[random.nextInt(alphabet.length)];
    final code = List.generate(9, (_) => randomChar()).join();
    return '${code.substring(0, 3)}-${code.substring(3, 6)}';
  }
class CrockfordFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var raw = newValue.text
        .toUpperCase()
        .replaceAll(RegExp(r'[\s-]'), '')
        .replaceAll('O', '0')
        .replaceAll('I', '1')
        .replaceAll('L', '1')
        .replaceAll('U', 'V');

    if (raw.length > 6) {
      raw = raw.substring(0, 6);
    }

    final buffer = StringBuffer();
    for (var i = 0; i < raw.length; i++) {
      buffer.write(raw[i]);
      if (i == 2) buffer.write('-');
    }
    var formatted = buffer.toString();

    int cursorPosition = newValue.selection.baseOffset;
    final isDeleting = oldValue.text.length > newValue.text.length;

    if (isDeleting) {
      if (cursorPosition > 0 &&
          cursorPosition <= formatted.length &&
          formatted[cursorPosition - 1] == '-') {
        formatted = formatted.substring(0, cursorPosition - 1) +
            formatted.substring(cursorPosition);
        cursorPosition--;
      }
    } else {
      if ((raw.length == 4) &&
          formatted.length > oldValue.text.length) {
        cursorPosition++;
      }
    }

    cursorPosition = cursorPosition.clamp(0, formatted.length);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}