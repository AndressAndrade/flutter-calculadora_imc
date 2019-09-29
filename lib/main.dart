import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Calculadora IMC',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Criação de controladores dos campos de peso e altura
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  // Validação de formulários
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // Variável para armazenar texto de informações;
  String _info = 'Insira seus dados';

  // Função para resetar campos
  void _resetFields() {
    setState(() {
      weightController.text = '';
      heightController.text = '';


        _info = 'Insira seus dados';
        _formkey = GlobalKey<FormState>();
      });
  }

  void _calculate(){
    setState(() {
      // Obtem peso e altura
      double weigth = double.parse(weightController.text);
      double heigth = double.parse(heightController.text) / 100;

      double imc = weigth/(heigth*heigth);
      if (imc < 18.5) {
        _info = 'Abaixo do peso IMC: ${imc.toStringAsPrecision(4)}';
      }
      else if(imc >= 18.5 && imc <= 24.9) {
        _info = 'Peso normal IMC: ${imc.toStringAsPrecision(4)}';
      }
      else if(imc >= 25 && imc <= 29.9) {
        _info = 'Sobrepeso IMC: ${imc.toStringAsPrecision(4)}';
      }
      else if(imc >=30 && imc <= 34.9) {
        _info = 'Obesidade grau 1 IMC: ${imc.toStringAsPrecision(4)}';
      }
      else if(imc >=35 && imc <= 39.9) {
        _info = 'Obesidade grau 2 IMC: ${imc.toStringAsPrecision(4)}';
      }
      else {
        _info = 'Obesidade grau 3 IMC: ${imc.toStringAsPrecision(4)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Form(
          key: _formkey,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 140.0,
                color: Colors.orange,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(color: Colors.orange)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.orange, fontSize: 25),
                controller: weightController,
                validator: (value){
                  if(value.isEmpty) {
                    return 'Insira seu peso';
                  }
                  else if (int.parse(value) < 0 || int.parse(value) > 600){
                    return 'Insira um valor apropriado';
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(color: Colors.orange)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.orange, fontSize: 25),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty) {
                    return 'Insira sua altura';
                  }
                  else if (int.parse(value) < 0 || int.parse(value) > 200){
                    return 'Insira um valor apropriado';
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formkey.currentState.validate()){
                          _calculate();
                          FocusScope.of(context).requestFocus(new FocusNode());
                        }
                      },
                      child: Text(
                        'Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      color: Colors.orange,
                    )),
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.orange, fontSize: 25),
              )
            ],
          )
        ),
      ),
    );
  }
}
