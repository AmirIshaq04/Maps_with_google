import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:mygeoapp/pages/home_page.dart';
import 'package:mygeoapp/pages/login.dart';
import 'package:mygeoapp/widgets/common_widgets.dart';

import '../authentication_directory/facebook_auth.dart';
import '../authentication_directory/google_auth.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _homepageState();
}

class _homepageState extends State<SignUp> {
  final purpleColor = Color(0xff6688FF);

  final darkTextColor = Color(0xff1F1A3D);

  final lightTextdcolor = Color(0xff999999);

  final textFieldColor = Color(0xffF5F6FA);

  final borderColor = Color(0xffD9D9D9);

  Widget getTextField({required String hint,required TextEditingController controller}) {
    return TextField(controller: controller,
      decoration: InputDecoration(
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(8.r),
        //   borderSide: BorderSide(color: Colors.transparent, width: 0),
        // ),
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
  create(String email,String passward,String name)async{
    print('email; $email');
    if(email.isEmpty && passward.isEmpty){
      commonWidgets.CustomeBox(context, 'Please Enter Required Fields');
    }
    else{
      UserCredential? userCredential;
      try{
        userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: passward).then((value) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
        });
      }
      on FirebaseAuthException catch(ex){
        return commonWidgets.CustomeBox(context, ex.code.toString());
      }
    }
  }
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController namecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 52.h,
                  ),
                  Text(
                    " Sing Up to our Team",
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
                        " Already have an account?",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: lightTextdcolor,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          " Login",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: purpleColor,
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  getTextField(hint: "Your Name",controller: namecontroller),
                  //  getTextField(hint: "Second Name"),
                  SizedBox(
                    height: 16.h,
                  ),
                  getTextField(hint: "Email",controller: emailcontroller),
                  SizedBox(
                    height: 16.h,
                  ),
                  getTextField(hint: "Password",controller: passwordcontroller),
                  SizedBox(
                    height: 16.h,
                  ),
                  //  getTextField(hint: "Confirm Password"),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async{
                        create(emailcontroller.text.toString(), passwordcontroller.text.toString(),namecontroller.text.toString());
                       final userId = FirebaseAuth.instance.currentUser!.uid;
                        await FirebaseFirestore.instance.collection('User').doc(userId).set(
                            {
                              'Name' : namecontroller.text,
                              'Email': emailcontroller.text,
                              'Password' : passwordcontroller.text,
                              'userId' : userId
                            });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(purpleColor),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 14.h)),
                      ),
                      child: Text("Create Account"),
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
                        "or sing up via",
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
                             // FirebaseService().signInwithGoogle(context);
                             // signInWithGoogle();
                              FirebaseService().signInwithGoogle(context);
                            },
                          ),
                          const Text("Google"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h,),
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
                              width: 34,
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
                  SizedBox(
                    height: 16.h,
                  ),
                  Wrap(
                    children: [
                      Text(
                        "By signing up to our Team You agree to",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: lightTextdcolor,
                        ),
                      ),
                      Text(
                        "our terms and conditions ",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: purpleColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
