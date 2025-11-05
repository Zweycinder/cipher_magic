class TopSecretMagic {
  static const List<String> emojiPool = [
    '😀',
    '😃',
    '😄',
    '😁',
    '😆',
    '😅',
    '🤣',
    '😂',
    '🙂',
    '🙃',
    '😉',
    '😊',
    '😇',
    '🥰',
    '😍',
    '🤩',
    '😘',
    '😗',
    '😚',
    '😙',
    '😋',
    '😛',
    '😜',
    '🤪',
    '😝',
    '🤑',
    '🤗',
    '🤭',
    '🤫',
    '🤔',
    '🤐',
    '🤨',
    '😐',
    '😑',
    '😶',
    '😏',
    '😒',
    '🙄',
    '😬',
    '🤥',
    '😌',
    '😔',
    '😪',
    '🤤',
    '😴',
    '😷',
    '🤒',
    '🤕',
    '🤢',
    '🤮',
    '🤧',
    '🥵',
    '🥶',
    '🥴',
    '😵',
    '🤯',
    '🤠',
    '🥳',
    '😎',
    '🤓',
    '🧐',
    '😕',
    '😟',
    '🙁',
    '☹️',
    '😮',
    '😯',
    '😲',
    '😳',
    '🥺',
    '😦',
    '😧',
    '😨',
    '😰',
    '😥',
    '😢',
    '😭',
    '😱',
    '😖',
    '😣',
    '😞',
    '😓',
    '😩',
    '😫',
    '🥱',
    '😤',
    '😡',
    '😠',
    '🤬',
    '😈',
    '👿',
    '💀',
    '☠️',
    '💩',
    '🤡',
    '👹',
    '👺',
    '👻',
    '👽',
    '👾',
    '🤖',
    '🎃',
    '😺',
    '😸',
    '😹',
    '😻',
    '😼',
    '😽',
    '🙀',
    '😿',
    '😾',
    '🐶',
    '🐱',
    '🐭',
    '🐹',
    '🐰',
    '🦊',
    '🐻',
    '🐼',
    '🐨',
    '🐯',
    '🦁',
    '🐮',
    '🐷',
    '🐽',
    '🐸',
    '🐵',
    '🙈',
    '🙉',
    '🙊',
    '🐒',
    '🐔',
    '🐧',
    '🐦',
    '🐤',
    '🐣',
    '🐥',
    '🦆',
    '🦅',
    '🦉',
    '🦇',
    '🐺',
    '🐗',
    '🐴',
    '🦄',
    '🐝',
    '🐛',
    '🦋',
    '🐌',
    '🐞',
    '🐜',
    '🦟',
    '🦗',
    '🕷️',
    '🕸️',
    '🦂',
    '🐢',
    '🐍',
    '🦎',
    '🦖',
    '🦕',
    '🐙',
    '🦑',
    '🦐',
    '🦞',
    '🦀',
    '🐡',
    '🐠',
    '🐟',
    '🐬',
    '🐳',
    '🐋',
    '🦈',
    '🐊',
    '🐅',
    '🐆',
    '🦓',
    '🦍',
    '🦧',
    '🐘',
    '🦛',
    '🦏',
    '🐪',
    '🐫',
    '🦒',
    '🦘',
    '🐃',
    '🐂',
    '🐄',
    '🐎',
    '🐖',
    '🐏',
    '🐑',
    '🦙',
    '🐐',
    '🦌',
    '🐕',
    '🐩',
    '🦮',
    '🐈',
    '🐓',
    '🦃',
    '🦚',
    '🦜',
    '🦢',
    '🦩',
    '🕊️',
    '🐇',
    '🦝',
    '🦨',
    '🦡',
    '🦦',
    '🦥',
    '🐁',
    '🐀',
    '🐿️',
    '🦔',
    '🌵',
    '🎄',
    '🌲',
    '🌳',
    '🌴',
    '🌱',
    '🌿',
    '☘️',
    '🍀',
    '🎍',
    '🎋',
    '🍃',
    '🍂',
    '🍁',
    '🍄',
    '🐚',
    '🌾',
    '💐',
    '🌷',
    '🌹',
    '🥀',
    '🌺',
    '🌸',
    '🌼',
    '🌻',
    '🌞',
    '🌝',
    '🌛',
    '🌜',
    '🌚',
    '🌕',
    '🌖',
    '🌗',
  ];

  static const String charset = 'abcdefghijklmnopqrstuvwxyz';

  String encryptToEmojis(String input, String keyString) {
    String inputLowCase = input.toLowerCase();
    inputLowCase = inputLowCase.replaceAll(' ', '');
    int key = int.parse(keyString);
    String result = '';

    for (int i = 0; i < inputLowCase.length; i++) {
      String char = inputLowCase[i];
      int charIndex = charset.indexOf(char);

      if (charIndex == -1) {
        continue;
      }

      int shiftedIndex = (charIndex + key) % charset.length;
      result += emojiPool[shiftedIndex];
    }

    return result;
  }

  String decryptFromEmojis(String emojiInput, String keyString) {
    int key = int.parse(keyString);
    String result = '';

    List<String> emojis = _parseEmojis(emojiInput);

    for (String emoji in emojis) {
      int emojiIndex = emojiPool.indexOf(emoji);

      if (emojiIndex == -1) {
        continue;
      }

      int originalIndex = (emojiIndex - key) % charset.length;
      if (originalIndex < 0) originalIndex += charset.length;

      result += charset[originalIndex];
    }

    return result;
  }

  List<String> _parseEmojis(String text) {
    List<String> emojis = [];
    for (int i = 0; i < text.length;) {
      int codePoint = text.codeUnitAt(i);

      if (codePoint >= 0xD800 && codePoint <= 0xDBFF && i + 1 < text.length) {
        emojis.add(text.substring(i, i + 2));
        i += 2;

        while (i < text.length) {
          int nextCode = text.codeUnitAt(i);
          if (nextCode == 0xFE0F ||
              (nextCode >= 0xDC00 && nextCode <= 0xDFFF)) {
            emojis[emojis.length - 1] += text[i];
            i++;
          } else {
            break;
          }
        }
      } else {
        emojis.add(text[i]);
        i++;
      }
    }
    return emojis;
  }
}
