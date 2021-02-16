import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResultScreen extends StatelessWidget {
  final bmimodel;

  const ResultScreen({this.bmimodel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Container(
                width: 300,
                height: 300,
                child: bmimodel.isnormal
                    ? SvgPicture.asset('assets/images/happy.svg',
                        fit: BoxFit.contain)
                    : SvgPicture.asset('assets/images/sad.svg',
                        fit: BoxFit.contain),
              ),
              SizedBox(height: 40),
              Text(
                "  Your BMI is ${bmimodel.bmi.round()}",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
              SizedBox(height: 40),
              Text(
                '${bmimodel.comments}',
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
