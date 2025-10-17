  // Crockford code generator
  import 'dart:math';

String generateCrockfordCode() {
    const alphabet = '0123456789ABCDEFGHJKMNPQRSTVWXYZ';
    final random = Random.secure();
    String randomChar() => alphabet[random.nextInt(alphabet.length)];
    final code = List.generate(9, (_) => randomChar()).join();
    return '${code.substring(0, 3)}';
  }
