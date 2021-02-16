import 'package:bmi_calculator/Models/BmiModel.dart';
import 'package:bmi_calculator/screens/ResultScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BmiModel _bmiModel;
  double _userheight = 100.0;
  double _userweight = 40.0;
  double _bmi;
  bool _isload;
  void initState() {
    super.initState();
    _isload = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                child: SvgPicture.asset(
                  'assets/images/fitness.svg',
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                'BMI Calculator',
                style: TextStyle(color: Colors.red, fontSize: 40),
              ),
              Text(
                'We care About You !',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              SizedBox(height: 40),
              Text(
                'Height(cm):',
                style: TextStyle(fontSize: 20),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Slider(
                  min: 60.0,
                  max: 250.0,
                  onChanged: (value) {
                    setState(() {
                      _userheight = value;
                    });
                  },
                  value: _userheight,
                  divisions: 100,
                  label: "$_userheight",
                ),
              ),
              Text(
                "$_userheight cm",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(height: 40),
              Text(
                'Weight(Kg):',
                style: TextStyle(fontSize: 20),
              ),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Slider(
                  min: 30.0,
                  max: 250.0,
                  onChanged: (weight) {
                    setState(() {
                      _userweight = weight;
                    });
                  },
                  value: _userweight,
                  divisions: 100,
                  label: "$_userweight",
                ),
              ),
              Text(
                "$_userweight kg",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 200),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[300],
                        blurRadius: 10.0,
                        spreadRadius: 1.0,
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: _isload
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : FlatButton(
                          onPressed: () async {
                            setState(() {
                              _isload = true;
                            });
                            _bmi = _userweight /
                                ((_userheight / 100) * (_userheight / 100));
                            await Future.delayed(
                                const Duration(milliseconds: 3000), () => 42);

                            if (_bmi >= 18.5 && _bmi <= 25) {
                              _bmiModel = BmiModel(
                                bmi: _bmi,
                                comments: 'Your bmi is Normal',
                                isnormal: true,
                              );
                            } else if (_bmi < 18.5) {
                              _bmiModel = BmiModel(
                                  bmi: _bmi,
                                  comments: 'Your are EnderWeighted !',
                                  isnormal: false);
                            } else if (_bmi > 25 && _bmi <= 30) {
                              _bmiModel = BmiModel(
                                bmi: _bmi,
                                comments: 'Your are OverWeighted',
                                isnormal: false,
                              );
                            } else {
                              _bmiModel = BmiModel(
                                bmi: _bmi,
                                comments: 'Your are very Obesed !',
                                isnormal: false,
                              );
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                        bmimodel: _bmiModel,
                                      )),
                            );
                            setState(() {
                              _isload = false;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Calculate BMI',
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
