import 'package:bind/model/user.dart';
import 'package:bind/model/utils/const.dart';
import 'package:bind/resources/auth_methods.dart';
import 'package:bind/view/screens/loginScreen/logInScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class drawer extends StatelessWidget {
  User snap;
  drawer({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: NetworkImage(snap.photoUrl!), fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    snap.username!.toUpperCase(),
                    style:  TextStyle(color: Colors.white, fontSize: 25.sp),
                  ),
                  Text(
                    snap.email!.toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 15.sp),
                  ),
                ],
              )),
          ListTile(
            leading: const CircleAvatar(
          child: Icon(
            Icons.policy,
          ),
            ),
            title: const Text('Privacy Policy'),
            onTap: ()async {
         await  showDialog(context: context, builder: (BuildContext context) {
            return drawerContents().PrivacyPolicyAlert(context);
          }

          );

           
          Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const CircleAvatar(
          child: Icon(
            Icons.check_box,
          ),
            ),
            title: const Text('Terms and Conditions'),
             onTap: ()async {
         await  showDialog(context: context, builder: (BuildContext context) {
            return drawerContents().TermsAndCondition(context);
          }

          );

           
          Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const CircleAvatar(
          child: Icon(Icons.person),
            ),
            title: const Text('Contact Developer'),
            onTap: ()async {
            await  showDialog(context: context, builder: (BuildContext context) {
            return drawerContents().contactDeveloperAlert(context);
          });
          Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const CircleAvatar(
          child: Icon(Icons.info),
            ),
            title: const Text('About Bind'),
            onTap: ()async {
          showAboutDialog(
              context: context,
              applicationIcon: const Icon(Icons.message),
              applicationName: 'Bind Messenger',
              applicationVersion: '1.0.0.1');

          // Navigator.pop(context);
            },
          ),
       
        ],
      ),
    );
  }


}
