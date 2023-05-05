import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unjday_6april/model/model_login.dart';
import 'package:unjday_6april/ui_view/register_view.dart';
import 'package:unjday_6april/ui_view/view_berita.dart';
import 'package:unjday_6april/utils/api.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController etUsername = new TextEditingController();
  TextEditingController etPassword = new TextEditingController();

  bool isLoading = false;

  Future<ModelLogin?> loginAccount()async{
    //handle error
    try{
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post(Uri.parse("${baseUrl}login.php"),
          body: {

            "username" : etUsername.text,
            "password" : etPassword.text,
          }
      );

      ModelLogin? data = modelLoginFromJson(res.body);
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
      }else{
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(' Login App'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Image.asset('gambar/logounj.png', height: 150,width: 150,),
                SizedBox(height: 10,),

                TextFormField(
                  controller: etUsername,
                  validator: (val){
                    return val!.isEmpty ? "Tidak Boleh Kosong!" : null;
                  },
                  decoration: InputDecoration(
                    hintText: 'User Name',
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
                TextFormField(
                  controller: etPassword,
                  validator: (val){
                    return val!.isEmpty ? "Tidak Boleh Kosong!" : null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.password),
                    filled: true,
                    fillColor: Colors.yellowAccent.withOpacity(0.2),
                  ),

                ),
                SizedBox(height: 15,),

                isLoading ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.yellowAccent,
                  ),
                ) : MaterialButton(onPressed: () async{
                  if(keyForm.currentState!.validate()){
                    await loginAccount();
                  }
                },
                  color: Colors.black,
                  textColor: Colors.yellowAccent,
                  minWidth: 200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text('Login'),

                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> PageRegister()));
                  },
                  child: Text('Anda belum punya akun? Silahkan Register', style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
