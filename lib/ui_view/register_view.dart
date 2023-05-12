import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unjday_6april/ui_view/login_view.dart';
import 'package:unjday_6april/model/model_register.dart';
import 'package:unjday_6april/utils/api.dart';

class PageRegister extends StatefulWidget {
  const PageRegister({Key? key}) : super(key: key);

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController etFullName =  TextEditingController();
  TextEditingController etUsername =  TextEditingController();
  TextEditingController etEmail =  TextEditingController();
  TextEditingController etPassword =  TextEditingController();

  bool isLoading = false;

  Future<ModelRegister?> registerAccount()async{
    //handle error
    try{
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post(Uri.parse("${baseUrl}register.php"),
        body: {
          "fullname" : etFullName.text,
          "username" : etUsername.text,
          "email" : etEmail.text,
          "password" : etPassword.text,
        }
      );

      ModelRegister data = modelRegisterFromJson(res.body);
      //berhasil didaftarkan
      if(data.value == 1){
        setState(() {
          isLoading = false;

          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_)=> PageLogin()),
                  (route) => false);
        });
      }else if(data.value == 2){
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${data.message}"),
            backgroundColor: Colors.black,
          ),
          );
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(' Login Register'),
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
                  controller: etFullName,
                  validator: (val){
                    return val!.isEmpty ? "Tidak Boleh Kosong!" : null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Full Name',
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
                  controller: etEmail,
                  validator: (val){
                    return val!.isEmpty ? "Tidak Boleh Kosong!" : null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.yellowAccent.withOpacity(0.2),
                  ),

                ),
                SizedBox(height: 8,),
                TextFormField(
                  controller: etPassword,
                  obscureText: true,
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
                    await registerAccount();
                  }
                },
                  color: Colors.black,
                  textColor: Colors.yellowAccent,
                  minWidth: 200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text('Sign Up'),

                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> PageLogin()));
                  },
                  child: Text('Anda sudah punya akun? Silahkan login', style: TextStyle(
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
