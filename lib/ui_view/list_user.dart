import 'package:flutter/material.dart';
import 'package:unjday_6april/model/model_user.dart';
import 'package:unjday_6april/utils/network.dart';
import 'package:http/http.dart' as http;

class PageListUser extends StatefulWidget {
  const PageListUser({Key? key}) : super(key: key);

  @override
  State<PageListUser> createState() => _PageListUserState();
}

class _PageListUserState extends State<PageListUser> {
  // List<ModelUser>? listUser;
  //
  // Future<List<ModelUser>?> listDataUser() async{
  //   try{
  //     ModelUser response = await NetworkProvider().getDataUser();
  //     print(response);
  //     setState(() {
  //       listUser = response as List<ModelUser>?;
  //       print(listUser);
  //     });
  //   }catch(e){
  //     // print(e);
  //   }
  //   return listUser;
  // }

  List<Datum> listData = [];
  bool loading = false;

  Future<ModelUser?> getDataUser() async{
    //proses do in background
    setState(() {
      loading = true; //loading true
    });

    final responseData = await http.get(Uri.parse('https://reqres.in/api/users'));
    if(responseData.statusCode == 200){
      List<Datum> dataUser = modelUserFromJson(responseData.body).data;
      setState(() {
        listData = dataUser;
        loading = false;
      });
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List User'),
        backgroundColor: Colors.greenAccent,
      ),

      // ? dan : --> if else ...
      body: Container(
        child: loading ? Center(
          child: CircularProgressIndicator(),
        ) : ListView.builder(
          itemCount: listData?.length,
          itemBuilder: (context, index){
            final nListData = listData[index];
            return Container(
             margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                color: Colors.yellowAccent,
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.all(8),
                        child: Image.network(nListData.avatar),
                      ),
                      Text("ID : " + nListData.id.toString()),
                      Text(nListData.firstName + " " + nListData.lastName, style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold)),
                      Text(nListData.email, style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
