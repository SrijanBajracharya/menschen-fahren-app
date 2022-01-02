import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_menschen_fahren/routes_name.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends StatefulBasePage<Profile> {
  _ProfileState() : super(true);

  @override
  Widget buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 0),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      UiHelper.getCircleAvatarWithCameraDefault(assetName: 'assets/images/nepal.jpg',onIconClick: ()=>onCameraPress() ),
                      UiHelper.buildCenterTitle(title: 'Hi Sir David'),
                      UiHelper.buildButtonDefault(buttonText: 'Edit Profile', onPressedFunc: ()=> onEditPress()),
                      UiHelper.buildDivider(),
                      UiHelper.buildIconInfo(Icons.transgender,null,'29 M'),
                      UiHelper.buildIconInfo(Icons.work, 'Works at','Achievers'),
                      UiHelper.buildIconInfo(Icons.home, 'From','Lalitpur, Nepal'),
                      UiHelper.buildIconInfo(Icons.add_location_alt, 'Lives in','Frankfurt, Germany'),
                      UiHelper.buildIconInfo(Icons.local_phone_rounded, null, '9843323232323'),
                      UiHelper.buildIconInfo(Icons.email,null,'abc@gmail.com'),
                      UiHelper.buildDivider(),
                      UiHelper.buildDescriptionBlock(descText: "I am ambitious and driven. I thrive on challenge and constantly set goals for myself, so I have something to strive toward. I am not comfortable with settling, and I am always looking for an opportunity to do better and achieve greatness. In my previous role, I was promoted three times in less than two years."),
                      UiHelper.buildDivider(),
                      UiHelper.buildDescriptionBlock(descText: "I am ambitious and driven. I thrive on challenge and constantly set goals for myself, so I have something to strive toward. I am not comfortable with settling, and I am always looking for an opportunity to do better and achieve greatness. In my previous role, I was promoted three times in less than two years."),
                    ],
                  ),
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                //Positioned
              ], //<Widget>[]
            ), //Stack
          )
      )
    );

  }

  void onEditPress(){
    Navigator.pushReplacementNamed(context, RoutesName.EDIT_PROFILE);
  }

  void onCameraPress(){
    print('Camera am pressed ');
  }

  @override
  String getTitle(BuildContext context) {
    return "Profile";
  }
}
