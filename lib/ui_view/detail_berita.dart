import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:unjday_6april/model/model_berita.dart';

class DetailBerita extends StatelessWidget {
  final Datum listBerita;
  const DetailBerita(this.listBerita, {Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${listBerita.judul}', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.yellowAccent,
      ),
      
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            ImageNetwork(image: 'http://192.168.1.3/beritaDb/gambar_berita/${listBerita.gambarBerita}' ,
              height: 200, width:  MediaQuery.of(context).size.width,
              fitWeb: BoxFitWeb.contain,),
            SizedBox(height: 8,),
            Text('${listBerita.judul}', style: TextStyle(fontSize: 16,
              fontWeight: FontWeight.w600
            ),),
            SizedBox(height: 5,),
            Text('${listBerita.isiBerita}',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14),
              textAlign: TextAlign.justify,
            )

          ],
        ),
      ),
    );
  }
}
