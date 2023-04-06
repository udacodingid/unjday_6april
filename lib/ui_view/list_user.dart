import 'package:flutter/material.dart';
import 'package:unjday_6april/model/model_user.dart';
import 'package:unjday_6april/utils/network.dart';

class PageListUser extends StatefulWidget {
  const PageListUser({Key? key}) : super(key: key);

  @override
  State<PageListUser> createState() => _PageListUserState();
}

class _PageListUserState extends State<PageListUser> {
  List<ModelUser>? listUser;

  Future<List<ModelUser>?> listDataUser() async{
    try{
      ModelUser response = await NetworkProvider().getDataUser();
      print(response);
      setState(() {
        listUser = response as List<ModelUser>?;
        print(listUser);
      });
    }catch(e){
      // print(e);
    }
    return listUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List User'),
        backgroundColor: Colors.greenAccent,
      ),

      body: ListView.builder(
        itemCount: listUser?.length,
        itemBuilder: (context, index){
          return Column(
            children: [
              Card(
                child: Text(listUser![index].data[index].firstName),
              )
            ],
          );
        },
      ),
    );
  }
}
