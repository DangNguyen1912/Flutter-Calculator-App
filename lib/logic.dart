List<String> history = [];
String display = '';
String operand1 = '';
String operator = '';
String operand2 = '';
String result = '';

String lastOperator = '';
String lastOperand2 = '';

void delete() {
  history = [];
  display = '';
  operand1 = '';
  operator = '';
  operand2 = '';
  result = '';
  lastOperator = '';
  lastOperand2 = '';
}

void backspace() {
  operator.isEmpty
      ? operand1 = operand1.substring(0, operand1.length - 1)
      : operand2 = operand2.substring(0, operand2.length - 1);
  if (result.isNotEmpty) {
    operand1 = '';
    operator = '';
    operand2 = '';
    result = '';
  }
  updateDisplay();
}

void toggleSign() {
  operand2.isEmpty
      ? operand1.contains('-')
            ? operand1 = operand1.substring(1)
            : operand1 = '-$operand1'
      : operand2.contains('-')
      ? operand2 = operand2.substring(1)
      : operand2 = '-$operand2';
  updateDisplay();
}

void percentage() {
  equal(true);
}

void equal([bool percentage = false]) {
  switch (operator) {
    case '+':
      result = '${double.parse(operand1) + double.parse(operand2)}';
    case '-':
      result = '${double.parse(operand1) - double.parse(operand2)}';
    case '*':
      result = '${double.parse(operand1) * double.parse(operand2)}';
    case '÷':
      result = '${double.parse(operand1) / double.parse(operand2)}';
    case '':
      if (lastOperator.isEmpty) {
        result = operand1;
      } else {
        operator = lastOperator;
        operand2 = lastOperand2;
        switch (operator) {
          case '+':
            result = '${double.parse(operand1) + double.parse(operand2)}';
          case '-':
            result = '${double.parse(operand1) - double.parse(operand2)}';
          case '*':
            result = '${double.parse(operand1) * double.parse(operand2)}';
          case '÷':
            result = '${double.parse(operand1) / double.parse(operand2)}';
        }
      }
  }
  if (operand1.isNotEmpty && percentage) {
    result = '${double.parse(result) / 100}';
  }
  if (result.endsWith('.0')) {
    result = result.substring(0, result.length - 2);
  }
  updateDisplay();
  if (percentage) {
    List<String> temp = display.split(' = ');
    display = '(${temp[0]})% = ${temp[1]}';
    history.add(display);
  } else {
    history.add(display);
  }
  operand1 = result;
  lastOperator = operator;
  lastOperand2 = operand2;
  operator = '';
  operand2 = '';
  result = '';
  updateDisplay();
}

void addition() {
  if (operand1.isNotEmpty && operand2.isEmpty) {
    operator = '+';
  }
  if (operand1.isNotEmpty && operand2.isNotEmpty) {
    operand1 = '${double.parse(operand1) + double.parse(operand2)}';
    operand2 = '';
    operator = '+';
  }
  updateDisplay();
}

void subtraction() {
  if (operand1.isNotEmpty && operand2.isEmpty) {
    operator = '-';
  }
  if (operand1.isNotEmpty && operand2.isNotEmpty) {
    operand1 = '${double.parse(operand1) - double.parse(operand2)}';
    operand2 = '';
    operator = '-';
  }
  updateDisplay();
}

void multiplication() {
  if (operand1.isNotEmpty && operand2.isEmpty) {
    operator = '*';
  }
  if (operand1.isNotEmpty && operand2.isNotEmpty) {
    operand1 = '${double.parse(operand1) * double.parse(operand2)}';
    operand2 = '';
    operator = '*';
  }
  updateDisplay();
}

void division() {
  if (operand1.isNotEmpty && operand2.isEmpty) {
    operator = '÷';
  }
  if (operand1.isNotEmpty && operand2.isNotEmpty) {
    operand1 = '${double.parse(operand1) / double.parse(operand2)}';
    operand2 = '';
    operator = '÷';
  }
  updateDisplay();
}

void number(int number) {
  if (operator.isEmpty) {
    operand1 = '$operand1$number';
  } else {
    operand2 = '$operand2$number';
  }
  updateDisplay();
}

void decimal() {
  operator
          .isEmpty // true: edit operand1 // false: edit operand2
      ? operand1.contains(
              '.',
            ) // true: have decimal // false: not have decimal, add decimal
            ? operand1.endsWith(
                    '.',
                  ) // true: decimal at last, erase decimal // false: null
                  ? operand1 = operand1
                        .substring(0, operand1.length - 1) // erase decimal
                  : null
            : operand1 =
                  '$operand1.' // add decimal
      : operand2.contains('.')
      ? operand2.endsWith('.')
            ? operand2 = operand2.substring(0, operand2.length - 1)
            : null
      : operand2 = '$operand2.';
  updateDisplay();
}

void updateDisplay() {
  display =
      '$operand1${operator.isNotEmpty ? ' $operator${operand2.isNotEmpty ? ' $operand2' : ' _'}' : ''}${result.isNotEmpty ? ' = $result' : ''}';
}
