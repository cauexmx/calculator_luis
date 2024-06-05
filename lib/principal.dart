import 'dart:math';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override

  final int number = Random().nextInt(10);
  final int number1 = Random().nextInt(10);

  int calculo() {
    int result = 0;
    switch (signal) {
      case 0:
        result = number + number1;
        break;
      case 1:
        result = number - number1;
        break;
    }
    return result;
  }

  List<String> operations = ['+', '-'];
  var signal = Random().nextInt(2);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora do Cauê'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                // Reset calculation (optional)
              },
              icon: IconButton(onPressed: (){
                
              }, 
              icon: Icon(Icons.restore))
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Faça sua operação matemática!'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Número um: $number'),
                Text(operations[signal]),
                Text('Número dois: $number1'),
              ],
            ),
            SizedBox(
              width: 200,
              height: 100,
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Digite o número:',
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                String valor = _controller.text;
                try {
                  int numKey = int.parse(valor);
                  setState(() {
                    if (numKey == calculo()) {
                      showDialog(
                        context: context,
                        builder: (context) => const CongratulationsModal(),
                      );
                      print('Certo');
                      
                    } else {
                      print('Erro');
                       showDialog(
                        context: context,
                        builder: (context) => const IncorrectAnswerModal(),
                      );
                      
                    }
                  });
                } on FormatException {
                  print('Error: Invalid user input');
                }
              },
              icon: const Icon(Icons.play_arrow, color: Colors.red,),
            ),
          
          ],
        ),
      ),
    );
  }
}


class CongratulationsModal extends StatelessWidget {
  const CongratulationsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Parabéns!'),
      content: const Text('Você acertou o resultado da operação!'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}


class IncorrectAnswerModal extends StatelessWidget {
  const IncorrectAnswerModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Resposta Incorreta'),
      content: const Text('Tente novamente'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Fechar'),
        ),
      ],
    );
  }
}