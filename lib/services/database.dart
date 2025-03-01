import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('User')
        .doc(id)
        .set(userInfoMap);
  }
  Future<Stream<QuerySnapshot>>getUserDetails()async{
    return await FirebaseFirestore.instance.collection('User').snapshots();
  }
  Future updateUseDetails(String Id,Map<String,dynamic>updateInfo)async{
   return await FirebaseFirestore.instance.collection('User').doc(Id).update(updateInfo);
  }
  Future deleteUserDetails(String Id)async{
    print('id $Id');
    return await FirebaseFirestore.instance.collection('User').doc(Id).delete();
  }
}
