class Transposition {
  String reverseEncryptDecrypt(String input) {
    input = input.replaceAll(' ', '');
    String output = '';
    for (int i = input.length - 1; i >= 0; i--) {
      output += input[i];
    }
    return output;
  }

  String railFenceEncrypt(String input, String key) {
    input = input.replaceAll(' ', '');
    int rails = int.parse(key);
    String output = '';
    int period = 2 * (rails - 1);

    for (int i = 0; i < rails; i++) {
      for (int j = i; j < input.length; j += period) {
        output += input[j];
        if (i != 0 && i != rails - 1) {
          int diagonalIndex = j + period - 2 * i;
          if (diagonalIndex < input.length) {
            output += input[diagonalIndex];
          }
        }
      }
    }

    return output;
  }

  String railFenceDecrypt(String input, String key) {
    input = input.replaceAll(' ', '');
    int rails = int.parse(key);
    int length = input.length;
    int period = 2 * (rails - 1);

    List<String?> output = List.filled(length, null);
    int index = 0;

    for (int i = 0; i < rails; i++) {
      for (int j = i; j < length; j += period) {
        output[j] = input[index++];

        if (i != 0 && i != rails - 1) {
          int diagonalIndex = j + period - 2 * i;
          if (diagonalIndex < length) {
            output[diagonalIndex] = input[index++];
          }
        }
      }
    }

    return output.join('');
  }

  String geometricEncrypt(String input, String key) {
    input = input.replaceAll(' ', '');
    int cols = int.parse(key);
    String output = '';
    int rows = (input.length / cols).ceil();

    List<List<String>> grid = List.generate(rows, (_) => List.filled(cols, ''));

    int index = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (index < input.length) {
          grid[i][j] = input[index++];
        }
      }
    }

    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        if (grid[row][col].isNotEmpty) {
          output += grid[row][col];
        }
      }
    }

    return output;
  }

  String geometricDecrypt(String input, String key) {
    input = input.replaceAll(' ', '');
    int cols = int.parse(key);
    int rows = (input.length / cols).ceil();

    List<List<String>> grid = List.generate(rows, (_) => List.filled(cols, ''));

    int index = 0;
    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        if (index < input.length) {
          grid[row][col] = input[index++];
        }
      }
    }

    String output = '';
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        output += grid[i][j];
      }
    }

    return output;
  }

  String columnarEncrypt(String input, String key) {
    input = input.replaceAll(' ', '');
    int keyLength;
    List<int> columnOrder;

    if (int.tryParse(key) != null) {
      keyLength = int.parse(key);
      columnOrder = List.generate(keyLength, (i) => i);
    } else if (key.split('').every((c) => int.tryParse(c) != null)) {
      keyLength = key.length;
      columnOrder = key.split('').map((c) => int.parse(c) - 1).toList();
    } else {
      keyLength = key.length;
      columnOrder = List.generate(keyLength, (i) => i);
      columnOrder.sort(
        (a, b) => key[a].toLowerCase().compareTo(key[b].toLowerCase()),
      );
    }

    int rows = (input.length / keyLength).ceil();
    String padded = input.padRight(rows * keyLength);

    List<List<String>> grid = List.generate(
      rows,
      (_) => List.filled(keyLength, ''),
    );

    int index = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < keyLength; j++) {
        grid[i][j] = padded[index++];
      }
    }

    String output = '';
    for (int col in columnOrder) {
      for (int row = 0; row < rows; row++) {
        output += grid[row][col];
      }
    }

    return output;
  }

  String columnarDecrypt(String input, String key) {
    input = input.replaceAll(' ', '');
    int keyLength;
    List<int> columnOrder;

    if (int.tryParse(key) != null) {
      keyLength = int.parse(key);
      columnOrder = List.generate(keyLength, (i) => i);
    } else if (key.split('').every((c) => int.tryParse(c) != null)) {
      keyLength = key.length;
      columnOrder = key.split('').map((c) => int.parse(c) - 1).toList();
    } else {
      keyLength = key.length;
      columnOrder = List.generate(keyLength, (i) => i);
      columnOrder.sort(
        (a, b) => key[a].toLowerCase().compareTo(key[b].toLowerCase()),
      );
    }

    int rows = (input.length / keyLength).ceil();

    List<List<String>> grid = List.generate(
      rows,
      (_) => List.filled(keyLength, ''),
    );

    int index = 0;
    for (int col in columnOrder) {
      for (int row = 0; row < rows; row++) {
        grid[row][col] = input[index++];
      }
    }

    String output = '';
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < keyLength; j++) {
        output += grid[i][j];
      }
    }

    return output.trimRight();
  }

  String doubleColumnarEncrypt(String input, String key1, String key2) {
    input = input.replaceAll(' ', '');
    String output = columnarEncrypt(input, key1);
    output = columnarEncrypt(output, key2);
    return output;
  }

  String doubleColumnarDecrypt(String input, String key1, String key2) {
    input = input.replaceAll(' ', '');
    String output = columnarDecrypt(input, key2);
    output = columnarDecrypt(output, key1);
    return output;
  }

  String rowEncrypt(String input, String key) {
    input = input.replaceAll(' ', '');
    List<String> keyOrder = key
        .split('')
        .map((c) => int.tryParse(c) != null ? c : c)
        .toList();
    List<int> rowPermutation;

    if (key.split('').every((c) => int.tryParse(c) != null)) {
      rowPermutation = key.split('').map((c) => int.parse(c) - 1).toList();
    } else {
      rowPermutation = List.generate(key.length, (i) => i);
      rowPermutation.sort(
        (a, b) => key[a].toLowerCase().compareTo(key[b].toLowerCase()),
      );
    }

    int cols = key.length;
    int rows = (input.length / cols).ceil();
    String padded = input.padRight(rows * cols);

    List<List<String>> grid = List.generate(rows, (_) => List.filled(cols, ''));

    int index = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        grid[i][j] = padded[index++];
      }
    }

    String output = '';
    for (int row in rowPermutation) {
      for (int col = 0; col < cols; col++) {
        output += grid[row][col];
      }
    }

    return output;
  }

  String rowDecrypt(String input, String key) {
    input = input.replaceAll(' ', '');
    List<int> rowPermutation;

    if (key.split('').every((c) => int.tryParse(c) != null)) {
      rowPermutation = key.split('').map((c) => int.parse(c) - 1).toList();
    } else {
      rowPermutation = List.generate(key.length, (i) => i);
      rowPermutation.sort(
        (a, b) => key[a].toLowerCase().compareTo(key[b].toLowerCase()),
      );
    }

    int cols = key.length;
    int rows = (input.length / cols).ceil();

    List<List<String>> grid = List.generate(rows, (_) => List.filled(cols, ''));

    int index = 0;
    for (int row in rowPermutation) {
      for (int col = 0; col < cols; col++) {
        grid[row][col] = input[index++];
      }
    }

    String output = '';
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        output += grid[i][j];
      }
    }

    return output.trimRight();
  }

  String nihilistEncrypt(String input, String key) {
    input = input.replaceAll(' ', '');
    int cols = int.parse(key);
    int rows = (input.length / cols).ceil();
    String padded = input.padRight(rows * cols);

    List<List<String>> grid = List.generate(rows, (_) => List.filled(cols, ''));

    int index = 0;
    bool leftToRight = true;
    for (int i = 0; i < rows; i++) {
      if (leftToRight) {
        for (int j = 0; j < cols; j++) {
          grid[i][j] = padded[index++];
        }
      } else {
        for (int j = cols - 1; j >= 0; j--) {
          grid[i][j] = padded[index++];
        }
      }
      leftToRight = !leftToRight;
    }

    String output = '';
    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        output += grid[row][col];
      }
    }

    return output;
  }

  String nihilistDecrypt(String input, String key) {
    input = input.replaceAll(' ', '');
    int cols = int.parse(key);
    int rows = (input.length / cols).ceil();

    List<List<String>> grid = List.generate(rows, (_) => List.filled(cols, ''));

    int index = 0;
    for (int col = 0; col < cols; col++) {
      for (int row = 0; row < rows; row++) {
        grid[row][col] = input[index++];
      }
    }

    String output = '';
    bool leftToRight = true;
    for (int i = 0; i < rows; i++) {
      if (leftToRight) {
        for (int j = 0; j < cols; j++) {
          output += grid[i][j];
        }
      } else {
        for (int j = cols - 1; j >= 0; j--) {
          output += grid[i][j];
        }
      }
      leftToRight = !leftToRight;
    }

    return output.trimRight();
  }
}
