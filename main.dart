import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  //const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var today = TextEditingController(); //todaycases
  var death = TextEditingController(); //todaydeath
  var cases_th = TextEditingController(); //ผู้ติดเชื่อประเทศไทย
  var death_th = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    today.text = '-';
    death.text = '-';
    cases_th.text = '-';
    death_th.text = '-';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HeroCovidCheck"),
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  print('Get Data Covid');
                  _GetCovidData();
                })
          ],
        ),
        body: ListView(
          children: [
            //ช่องว่าง
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Today Cases(World)',
                style: TextStyle(fontSize: 30, color: Colors.lightBlue),
              ),
            ),
            Center(
                child: Text(
              today.text,
              style: TextStyle(fontSize: 30),
            )),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Today Death(World)',
                style: TextStyle(fontSize: 30, color: Colors.red),
              ),
            ),
            Center(
                child: Text(
              death.text,
              style: TextStyle(fontSize: 30),
            )),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'ยอดผู้ติดเชื้อประเทศไทยวันนี้',
                style: TextStyle(fontSize: 25, color: Colors.lightBlue),
              ),
            ),
            Center(
                child: Text(
              cases_th.text,
              style: TextStyle(fontSize: 30),
            )),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'ยอดผู้ติดเสียชีวิตประเทศไทยวันนี้',
                style: TextStyle(fontSize: 25, color: Colors.red),
              ),
            ),
            Center(
                child: Text(
              death_th.text,
              style: TextStyle(fontSize: 30),
            )),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                'Dev by ChaiyapatOam \nData : https://disease.sh/',
                style: TextStyle(fontSize: 15, color: Colors.indigo),
              ),
            ),
          ],
        ));
  }

  //https://disease.sh/v3/covid-19/all
  //https://disease.sh/v3/covid-19/countries/thailand
  Future<String> _GetCovidData() async {
    var url = Uri.https('disease.sh', '/v3/covid-19/all');
    var url1 = Uri.https('disease.sh', '/v3/covid-19/countries/thailand');

    var response = await http.get(url);
    print('=====Data=====');
    print(response.body);
    // response thailand
    var response1 = await http.get(url1);
    print('=====DataTH=====');
    print(response1.body);

    var result = json.decode(response.body);
    var result1 = json.decode(response1.body);

    var v1 = result['todayCases'];
    var v2 = result['todayDeaths'];
    var v3 = result1['todayCases'];
    var v4 = result1['todayDeaths'];
    var format = NumberFormat('###,###,###,###,###,###'); //123,456.789
    //today.text = v1; String
    setState(() {
      today.text = format.format(v1); // int.parse(v1) if v1 is string
      death.text = format.format(v2); //today.text = v1; String
      cases_th.text = format.format(v3); // todaycases TH
      death_th.text = format.format(v4);
      //sdasf
    });
  }
}
