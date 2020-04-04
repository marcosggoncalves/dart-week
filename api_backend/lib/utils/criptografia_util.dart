import 'dart:convert';
import 'package:crypto/crypto.dart';

class CriptografiaUtils{
  static criptografarSenha(String senha){
     // Senha criptografada
    final senhaBytes = utf8.encode(senha);
    return sha256.convert(senhaBytes).toString();
  }
}