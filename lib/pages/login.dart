import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:mygeoapp/crud_operations/show_screen.dart';
import 'package:mygeoapp/pages/home_page.dart';
import 'package:mygeoapp/widgets/common_widgets.dart';
import '../authentication_directory/facebook_auth.dart';
import '../authentication_directory/google_auth.dart';
class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final purpleColor = Color(0xff6688FF);

  final darkTextColor = Color(0xff1F1A3D);

  final lightTextdcolor = Color(0xff999999);

  final textFieldColor = Color(0xffF5F6FA);

  final borderColor = Color(0xffD9D9D9);

  Widget getTextField({required String hint,required TextEditingController controller}) {
    return TextField(controller: controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          contentPadding:
          EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          filled: true,
          fillColor: textFieldColor,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          )),
    );
  }
  login(String email,String password)async{
    if(email==''&& password==''){
      return commonWidgets.CustomeBox(context as BuildContext, 'Please Enter Required fields');
    }
    else{
      UserCredential? userCredential;
      try{
        userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
          Navigator.of(context as BuildContext).push(MaterialPageRoute(builder: (context) => HomePage(),));
        });
      }
      on FirebaseAuthException catch(ex){
        return commonWidgets.CustomeBox(context as BuildContext, ex.code.toString());
      }
    }
  }
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding:  EdgeInsets.only(left: 15.w),
            child: GestureDetector(child: Icon(Icons.account_circle,size: 35.w),onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ShowScreen(),));
            },),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 52.h,
                  ),
                  Text(
                    "Login to our Team",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: darkTextColor,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Wrap(
                    children: [
                      Text(
                        " Do not have an account?",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: lightTextdcolor,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          " Signup",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: purpleColor,
                          ),
                        ),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 120.h,),
                  getTextField(hint: "Email",controller: emailcontroller),
                  SizedBox(
                    height: 16.h,
                  ),
                  getTextField(hint: "Password",controller: passwordcontroller),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        login(emailcontroller.text.toString(), passwordcontroller.text.toString());
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(purpleColor),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 14.h)),
                      ),
                      child: Text("Login"),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(
                        "Or Login via",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: lightTextdcolor,
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(
                          color: borderColor,
                        )),
                        foregroundColor: MaterialStateProperty.all(darkTextColor),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 1.h)),
                        textStyle: MaterialStateProperty.all(TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w700)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            child: Image.asset(
                              "asset/images/logo.png",
                              height: 48,
                              width: 34,
                            ),
                            onTap: (){
                              FirebaseService().signInwithGoogle(context);
                            },
                          ),
                          const Text("Google"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(
                          color: borderColor,
                        )),
                        foregroundColor: MaterialStateProperty.all(darkTextColor),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 1.h)),
                        textStyle: MaterialStateProperty.all(TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w700)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            child: Image.asset(
                              "asset/images/facebook.png",
                              height: 48,
                              width: 24,
                            ),
                            onTap: (){
                              signInWithFacebook();
                            },
                          ),
                          const Text("Facebook"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),));
  }
}
