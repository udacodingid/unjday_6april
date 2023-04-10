import 'package:flutter/material.dart';
import 'package:unjday_6april/main.dart';
import 'package:unjday_6april/ui_view/list_user.dart';
import 'package:unjday_6april/ui_view/view_berita.dart';

class PageMenu extends StatelessWidget {
  const PageMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Apps'),
        backgroundColor: Colors.yellowAccent,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: 20,),
            MaterialButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PageListUser()));
            },
              child: Text('List User'),
              color: Colors.black,
              textColor: Colors.yellowAccent,
            ),
            SizedBox(height: 10,),
            MaterialButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> MovieAppHome()));
            },
              child: Text('Movie App'),
              color: Colors.black,
              textColor: Colors.yellowAccent,
            ),
            SizedBox(height: 10,),
            MaterialButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PageHomeBerita()));
            },
              child: Text('List Berita'),
              color: Colors.black,
              textColor: Colors.yellowAccent,
            ),
          ],
        ),
      ),
    );
  }
}
