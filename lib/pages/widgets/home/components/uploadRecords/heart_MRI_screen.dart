// import 'dart:convert';
// import 'dart:io';
// import 'dart:io' show File;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:healthplus/components/rounded_icon_btn.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:healthplus/home/components/view_full_report.dart';
// import 'package:healthplus/home/customloader.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
//
// class UploadHeartMRI extends StatefulWidget {
//   const UploadHeartMRI({Key? key}) : super(key: key);
//
//   @override
//   _UploadHeartMRIState createState() => _UploadHeartMRIState();
// }
//
//
//
// class _UploadHeartMRIState extends State<UploadHeartMRI> {
//
//   File? _image;
//   String? message;
//   var data;
//   bool isloading=false;
//   String imageURL='';
//
//   Future getImage() async {
//     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//     _image = File(image!.path);
//     setState(() {});
//   }
// // uploading image from here
//   void uploadImage() async {
//     setState(() {
//       isloading=true;
//     });
//     final request = http.MultipartRequest(
//         "POST", Uri.parse("https://db75-106-193-214-189.in.ngrok.io//predict-cardio"));
//     final headers = {"Content-type": "multipart/form-data"};
//     request.files.add(http.MultipartFile('image',
//         _image!. readAsBytes().asStream(), _image!.lengthSync(),
//         filename: _image!. path.split("/").last));
//     request.headers.addAll(headers);
//     final response = await request.send();
//     http.Response res = await http.Response.fromStream (response);
//
//     Map<String,dynamic> dict = jsonDecode(res.body);
//     print(dict);
//
//     for(MapEntry<String, dynamic> e in dict.entries)
//     {
//       dict[e.key]=e.value.toString();
//     }
//     Reference referenceRoot = FirebaseStorage.instance.ref();
//     Reference referenceMRI = referenceRoot.child("MRI");
//     String uniqueFilename= DateTime.now().millisecondsSinceEpoch.toString();
//     Reference referenceToupload = referenceMRI.child(uniqueFilename);
//     User user = FirebaseAuth.instance.currentUser!;
//     FirebaseFirestore db = FirebaseFirestore.instance;
//     // dict.ad
//
//     try {
//       await referenceToupload.putFile(File(_image!.path));
//       imageURL = await referenceToupload.getDownloadURL();
//       db.collection("users")
//           .doc(user.uid)
//           .collection('HeartMRI')
//           .add({'image':imageURL});
//       db.collection("MRI").add({'image' : imageURL});
//     }catch(error){
//       Fluttertoast.showToast(msg: "Something went wrong");
//
//     }
//
//     data = json.decode(res.body);
//     db.collection("users")
//         .doc(user.uid)
//         .collection('HeartMRI')
//         .add(dict);
//     db.collection("MRI").add(dict);
//
//
//     setState(() {
//       isloading=false;
//       Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewReport(dict)));
//
//     });
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Text(" Upload MRI Scan"),
//       ),
//       body: isloading ? CustomLoader():
//       Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           _image == null
//               ? Text('No image selected.',
//             style: TextStyle(color: Colors.teal, fontSize: 20),
//           )
//               : Image.file(_image!),
//
//           Container(
//             width: MediaQuery.of(context).size.width,
//           ),
//
//           ElevatedButton(
//
//               child: Text("Upload Image", style: TextStyle(color: Colors.white,fontSize:25)),
//               style:ElevatedButton.styleFrom(
//                   backgroundColor: Colors.teal,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   )
//               ),
//               onPressed:(){
//                 if(_image != null) {
//                   uploadImage();
//                 }else{
//                   Fluttertoast.showToast(msg: "Please upload report first");
//                 }
//               }
//           ),
//
//           SizedBox(height: 20,),
//
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.teal,
//         onPressed: getImage,
//         child: Icon(Icons.add_a_photo),
//       ),
//     );
//   }
// }
//
// class UPLOADPDF extends StatelessWidget {
//   const UPLOADPDF({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//     );
//   }
// }
