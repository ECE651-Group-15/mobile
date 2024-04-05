import 'dart:math';

class RandomGenerator {
  final Random _random = Random();
  final List<String> _emailDomains = ['example.com', 'mail.com', 'test.org'];
  //final Random random = Random();

  // Generate a random string of [length] using letters and digits
  String generateString(int length) {
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(
        length, (index) => chars[_random.nextInt(chars.length)]).join();
  }
  int number(int range) {
    return _random.nextInt(range);
  }// Generates a number between 0 and 9999
    // Generate a random double between [min] and [max]
    double generateDouble(double min, double max) {
      return _random.nextDouble() * (max - min) + min;
    }

    // Generate a random email address
    String generateEmail() {
      String userName = generateString(10); // Generate a 10 character username
      //String domain = _emailDomains[
      return '$userName@uwaterloo.ca';
    }
  }

