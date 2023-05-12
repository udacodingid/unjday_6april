import 'package:flutter/material.dart';
import 'package:unjday_6april/model/model_userprofile.dart';
import 'package:http/http.dart' as http;
import 'package:unjday_6april/ui_view/edit_profile.dart';
import 'package:unjday_6april/utils/api.dart';
import 'package:unjday_6april/utils/session_manager.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({Key? key}) : super(key: key);

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {

  bool isLoading = false;
  List<Datum> userProfile = [];
  String? id;

  Future<ModelUserProfile?>  getUser() async{
    try{
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.post(Uri.parse('${baseUrl}getUser.php'),
        body: {'id' : id}
      );
      List<Datum>? data = modelUserProfileFromJson(res.body).data;
      setState(() {
        isLoading = false;
        userProfile = data ?? [];
      });

    }catch(e){
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),
          backgroundColor: Colors.black,
        ),
        );
      });

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionManager.getPref().then((value){
        setState(() {
          id = sessionManager.idUser;
        });
        getUser();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(onPressed: (){
            //kita arahkan ke page profile
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context)=> PageEditProfile(username: username, fullname: fullname, id: id)));
          },
              icon: Icon(Icons.edit_document)),

        ],
      ),

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: userProfile.map((e) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Full Name : ${e.fullname}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text('Username : ${e.username}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 8,),
                      Text('Email : ${e.email}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 8,),
                      MaterialButton(onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (_)=> PageEditProfile(nusername: e.username, nfullname: e.fullname, nid: e.id))
                        );

                      }, child: Text('Edit Profile'),)
                    ],
                  ),

                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
