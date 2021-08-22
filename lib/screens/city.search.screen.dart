import 'package:flutter/material.dart';

class CitySearchScreen extends StatefulWidget {
  @override
  _CitySearchScreenState createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  final TextEditingController _cityController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter a city'),
      ),
      body: Form(
          child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: TextFormField(
              controller: _cityController,
              decoration: InputDecoration(
                  labelText: 'Enter a city', hintText: 'Example: Chicago'),
            ),
          )),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pop(context, _cityController.text);
              })
        ],
      )),
    );
  }
}
