import 'package:project_menschen_fahren/helper/date_helper.dart';
import 'package:project_menschen_fahren/models/button_color.dart';
import 'package:project_menschen_fahren/models/button_type.dart';
import 'package:project_menschen_fahren/models/user_profile_response.dart';
import 'package:project_menschen_fahren/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_menschen_fahren/providers/authentication_token_provider.dart';
import 'package:project_menschen_fahren/providers/user_service.dart';
import 'package:project_menschen_fahren/routes_name.dart';
import 'package:project_menschen_fahren/widgets/components/custom_button.dart';
import 'package:project_menschen_fahren/widgets/components/helper/ui_helper.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {

  final String? userId;

  Profile({Key? key, this.userId}):super();

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends StatefulBasePage<Profile> {
  _ProfileState() : super(showHamburgerMenu: true, currentIndex: 4,showNotification: false);

  Future<UserProfileResponse>? _userProfile;

  @override
  void initState() {

    _userProfile = _getUserProfile();

    super.initState();
  }


  @override
  Widget buildContent(BuildContext context) {
    return FutureBuilder<UserProfileResponse>(
      future: _userProfile,
      builder: (BuildContext context, AsyncSnapshot<UserProfileResponse> snapshot) {
        if(snapshot.hasData) {
          return _buildProfile(context, snapshot.data!);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(context, snapshot.error);
        } else {
          return _buildLoadingWidget(context);
        }
      },
    );

  }

  /* Builds the widget shown while the Approvals are loading. */
  Widget _buildLoadingWidget(BuildContext context) {

    return Center(
      child: Column(children: [
        const SizedBox(
          child: CircularProgressIndicator(),
          height: 80,
          width: 80,
        ),
        // Show a loading text
        Text('Loading')
      ],
      ),
    );
  }

  /* Widget show in case of an error. */
  Widget _buildErrorWidget(BuildContext context, Object? error) {

    return Center(
      // TODO better text
      child: Text("Error: " + error!.toString()),
    );
  }

  Widget _buildProfile(BuildContext context, UserProfileResponse userProfile){
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
                        UiHelper.buildCenterTitle(title: '${userProfile.user.firstName} ${userProfile.user.lastName}'),
                        (widget.userId ==null)?Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomButton(buttonText: 'Edit', onPressedFunc: ()=>onEditPress(userProfile), buttonType: ButtonType.OUTLINE,),
                            CustomButton(buttonText: 'Friends', onPressedFunc: ()=>onFriendPress(), buttonType: ButtonType.OUTLINE,),
                          ],
                        ):Container(),

                        UiHelper.buildDivider(),
                        UiHelper.buildIconInfo(Icons.transgender,null,'${DateHelper.findDateDifference(DateTime.parse(userProfile.dateOfBirth!)).years} ${userProfile.gender}'),
                        //UiHelper.buildIconInfo(Icons.work, 'Works at','Achievers'),
                        UiHelper.buildIconInfo(Icons.home, 'From','${userProfile.country}'),
                        UiHelper.buildIconInfo(Icons.add_location_alt, 'Lives in','${userProfile.address}'),
                        UiHelper.buildIconInfo(Icons.local_phone_rounded, null, '${userProfile.phoneNumber}'),
                        UiHelper.buildIconInfo(Icons.email,null,'${userProfile.user.email}'),
                        UiHelper.buildDivider(),
                        UiHelper.buildTitle(title: 'About me'),
                        UiHelper.buildDescriptionBlock(descText: '${userProfile.description}'),
                        UiHelper.buildDivider(),
                        UiHelper.buildTitle(title: 'My Experience'),
                        UiHelper.buildDescriptionBlock(descText: '${userProfile.experiences}'),
                        UiHelper.buildDivider(),
                        UiHelper.buildTitle(title: 'Hobbies'),
                        UiHelper.buildDescriptionBlock(descText: '${userProfile.hobbies}'),
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

  Future<UserProfileResponse> _getUserProfile() async{

    try {
      AuthenticationTokenProvider tokenProvider = Provider.of<
          AuthenticationTokenProvider>(context, listen: false);

      UserService service = UserService();

      String? authenticationToken = await tokenProvider.getBearerToken();

      if (authenticationToken != null) {
        final UserProfileResponse userProfile;
        if(widget.userId != null){
          userProfile = await service.getUserProfileByUserId(authenticationToken,widget.userId!,  false);
        }else{
          userProfile = await service.getUserProfile(authenticationToken,  false);
        }

        print('$userProfile  ussssssss');
        return userProfile;
      } else {
        return Future.error(
            "Error loading authentication token. Please log in again.");
      }
    }catch(error){
      return Future.error(
          "Exception occurred $error.");
    }
  }

  void onEditPress(UserProfileResponse userProfile){
    print("I am pressed");
    Navigator.pushReplacementNamed(context, RoutesName.EDIT_PROFILE,arguments: userProfile);
  }

  void onFriendPress(){
    Navigator.pushReplacementNamed(context, RoutesName.FRIENDS);
  }

  void onCameraPress(){
    print('Camera am pressed ');
  }

  @override
  String getTitle(BuildContext context) {
    return "Profile";
  }
}
