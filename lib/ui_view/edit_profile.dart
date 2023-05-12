import 'package:flutter/material.dart';
import 'package:unjday_6april/model/model_edituser.dart';
import 'package:http/http.dart' as http;
import 'package:unjday_6april/ui_view/view_berita.dart';

import '../utils/api.dart';

class PageEditProfile extends StatefulWidget {

  //decator atau penampung
   final String nid;
   final String nfullname;
   final String nusername;

  const PageEditProfile({Key? key, required this.nusername, required this.nfullname, required this.nid
  }) : super(key: key);

  @override
  State<PageEditProfile> createState() => _PageEditProfileState();
}

class _PageEditProfileState extends State<PageEditProfile> {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController etFullName =  TextEditingController();
  TextEditingController etUsername =  TextEditingController();

  bool isLoading = false;

  Future<ModelEditUser?> updateAccount()async{
    //handle error
    try{
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post(Uri.parse("${baseUrl}updateUser.php"),
          body: {
            "fullname" : etFullName.text,
            "id" : '${widget.nid}',

          }
      );

      ModelEditUser data = modelEditUserFromJson(res.body);
      //berhasil didaftarkan
      if(data.value == 1){
        setState(() {
          isLoading = false;

          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_)=> PageHomeBerita()),
                  (route) => false);
        });

      }else if(data.value == 0){
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${data.message}"),
            backgroundColor: Colors.black,
          ),
          );
        });
      }

    }catch (e){
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
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height: 40,),
                TextFormField(
                  controller: etFullName,
                  validator: (val){
                    return val!.isEmpty ? "Tidak Boleh Kosong!" : null;
                  },
                  decoration: InputDecoration(
                    hintText: '${widget.nfullname}',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.person),
                    filled: true,
                    fillColor: Colors.yellowAccent.withOpacity(0.2),
                  ),

                ),
                SizedBox(height: 8,),



                SizedBox(height: 15,),

                isLoading ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.yellowAccent,
                  ),
                ) : MaterialButton(onPressed: () async{
                  if(keyForm.currentState!.validate()){
                    await updateAccount();
                  }
                },
                  color: Colors.black,
                  textColor: Colors.yellowAccent,
                  minWidth: 200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text('Update'),

                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
