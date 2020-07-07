//import 'package:tuple/tuple.dart';

import 'dart:collection';

class Indexes {
  int start;
  int end;
  Indexes({this.start, this.end});
}

class Calculator {
  double calculate(String value) {
    value = value.replaceAll(' ', "");

    var values = value.codeUnits.map((unit) {
      return new String.fromCharCode(unit);
    }).toList();
    for (var i = 0; i < values.length; i++) {
      var char = values[i];
      var temp_char = "";

      while (char.contains(new RegExp(r"[0-9]"))) {
        temp_char += char;

        i++;
        if (i < values.length) {
          char = values[i];
        } else {
          break;
        }
      }

      if (temp_char.length > 1) {
        values.removeRange(i - temp_char.length, i);
        values.insert(i - temp_char.length, temp_char);
      }
    }
    _findParentheses(values);
    _calc(values);
    var answer = double.tryParse(values.first);
    if (answer != null && values.length == 1) {
      return answer;
    } else {
      return double.infinity;
    }
  }

  void _findParentheses(List<String> values) {
    //you should use tuple. TODO: Change this

    List<Indexes> indexes = new List();
    bool searching = false;
    int p_count = 0;
    int last_search_s_index = 0;
    for (var i = 0; i < values.length; i++) {
      var char = values[i];

      if (char == "(" && !searching) {
        indexes.add(new Indexes(start: i));
        last_search_s_index = i;
        searching = true;
      } else if (char == "(" && searching) {
        p_count++;
      } else if (char == ")" && p_count != 0) {
        p_count--;
      } else if (char == ")" && p_count == 0 && searching) {
        indexes.last.end = i;
        i = last_search_s_index;
        searching = false;
      }
      // print("deger: " +
      //     values[i] +
      //     " i:" +
      //     i.toString() +
      //     " isSearching: " +
      //     searching.toString());
    }
    // for (var index in indexes) {
    //   print(index.start.toString() + " " + index.end.toString());
    // }
    for (var i = 0; i <= indexes.length - 1; i++) {
      var index = indexes[i];
      Queue<Indexes> calc_queue = new Queue();
      calc_queue.add(index);
      for (var j = i + 1; j < indexes.length; j++) {
        var next_index = indexes[j];

        if (index.start < next_index.start && index.end > next_index.end) {
          index = next_index;
          calc_queue.add(index);
          i++;

          // print("Added to stack => " +
          //     index.start.toString() +
          //     " " +
          //     index.end.toString());
        }
      }
      var last = calc_queue.removeLast();
      var it = values.getRange(last.start + 1, last.end);
      var inside_parentheses = _calc(it.toList());
      values.removeRange(last.start, last.end + 1);
      values.insert(last.start, inside_parentheses);
    }
  }

  String _calc(List<String> values) {
    for (var i = 0; i < values.length; i++) {
      var char = values[i];

      if (char == "*") {
        //  print(values[i - 1] + " * " + values[i + 1]);
        var value =
            double.tryParse(values[i - 1]) * double.tryParse(values[i + 1]);
        values.removeRange(i - 1, i + 2);
        values.insert(i - 1, value.toString());
        i--;
      } else if (char == "/") {
        // print(values[i - 1] + " / " + values[i + 1]);

        var value =
            double.tryParse(values[i - 1]) / double.tryParse(values[i + 1]);
        values.removeRange(i - 1, i + 2);
        values.insert(i - 1, value.toString());
        i--;
      }
    }
    for (var i = 0; i < values.length; i++) {
      var char = values[i];
      if (char == "+") {
        //print(values[i - 1] + " + " + values[i + 1]);
        var value =
            double.tryParse(values[i - 1]) + double.tryParse(values[i + 1]);
        values.removeRange(i - 1, i + 2);
        values.insert(i - 1, value.toString());
        i--;
      } else if (char == "-") {
        // print(values[i - 1] + " - " + values[i + 1]);
        var value =
            double.tryParse(values[i - 1]) - double.tryParse(values[i + 1]);
        values.removeRange(i - 1, i + 2);
        values.insert(i - 1, value.toString());
        i--;
      }
    }
    // print(values);
    if (values.length == 1) {
      return values.first;
    } else {
      print("Something went wrong!!");
    }
  }
}
