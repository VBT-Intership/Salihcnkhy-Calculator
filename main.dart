import 'Calculator.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  Calculator calc = new Calculator();
  print("Denklemi giriniz; Örn => 5+2*(10-5)/3");
  var line = stdin.readLineSync(encoding: Encoding.getByName('utf-8'));
  print("Sonuç: " + calc.calculate(line).toString());
}
