import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:unjday_6april/model/model_berita.dart';
import 'package:http/http.dart' as http;
import 'package:unjday_6april/ui_view/detail_berita.dart';

class PageHomeBerita extends StatefulWidget {
  const PageHomeBerita({Key? key}) : super(key: key);

  @override
  State<PageHomeBerita> createState() => _PageHomeBeritaState();
}

class _PageHomeBeritaState extends State<PageHomeBerita> {
  bool isLoading = false;
  List<Datum> listBerita = [];

  Future<ModelBerita?> getBerita() async{
    try{
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.get(Uri.parse('http://192.168.1.20/beritaDb/getBerita.php'));
      List<Datum>? data = modelBeritaFromJson(res.body).data;

      setState(() {
        isLoading = false;
        listBerita  = data ?? [] ;//
      });

    }catch(e){
      setState(() {
        isLoading = false;
        //text error nya
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString(), style: TextStyle(
            color: Colors.black
          ),),//convert objectt ke string
            backgroundColor: Colors.yellowAccent,
          )
        );
      });

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBerita();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        backgroundColor: Colors.yellowAccent,
      ),

      body: isLoading? const Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      ) : Column(
        children: [
          SizedBox(height: 8,),
          Expanded(child: ListView.builder(
            itemCount: listBerita.length,
            itemBuilder: (context, index){
              final nListData = listBerita[index];
              return Padding(
                padding: EdgeInsets.all(5),
                //agar bisa klik detail
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => DetailBerita(listBerita[index])));
                  },
                  child: ClipRRect(
                    borderRadius : BorderRadius.circular(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.network('http://192.168.1.20/beritaDb/gambar_berita/' + nListData.gambarBerita,
                        //   height: 20,
                        //   width: MediaQuery.of(context).size.width,
                        //   fit: BoxFit.fitWidth,
                        // ),
                        ImageNetwork(image: 'http://192.168.1.20/beritaDb/gambar_berita/' + nListData.gambarBerita,
                            height: 50, width:  MediaQuery.of(context).size.width,),
                        ListTile(
                          title: Text(nListData.judul,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),

                        )

                      ],
                    ),
                  ),
                ),

              );
            },
          ))
        ],
      ),
    );
  }
}
