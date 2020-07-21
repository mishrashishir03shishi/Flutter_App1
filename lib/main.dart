import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator App',
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final double _minimumPadding = 5.0;
  var _currentSelectedItem = "Rupees";
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult = "";

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;

    return Scaffold(
//			resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),

      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 5),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter Principal Interest';
                        }
                      },
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: principalController,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0,
                          ),
                          labelText: 'Principal',
                          hintText: 'Enter Principal e.g. 12000',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter Rate';
                        }
                      },
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: roiController,
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 15.0,
                          ),
                          labelText: 'Rate of Interest',
                          hintText: 'In percent',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          // ignore: missing_return
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter term';
                            }
                          },
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termController,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 15.0,
                              ),
                              labelText: 'Term',
                              hintText: 'Time in years',
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: textStyle,
                              ),
                            );
                          }).toList(),
                          value: _currentSelectedItem,
                          onChanged: (String newValueSelected) {
                            _onDropDownItemSelected(newValueSelected);
                          },
                        ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding, top: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Theme.of(context).primaryColorDark,
                            child: Text(
                              'Calculate',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate())
                                  this.displayResult = _calculateTotalReturns();
                              });
                            },
                          ),
                        ),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'Reset',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentSelectedItem = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        "After $term years, your investment will be worth $totalAmountPayable ";
    return result;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    displayResult = "";
    _currentSelectedItem = _currencies[0];
  }
}
