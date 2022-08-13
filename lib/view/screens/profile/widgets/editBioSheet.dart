
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../controller/user_provider.dart';

class EditBioSheet extends StatelessWidget {
  TextEditingController editBioController = TextEditingController();
  EditBioSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 250,
      left: 5,right: 5),
      color: const Color(0xFF737373),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        height: 150,
        child: Column(
          
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              'Add Bio',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: TextFormField(
                      controller: editBioController,
                        decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'add you bio here',
                    )))),
                    Container(width: double.infinity,
                      child: Consumer<UserProvider>(
                        builder: (context, value, child) => 
                        ElevatedButton(onPressed: ()async{
                         await  value.editBio(context, editBioController.text);
                         Navigator.of(context).pop();
                        }, child: Text('Submit')),
                      ))
          ],
        ),
      ),
    );
  }
}
