import 'dart:typed_data';
import 'dart:ui';

import 'package:bind/model/user.dart';
import 'package:bind/provider/user_provider.dart';
import 'package:bind/resources/firestore_methods.dart';
import 'package:bind/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../resources/auth_methods.dart';

class AddImageScreen extends StatefulWidget {
  const AddImageScreen({Key? key}) : super(key: key);

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {

Uint8List? _file;
final TextEditingController _descriptionController =TextEditingController();
 void postImage(
  String uid,
  String username,
  String profImage
 )async{
  try{

    String res= await FireStoreMethods().uploadPost(_descriptionController.text, _file!, uid, username, profImage);

    if(res=='success'){
      showSnackBarr('Posted !', context);
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






  @override
Widget build(BuildContext context) {

  final User? user =Provider.of<UserProvider>(context).getUser;

    return _file==null?

    Center(
      child: IconButton(onPressed: ()=>_selectImage(context), icon: const Icon(Icons.upload)),
    ):
    
     Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.black,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        title: Text('Post to'),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () {
                postImage(user!.uid, user.username, user.photoUrl!);
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
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage:
                NetworkImage(user!.photoUrl.toString()),
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
