import 'package:encrypt/encrypt.dart';
import 'package:password/password.dart';

final length = 32;

class MessageEncrypter
{
  Key passkey;
  Key textkey;
  IV iv;

  /// Initializes the original MessageEncrypter from just a password.
  MessageEncrypter(String password)
  {
    passkey = _generateKeyFromPassword(password);
    textkey = _generateTextEncryptingKey();
    iv = IV.fromLength(16);
  }

  /// Initializes a MessageEncrypter for the recipient after the original is generated.
  /// Pass it the password of the recipient and the textKey and ivText strings.
  MessageEncrypter.forReceiver(String password, String keyData, String ivData)
  {
    passkey = _generateKeyFromPassword(password);
    textkey = Key.fromBase64(keyData);
    iv = IV.fromBase64(ivData);
  }

  /// Retrieves a MessageEncrypter from a string.
  MessageEncrypter.rehydrate(String password, String retrievedData)
  {
    passkey = _generateKeyFromPassword(password);

    var textkeyAndIv = _decodeRetrieved(retrievedData);
    var encryptedKey = textkeyAndIv[0];
    iv = textkeyAndIv[1];

    var keyDecrypter = Encrypter(AES(passkey));
    var decrypted = keyDecrypter.decrypt(encryptedKey, iv: iv);

    textkey = Key.fromBase64(decrypted);
  }

  /// Generates a Key for encrypting messages.
  /// Only should be called by the MessageEncrypter constructor.
  Key _generateTextEncryptingKey()
  {
    final key = Key.fromSecureRandom(length);

    return key;
  }

  /// Generates a Key for encrypting the above key, using the user's password as a seed.
  Key _generateKeyFromPassword(String password)
  {
    final hash = Password.hash(password, PBKDF2());
    final key = Key.fromUtf8(hash.substring(0, length));

    return key;
  }
  
  /// Breaks a string (must come in the format of "keyText,iv") into usable data.
  List _decodeRetrieved(String data)
  {
    List<String> args;
    
    args = data.split(',');

    var keyText = Encrypted.fromBase64(args[0]);
    var iv = IV.fromBase64(args[1]);

    return [keyText, iv];
  }

  /// Encrypts text using the text key
  String encrypt(String text)
  {
    var encrypter = Encrypter(AES(textkey));

    return encrypter.encrypt(text, iv: iv).base64;
  }

  /// Decrypts a cipher using the text key
  String decrypt(String cipher)
  {
    var decrypter = Encrypter(AES(textkey));

    return decrypter.decrypt(Encrypted.fromBase64(cipher), iv: iv);
  }

  /// Turns the textkey and the iv into "keyText,iv" format, encrypted by the user's password.
  String encodeData()
  {
    var encrypter = Encrypter(AES(passkey));
    var encryptedKey = encrypter.encrypt(textkey.base64, iv: iv);

    return encryptedKey.base64 + ',' + iv.base64;
  }

  String get passKey  => passkey.base64;
  String get textKey  => textkey.base64;
  String get ivText   => iv.base64;
}