class Substitution {
  String _alphabet = 'abcdefghijklmnopqrstuvwxyz';

  String caesarEncrypt(String text, String key) {
    text = text.replaceAll(' ', '').toLowerCase();
    int shift = int.parse(key) % _alphabet.length;
    String result = '';

    for (int i = 0; i < text.length; i++) {
      String ch = text[i];
      int index = _alphabet.indexOf(ch);
      if (index == -1) {
        result += ch;
      } else {
        int newIndex = (index + shift) % _alphabet.length;
        result += _alphabet[newIndex];
      }
    }

    return result;
  }

  String caesarDecrypt(String text, String key) {
    text = text.replaceAll(' ', '').toLowerCase();
    int shift = int.parse(key) % _alphabet.length;
    String result = '';

    for (int i = 0; i < text.length; i++) {
      String ch = text[i];
      int index = _alphabet.indexOf(ch);
      if (index == -1) {
        result += ch;
      } else {
        int newIndex = (index - shift) % _alphabet.length;
        if (newIndex < 0) newIndex += _alphabet.length;
        result += _alphabet[newIndex];
      }
    }

    return result;
  }

  String directStandardEncrypt(String text, String key) {
    text = text.replaceAll(' ', '').toLowerCase();
    int shift = int.parse(key) % _alphabet.length;
    String result = '';

    for (int i = 0; i < text.length; i++) {
      String ch = text[i];
      int index = _alphabet.indexOf(ch);
      if (index == -1) {
        result += ch;
      } else {
        int newIndex = (index + shift) % _alphabet.length;
        result += _alphabet[newIndex];
      }
    }

    return result;
  }

  String directStandardDecrypt(String text, String key) {
    text = text.replaceAll(' ', '').toLowerCase();
    int shift = int.parse(key) % _alphabet.length;
    String result = '';

    for (int i = 0; i < text.length; i++) {
      String ch = text[i];
      int index = _alphabet.indexOf(ch);
      if (index == -1) {
        result += ch;
      } else {
        int newIndex = (index - shift) % _alphabet.length;
        if (newIndex < 0) newIndex += _alphabet.length;
        result += _alphabet[newIndex];
      }
    }

    return result;
  }

  String standardReverseEncrypt(String text, String key) {
    text = text.replaceAll(' ', '').toLowerCase();
    int len = _alphabet.length;
    int shift = int.parse(key) % len;
    String result = '';

    for (int i = 0; i < text.length; i++) {
      String ch = text[i];
      int index = _alphabet.indexOf(ch);

      if (index == -1) {
        result += ch;
      } else {
        int reversedIndex = len - 1 - index;
        int newIndex = (reversedIndex + shift) % len;
        result += _alphabet[newIndex];
      }
    }

    return result;
  }

  String standardReverseDecrypt(String text, String key) {
    text = text.replaceAll(' ', '').toLowerCase();
    int len = _alphabet.length;
    int shift = int.parse(key) % len;
    String result = '';

    for (int i = 0; i < text.length; i++) {
      String ch = text[i];
      int index = _alphabet.indexOf(ch);

      if (index == -1) {
        result += ch;
      } else {
        int reversedIndex = (index - shift) % len;
        if (reversedIndex < 0) reversedIndex += len;
        int originalIndex = len - 1 - reversedIndex;
        result += _alphabet[originalIndex];
      }
    }

    return result;
  }

  String keywordEncrypt(String text, String keyword, String key) {
    text = text.replaceAll(' ', '').toLowerCase();
    final String alphabet = _buildKeywordAlphabet(keyword);
    final int shift = int.parse(key) % _alphabet.length;
    String result = '';

    for (int i = 0; i < text.length; i++) {
      String ch = text[i];
      int indexInStandard = _alphabet.indexOf(ch);

      if (indexInStandard == -1) {
        result += ch;
      } else {
        int newIndex = (indexInStandard + shift) % _alphabet.length;
        result += alphabet[newIndex];
      }
    }

    return result;
  }

  String keywordDecrypt(String text, String keyword, String key) {
    text = text.replaceAll(' ', '').toLowerCase();
    final String alphabet = _buildKeywordAlphabet(keyword);
    final int shift = int.parse(key) % _alphabet.length;
    String result = '';

    for (int i = 0; i < text.length; i++) {
      String ch = text[i];
      int indexInKeyword = alphabet.indexOf(ch);

      if (indexInKeyword == -1) {
        result += ch;
      } else {
        int originalIndex = (indexInKeyword - shift) % _alphabet.length;
        if (originalIndex < 0) originalIndex += _alphabet.length;
        result += _alphabet[originalIndex];
      }
    }

    return result;
  }

  String multiplicativeEncrypt(String input, String key) {
    input = input.replaceAll(' ', '').toLowerCase();
    final int len = _alphabet.length;
    int k = int.parse(key) % len;

    if (_gcd(k, len) != 1) {
      throw Exception(
        'Invalid key: gcd(key, $len) != 1, cipher not invertible.',
      );
    }

    final StringBuffer result = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      final String ch = input[i];
      final int index = _alphabet.indexOf(ch);

      if (index == -1) {
        result.write(ch);
      } else {
        final int newIndex = (index * k) % len;
        result.write(_alphabet[newIndex]);
      }
    }

    return result.toString();
  }

  String multiplicativeDecrypt(String input, String key) {
    input = input.replaceAll(' ', '').toLowerCase();
    final int len = _alphabet.length;
    int k = int.parse(key) % len;

    if (_gcd(k, len) != 1) {
      throw Exception(
        'Invalid key: gcd(key, $len) != 1, cipher not invertible.',
      );
    }
    final int invKey = _modInverse(k, len);

    final StringBuffer result = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      final String ch = input[i];
      final int index = _alphabet.indexOf(ch);

      if (index == -1) {
        result.write(ch);
      } else {
        final int originalIndex = (index * invKey) % len;
        result.write(_alphabet[originalIndex]);
      }
    }

    return result.toString();
  }

  String affineEncrypt(String input, String keyA, String keyB) {
    input = input.replaceAll(' ', '').toLowerCase();
    final int len = _alphabet.length;
    int a = int.parse(keyA) % len;
    int b = int.parse(keyB) % len;

    if (_gcd(a, len) != 1) {
      throw Exception(
        'Invalid key A: gcd(keyA, $len) != 1, cipher not invertible.',
      );
    }

    final StringBuffer result = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      final String ch = input[i];
      final int index = _alphabet.indexOf(ch);

      if (index == -1) {
        result.write(ch);
      } else {
        final int newIndex = (a * index + b) % len;
        result.write(_alphabet[newIndex]);
      }
    }

    return result.toString();
  }

  String affineDecrypt(String input, String keyA, String keyB) {
    input = input.replaceAll(' ', '').toLowerCase();
    final int len = _alphabet.length;
    int a = int.parse(keyA) % len;
    int b = int.parse(keyB) % len;

    if (_gcd(a, len) != 1) {
      throw Exception(
        'Invalid key A: gcd(keyA, $len) != 1, cipher not invertible.',
      );
    }

    final int invA = _modInverse(a, len);
    final StringBuffer result = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      final String ch = input[i];
      final int index = _alphabet.indexOf(ch);

      if (index == -1) {
        result.write(ch);
      } else {
        int originalIndex = (invA * (index - b)) % len;
        if (originalIndex < 0) originalIndex += len;
        result.write(_alphabet[originalIndex]);
      }
    }

    return result.toString();
  }

  String playfairEncrypt(String text, String keyword) {
    text = text.replaceAll(' ', '').toLowerCase();
    keyword = keyword.toLowerCase();

    List<List<String>> matrix = _buildPlayfairMatrix(keyword);
    Map<String, List<int>> positions = _getCharPositions(matrix);

    text = text.replaceAll('j', 'i');
    List<String> pairs = _createPairs(text);

    String result = '';

    for (String pair in pairs) {
      String first = pair[0];
      String second = pair[1];

      List<int> pos1 = positions[first]!;
      List<int> pos2 = positions[second]!;

      int row1 = pos1[0], col1 = pos1[1];
      int row2 = pos2[0], col2 = pos2[1];

      if (row1 == row2) {
        result += matrix[row1][(col1 + 1) % 5];
        result += matrix[row2][(col2 + 1) % 5];
      } else if (col1 == col2) {
        result += matrix[(row1 + 1) % 5][col1];
        result += matrix[(row2 + 1) % 5][col2];
      } else {
        result += matrix[row1][col2];
        result += matrix[row2][col1];
      }
    }

    return result;
  }

  String playfairDecrypt(String text, String keyword) {
    text = text.replaceAll(' ', '').toLowerCase();
    keyword = keyword.toLowerCase();

    List<List<String>> matrix = _buildPlayfairMatrix(keyword);
    Map<String, List<int>> positions = _getCharPositions(matrix);

    List<String> pairs = [];
    for (int i = 0; i < text.length; i += 2) {
      pairs.add(text.substring(i, i + 2));
    }

    String result = '';

    for (String pair in pairs) {
      String first = pair[0];
      String second = pair[1];

      List<int> pos1 = positions[first]!;
      List<int> pos2 = positions[second]!;

      int row1 = pos1[0], col1 = pos1[1];
      int row2 = pos2[0], col2 = pos2[1];

      if (row1 == row2) {
        result += matrix[row1][(col1 - 1 + 5) % 5];
        result += matrix[row2][(col2 - 1 + 5) % 5];
      } else if (col1 == col2) {
        result += matrix[(row1 - 1 + 5) % 5][col1];
        result += matrix[(row2 - 1 + 5) % 5][col2];
      } else {
        result += matrix[row1][col2];
        result += matrix[row2][col1];
      }
    }

    return result.replaceAll('x', '');
  }

  List<List<String>> _buildPlayfairMatrix(String keyword) {
    String alphabet = 'abcdefghiklmnopqrstuvwxyz';
    Set<String> seen = {};
    String matrixString = '';

    for (int i = 0; i < keyword.length; i++) {
      String ch = keyword[i];
      if (ch == 'j') ch = 'i';
      if (alphabet.contains(ch) && !seen.contains(ch)) {
        seen.add(ch);
        matrixString += ch;
      }
    }

    for (int i = 0; i < alphabet.length; i++) {
      String ch = alphabet[i];
      if (!seen.contains(ch)) {
        seen.add(ch);
        matrixString += ch;
      }
    }

    List<List<String>> matrix = [];
    for (int i = 0; i < 5; i++) {
      matrix.add(matrixString.substring(i * 5, (i + 1) * 5).split(''));
    }

    return matrix;
  }

  Map<String, List<int>> _getCharPositions(List<List<String>> matrix) {
    Map<String, List<int>> positions = {};
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        positions[matrix[i][j]] = [i, j];
      }
    }
    return positions;
  }

  List<String> _createPairs(String text) {
    List<String> pairs = [];
    int i = 0;

    while (i < text.length) {
      String first = text[i];
      String second;

      if (i + 1 < text.length) {
        second = text[i + 1];
        if (first == second) {
          second = 'x';
          i++;
        } else {
          i += 2;
        }
      } else {
        second = 'x';
        i++;
      }

      pairs.add(first + second);
    }

    return pairs;
  }

  String _buildKeywordAlphabet(String keyword) {
    keyword = keyword.toLowerCase();

    final StringBuffer buf = StringBuffer();
    final Set<String> seen = {};

    for (int i = 0; i < keyword.length; i++) {
      final String ch = keyword[i];
      if (_alphabet.contains(ch) && !seen.contains(ch)) {
        seen.add(ch);
        buf.write(ch);
      }
    }

    for (int i = 0; i < _alphabet.length; i++) {
      final String ch = _alphabet[i];
      if (!seen.contains(ch)) {
        seen.add(ch);
        buf.write(ch);
      }
    }

    return buf.toString();
  }

  int _gcd(int a, int b) {
    while (b != 0) {
      final int t = b;
      b = a % b;
      a = t;
    }
    return a.abs();
  }

  int _modInverse(int a, int m) {
    a = a % m;
    for (int x = 1; x < m; x++) {
      if ((a * x) % m == 1) return x;
    }
    throw Exception('Key has no multiplicative inverse modulo $m (gcd != 1).');
  }
}
