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
  TextEditingController heghttController = TextEditingController();
  String _info = "Informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void resetFild() {
    setState(() {
      weightController.text = "";
      heghttController.text = "";
      _info = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calculeIMC() {
    setState(() {
      try {
        double w = double.parse(weightController.text);
        double h = double.parse(heghttController.text) / 100;

        double imc = w / (h * h);
        print(imc);
        if (imc < 18.6)
          _info = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
        else if (imc >= 18.6 && imc < 24.9)
          _info = "Peso ideal (${imc.toStringAsPrecision(4)})";
        else if (imc >= 24.9 && imc < 29.9)
          _info = "lvemente acima do peso (${imc.toStringAsPrecision(4)})";
        else if (imc >= 29.9 && imc < 34.9)
          _info = "Obesidade grau I (${imc.toStringAsPrecision(4)})";
        else if (imc >= 34.9 && imc < 39.9)
          _info = "Obesidade grau II (${imc.toStringAsPrecision(4)})";
        else if (imc >= 40)
          _info = "Obesidade grau III (${imc.toStringAsPrecision(4)})";
      } catch (e) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: () => {resetFild()})
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person, size: 120, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira o seu peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (m)",
                  labelStyle: TextStyle(color: Colors.green, fontSize: 25.0),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heghttController,
                validator: (value) {
                  if(value.isEmpty)
                  {
                    return "Insira a sua altura";
                  }
                },
              ),
              Container(
                height: 75.0,
                padding: EdgeInsets.all(15.0),
                child: ElevatedButton(
                  child: Text(
                    "Calcular IMC",
                    style: TextStyle(fontSize: 25.0),
                  ),
                  onPressed: () {
                    if(_formKey.currentState.validate())
                    {
                       calculeIMC();
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)))),
                ),
              ),
              Text(
                "$_info",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
