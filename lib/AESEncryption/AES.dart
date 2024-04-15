import 'package:encrypt/encrypt.dart';

class AESEncryption{


  AESEncryption();
  //static final key = Key.fromLength(16);
  //static final iv = IV.fromLength(16);
  //static final encrypter = Encrypter(AES(key));
    static final iv = IV.fromUtf8('e16ce888a20dadb8');

  encryptMsgpass(String text, String input){
    if (input.length < 16) {
      input = input.padRight(16, '0'); // If input is less than 32 chars, pad it with '0'
    } else if (input.length > 16) {
      input = input.substring(0, 16); // If input is more than 32 chars, truncate it
    }
     Key password = Key.fromUtf8(input);
    Encrypter encrypter = Encrypter(AES(password));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
    }

  static String decryptMsgpass(Encrypted text, String input){ 
    if (input.length < 16) {
      input = input.padRight(16, '0'); // If input is less than 32 chars, pad it with '0'
    } else if (input.length > 16) {
      input = input.substring(0, 16); // If input is more than 32 chars, truncate it
    }
    Key password = Key.fromUtf8(input);
    Encrypter encrypter = Encrypter(AES(password));

    final decrypted= encrypter.decrypt(text, iv: iv);
    return decrypted;
  }

    //getPassCode(String encoded) => Encrypted.fromBase64(encoded);


  //static final encrypter = Encrypter(AES(key));

  // encryptMsg(String text)=> encrypter.encrypt(text, iv: iv);

  // decryptMsg(Encrypted text)=> encrypter.decrypt(text, iv: iv);

  // getCode(String encoded) => Encrypted.fromBase16(encoded);

  // // encryptMsg(String msg){
  // //   final encrypted = encrypter.encrypt(msg, iv: iv);
  // //   return encrypted.base64;
  // // }

  // passMSG(String msg){
  //   final encrypted = encrypter.encrypt(msg, iv: iv);
  //   return encrypted.base64;
  // }

  // // static final key = Key.fromUtf8('my 32 length key................');
  // // static final iv = IV.fromLength(16);

  // // static final encrypter = Encrypter(AES(key));


  // // static String encrypt(String text){
  // //   final encrypted = encrypter.encrypt(text, iv: iv);
  // //   return encrypted.base64;
  // // }

  // // static String decrypt(String text){
  // //   final decrypted = encrypter.decrypt(text, iv: iv);
  // //   return decrypted;
  // // }

  // static String encryptPass(String text, String input){
  //   final encrypted = encrypter.encrypt(text, iv: iv);
  //   return encrypted.base64;
  // }

  // static String decryptPass(String text, String input){
  //   final decrypted = encrypter.decrypt64(text, iv: iv);
  //   return decrypted;
  // }

  static Encrypted getPassCode(String encoded){ Encrypted.fromBase16(encoded);
  return Encrypted.fromBase16(encoded);}

  

}