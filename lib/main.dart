import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = "Informe os seus dados!";

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";

      _infoText = "Informe os seus dados!";
      _formkey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);

      double imc = weight / (height * height);
      print(imc);

      if (imc < 18.5) {
        _infoText =
            "O seu IMC é de ${imc.toStringAsPrecision(4)}. Você está abaixo do peso!";
      } else if (imc >= 18.5 && imc <= 24.9) {
        _infoText =
            "Parabéns! O seu IMC está normal, com o indice de ${imc.toStringAsPrecision(4)}.";
      } else if (imc >= 25 && imc <= 29.9) {
        _infoText =
            "O seu IMC é de ${imc.toStringAsPrecision(4)}. Você está com Sobrepeso!";
      } else if (imc >= 30 && imc <= 34.9) {
        _infoText =
            "O seu IMC é de ${imc.toStringAsPrecision(4)}. Você está com Obesidade grau 1!";
      } else if (imc >= 35 && imc <= 39.9) {
        _infoText =
            "O seu IMC é de ${imc.toStringAsPrecision(4)}. Você está com Obesidade grau 2!";
      } else if (imc >= 35 && imc <= 39.9) {
        _infoText =
            "O seu IMC é de ${imc.toStringAsPrecision(4)}. Você está com Obesidade grau 3, correndo um sério risco de vida!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh, size: 40, color: Colors.black),
            onPressed: _resetFields,
          ),
        ],
      ),
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Form(
              key: _formkey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Icon(Icons.person, size: 120.0, color: Colors.white),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Peso (kg)",
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 30.0)),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.greenAccent, fontSize: 25.0),
                      controller: weightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira seu Peso!";
                        }
                      },
                    ),
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Altura (cm)",
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 30.0)),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.greenAccent, fontSize: 25.0),
                        controller: heightController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Insira sua altura!";
                          }
                        }),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
                      child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              _calculate();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style:
                                TextStyle(color: Colors.black12, fontSize: 25.0),
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      _infoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    )
                  ]))),
    );
  }
}
