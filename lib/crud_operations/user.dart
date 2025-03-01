
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mygeoapp/services/database.dart';
import 'package:random_string/random_string.dart';

class UserScreen extends StatefulWidget {
 const  UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final purpleColor = Color(0xff6688FF);

  final darkTextColor = Color(0xff1F1A3D);

  final lightTextdcolor = Color(0xff999999);

  final textFieldColor = Color(0xffF5F6FA);

  final borderColor = Color(0xffD9D9D9);
  TextEditingController nameController=TextEditingController();
  TextEditingController ageController= TextEditingController();
  TextEditingController locationController= TextEditingController();
  TextEditingController emailController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:RichText(
          text: TextSpan(
            text: "User",
            style: TextStyle(fontWeight: FontWeight.bold, color:  Color(0xff6688FF),fontSize: 25.sp),
            children: <InlineSpan>[
              WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: SizedBox(width:5.w)),
              TextSpan(
                text: "Form",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                ),
              )
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding:  EdgeInsets.all(15).w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5).w,
                child: Text('Name',style: TextStyle(fontSize: 20.sp,color: Colors.black54),),
              ),
              SizedBox(height: 5.h,),
          TextField(
            controller: nameController,
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
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                )),
          ),
              SizedBox(height: 10.h,),
              Padding(
                padding: const EdgeInsets.only(left: 5).w,
                child: Text('Email',style: TextStyle(fontSize: 20.sp,color: Colors.black54),),
              ),
              SizedBox(height: 5.h,),
              TextField(
                controller: nameController,
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
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              SizedBox(height: 10.h,),
              Padding(
                padding: const EdgeInsets.only(left: 5).w,
                child: Text('Age',style: TextStyle(fontSize: 20.sp,color: Colors.black54),),
              ),
              SizedBox(height: 5.h,),
              TextField(
                controller: ageController,
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
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              SizedBox(height: 10.h,),
              Padding(
                padding: const EdgeInsets.only(left: 5).w,
                child: Text('Location',style: TextStyle(fontSize: 20.sp,color: Colors.black54),),
              ),
              SizedBox(height: 5.h,),
              TextField(
                controller: locationController,
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
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              SizedBox(height: 20.h,),
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
            child:GestureDetector(child: Text('Add',style: TextStyle(fontSize: 20.sp,color: purpleColor),),onTap: () async {
              String Id= randomAlphaNumeric(10);
              Map<String,dynamic>userInfoMap={
                'Name':nameController.text,
                'Age': ageController.text,
                'Id':Id,
                'Location':locationController.text,
              };
              await DatabaseMethods().addUserDetails(userInfoMap, Id).then((value) {
                Fluttertoast.showToast(
                    msg: "information successfully Saved",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.transparent,
                    textColor: Colors.blue,
                    fontSize: 16.0
                );
              });
            },),
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
