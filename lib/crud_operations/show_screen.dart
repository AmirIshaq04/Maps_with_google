import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mygeoapp/crud_operations/user.dart';
import 'package:mygeoapp/services/database.dart';

class ShowScreen extends StatefulWidget {
  const ShowScreen({super.key});

  @override
  State<ShowScreen> createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  final purpleColor = const Color(0xff6688FF);

  final darkTextColor = const Color(0xff1F1A3D);

  final lightTextdcolor = const Color(0xff999999);

  final textFieldColor = const Color(0xffF5F6FA);

  final borderColor = const Color(0xffD9D9D9);
  Stream? UserStream;
  getonload() async {
    UserStream = await DatabaseMethods().getUserDetails();
    setState(() {});
  }

  @override
  void initState() {
    getonload();
    super.initState();
  }

  Widget allUserDetails() {
    return StreamBuilder(
      stream: UserStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin:
                        const EdgeInsets.only(bottom: 15.0, left: 15, right: 15).w,
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.all(10).w,
                        margin: EdgeInsets.all(10.w),
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Name: ' + ds['Name'],
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {
                                      nameController.text=ds['Name'];
                                      emailController.text=ds['Email'];
                                      passwordController.text=ds['Password'];
                                      editUserdetails(ds['userId']);
                                      // );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    )),
                                IconButton(onPressed: ()async{
                                  await DatabaseMethods().deleteUserDetails(ds['userId']);
                                }, icon: const Icon(Icons.delete,color: Colors.black54,)),
                              ],
                            ),
                            Text(
                              'Age: ' + ds['Email'],
                              style: TextStyle(
                                  color: purpleColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Location: ' + ds['Password'],
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserScreen(),
                ));
          }),
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: "User",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color(0xff6688FF),
                fontSize: 25.sp),
            children: <InlineSpan>[
              WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: SizedBox(width: 5.w)),
              const TextSpan(
                text: "Profile",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              )
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Expanded(child: allUserDetails()),
          ],
        ),
      ),
    );
  }
  Future editUserdetails(String Id){
    return showDialog(context: context, builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 50,top: 30).w,
        child: Container(
          color: Colors.grey,
          child: Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: const Icon(Icons.highlight_remove),),
                    SizedBox(width: 60.w,),
                    Text('Edit Details',style: TextStyle(color: Colors.blue,fontSize: 20.sp,fontWeight: FontWeight.w500),),
                  ],
                ),
                SizedBox(height: 50.h,),
                Padding(
                  padding: const EdgeInsets.only(left: 10).w,
                  child: Text('Name',style: TextStyle(fontSize: 20.sp,color: Colors.black54),),
                ),
                SizedBox(height: 5.h,),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10).w,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Colors.transparent, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Colors.transparent, width: 0),
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
                ),
                SizedBox(height: 10.h,),
                Padding(
                  padding: const EdgeInsets.only(left: 10).w,
                  child: Text('Email',style: TextStyle(fontSize: 20.sp,color: Colors.black54),),
                ),
                SizedBox(height: 5.h,),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10).w,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Colors.transparent, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Colors.transparent, width: 0),
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
                ),
                SizedBox(height: 10.h,),
                Padding(
                  padding: const EdgeInsets.only(left: 10).w,
                  child: Text('Password',style: TextStyle(fontSize: 20.sp,color: Colors.black54),),
                ),
                SizedBox(height: 5.h,),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10).w,
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Colors.transparent, width: 0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Colors.transparent, width: 0),
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
                ),
                SizedBox(height: 20.h,),
                Padding(
                  padding:  const EdgeInsets.only(left: 20,right: 20).w,
                  child: SizedBox(
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
                      child:GestureDetector(child: Text('Update',style: TextStyle(fontSize: 20.sp,color: purpleColor),),onTap: ()async{
                        Map<String,dynamic>updateInfo={
                          'Name':nameController.text,
                           'Email':emailController.text,
                            'userId':Id,
                          // 'Id':Id,
                          'Password':passwordController.text
                        };
                        await DatabaseMethods().updateUseDetails(Id, updateInfo).then((value) {
                          Navigator.pop(context);
                        });
                      },),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },);
  }
}
