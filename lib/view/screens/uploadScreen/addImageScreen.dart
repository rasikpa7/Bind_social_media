import 'dart:typed_data';
import 'dart:ui';

import 'package:bind/model/user.dart';
import 'package:bind/provider/user_provider.dart';
import 'package:bind/resources/firestore_methods.dart';
import 'package:bind/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';



class AddImageScreen extends StatefulWidget {
  const AddImageScreen({Key? key}) : super(key: key);

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {

  bool isLoading=false;


Uint8List? _file;
final TextEditingController _descriptionController =TextEditingController();
 void postImage(
  String uid,
  String username,
  String profImage
 )async{
  setState(() {
    isLoading=true;
  });
  try{

    String res= await FireStoreMethods().uploadPost(_descriptionController.text, _file!, uid, username, profImage);

    if(res=='success'){
       setState(() {
      
      isLoading=false;
    });
      showSnackBarr('Posted !', context);
      clearImage();
    }
    else{
      showSnackBarr(res, context);
    }
   
  }catch(e){
    showSnackBarr(e.toString(), context);
    
  }

 }


  _selectImage(BuildContext context)async{
    return showDialog(context: context, builder: (context){
               
               return SimpleDialog(
                title: const Text('Create a Post'),
                children: [
                  SimpleDialogOption(
                    padding: EdgeInsets.all(20),
                    child: const Text('Take a photo'),
                    onPressed: ()async{
                      Navigator.of(context).pop();
                      Uint8List file= await pickImage(ImageSource.camera);
                       setState(() {
                         _file=file;
                       });
                    },
                  )
                  ,
                     SimpleDialogOption(
                    padding: EdgeInsets.all(20),
                    child: const Text('Choose from gallery'),
                    onPressed: ()async{
                      Navigator.of(context).pop();
                      Uint8List file= await pickImage(ImageSource.gallery );
                       setState(() {
                         _file=file;
                       });
                    },
                  ),

                   SimpleDialogOption(
                    padding: EdgeInsets.all(20),
                    child: const Text('Cancel'),
                    onPressed: (){
                      Navigator.of(context).pop();
                    
                    },
                  )
                ],

               );

    });
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }
 
 void clearImage(){
  setState(() {
    _file=null;
  });
 }





  @override
Widget build(BuildContext context) {

  final User? user =Provider.of<UserProvider>(context).getUser;

    return _file==null?

    Column(mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset('lib/model/assets/uploadImage.json'),
          // Lottie.network('https://assets2.lottiefiles.com/packages/lf20_GxMZME.json',
          // onLoaded: (p0) => const CircularProgressIndicator(),),
           Center(child: IconButton(onPressed: ()=>_selectImage(context), icon: const Icon(Icons.upload,size: 40,))),
           Text('UPLOAD POST',
           style: GoogleFonts.openSans())
      
      ],
    ):
    
     Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.black,
        leading: IconButton(onPressed: () {
          clearImage();
        }, icon: Icon(Icons.arrow_back_ios)),
        title: Text('Post to'),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () {
                postImage(user!.uid!, user.username!, user.photoUrl!);
              },
              child: const Text(
                'Post',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ))
        ],
      ),

      body: Column(
        children: [
          isLoading?const  LinearProgressIndicator(
            
          ):
         
          Divider(),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage:
                CachedNetworkImageProvider(user!.photoUrl.toString()),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width*0.5,
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Write a caption',hintStyle:TextStyle(color: Colors.grey) ,
                    border: 
                    InputBorder.none,
                    
                  ),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45.h,
                width: 45.h,
                child: AspectRatio(aspectRatio: 487/451,
                child: Container(
                  decoration: BoxDecoration(
               image: DecorationImage(image: MemoryImage(_file!))
                  ),
                ),
                ),
              )
            ],
          )
        ],

      ),
    );
  }
}
