// part of 'pages.dart';

// class EditProfilePage extends StatefulWidget {
//   final User user;

//   EditProfilePage(this.user);

//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confrimPasswordController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     nameController.text = widget.user.name;
//     emailController.text = widget.user.email;
//     passwordController.text = 'yourPassword';
//     confrimPasswordController.text = 'yourPassword';
//   }

//   @override
//   Widget build(BuildContext context) {
//     context
//         .bloc<ThemeBloc>()
//         .add(ChangeTheme(ThemeData(primaryColor: accentColor1)));
//     return WillPopScope(
//       onWillPop: () async {
//         context.bloc<PageBloc>().add(GoToProfilePage());
//         return;
//       },
//       child: Scaffold(
//         body: BlocBuilder<UserBloc, UserState>(
//           builder: (_, userState) => Container(
//             margin: EdgeInsets.symmetric(horizontal: defaultMargin),
//             child: ListView(
//               children: <Widget>[
//                 Column(
//                   children: <Widget>[
//                     // ** Header **
//                     Container(
//                       margin: EdgeInsets.only(top: 20, bottom: 22),
//                       height: 56,
//                       child: Stack(
//                         children: <Widget>[
//                           Align(
//                             alignment: Alignment.topLeft,
//                             child: GestureDetector(
//                               onTap: () async {
//                                 context.bloc<PageBloc>().add(GoToProfilePage());
//                                 return;
//                               },
//                               child: Container(
//                                 width: 24,
//                                 height: 24,
//                                 child: Icon(Icons.arrow_back),
//                               ),
//                             ),
//                           ),
//                           Center(
//                             child: Text('Edit Your\nProfile',
//                                 style: blackTextFont.copyWith(fontSize: 20),
//                                 textAlign: TextAlign.center),
//                           ),
//                         ],
//                       ),
//                     ),

//                     // ** User Picture **
//                     Center(
//                       child: Container(
//                         width: 90,
//                         height: 104,
//                         child: Stack(
//                           children: <Widget>[
//                             Container(
//                               width: 90,
//                               height: 90,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: ((userState as UserLoaded)
//                                                   .user
//                                                   .profilePicture !=
//                                               '' ||
//                                           null)
//                                       ? NetworkImage((userState as UserLoaded)
//                                           .user
//                                           .profilePicture)
//                                       : AssetImage('assets/user_pic.png'),
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.bottomCenter,
//                               child: GestureDetector(
//                                 onTap: () async {},
//                                 child: Container(
//                                   width: 28,
//                                   height: 28,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     image: DecorationImage(
//                                       fit: BoxFit.cover,
//                                       image: ((userState as UserLoaded)
//                                                       .user
//                                                       .profilePicture !=
//                                                   '' ||
//                                               null)
//                                           ? AssetImage(
//                                               'assets/btn_del_photo.png')
//                                           : AssetImage(
//                                               'assets/btn_add_photo.png'),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     SizedBox(
//                       height: 36,
//                     ),

//                     // ** Name TextField **
//                     Container(
//                       margin: EdgeInsets.only(bottom: 16),
//                       child: TextField(
//                         controller: nameController,
//                         decoration: InputDecoration(
//                           labelText: 'Full Name',
//                           hintText: 'Full Name',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),

//                     // ** Email TextField **
//                     Container(
//                       margin: EdgeInsets.only(bottom: 16),
//                       child: TextField(
//                         enabled: false,
//                         controller: emailController,
//                         decoration: InputDecoration(
//                           labelText: 'Email Address',
//                           hintText: 'Email Address',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),

//                     // ** Password TextField **
//                     Container(
//                       margin: EdgeInsets.only(bottom: 16),
//                       child: TextField(
//                         obscureText: true,
//                         controller: passwordController,
//                         decoration: InputDecoration(
//                           labelText: 'Password',
//                           hintText: 'Password',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),

//                     // ** Confirm Password TextField **
//                     Container(
//                       margin: EdgeInsets.only(bottom: 30),
//                       child: TextField(
//                         obscureText: true,
//                         controller: passwordController,
//                         decoration: InputDecoration(
//                           labelText: 'Confirm Password',
//                           hintText: 'Confirm Password',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),

//                     // ** Button
//                     Container(
//                       width: 250,
//                       height: 45,
//                       child: RaisedButton(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         textColor: Colors.white,
//                         color: Color(0xFF3E9D9D),
//                         child: Text('Update My Profile'),
//                         onPressed: () async {},
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//              Try code from Assets

part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController;
  String profilePath;
  bool isDataEdited = false;
  File profileImageFile;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    profilePath = widget.user.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToProfilePage());

        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Edit Your\nProfile",
                        textAlign: TextAlign.center,
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 22, bottom: 10),
                        width: 90,
                        height: 104,
                        child: Stack(
                          children: <Widget>[
                            Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: (profileImageFile != null)
                                            ? FileImage(profileImageFile)
                                            : (profilePath != "")
                                                ? NetworkImage(profilePath)
                                                : AssetImage(
                                                    "assets/user_pic.png"),
                                        fit: BoxFit.cover))),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () async {
                                  if (profilePath == "") {
                                    profileImageFile = await getImage();

                                    if (profileImageFile != null) {
                                      profilePath = (profileImageFile.path);
                                    }
                                  } else {
                                    profileImageFile = null;
                                    profilePath = "";
                                  }

                                  setState(() {
                                    isDataEdited =
                                        (nameController.text.trim() !=
                                                    widget.user.name ||
                                                profilePath !=
                                                    widget.user.profilePicture)
                                            ? true
                                            : false;
                                  });
                                },
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage((profilePath == "")
                                              ? "assets/btn_add_photo.png"
                                              : "assets/btn_del_photo.png"))),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      AbsorbPointer(
                        child: TextField(
                          controller:
                              TextEditingController(text: widget.user.id),
                          style: whiteNumberFont.copyWith(color: accentColor3),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "User ID",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      AbsorbPointer(
                        child: TextField(
                          controller:
                              TextEditingController(text: widget.user.email),
                          style: greyTextFont,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Email Address",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: nameController,
                        onChanged: (text) {
                          setState(() {
                            isDataEdited = (text.trim() != widget.user.name ||
                                    profilePath != widget.user.profilePicture)
                                ? true
                                : false;
                          });
                        },
                        style: blackTextFont,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Full Name",
                            hintText: "Full Name"),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 250,
                        height: 45,
                        child: RaisedButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  MdiIcons.alertCircle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Change Password",
                                  style: whiteTextFont.copyWith(
                                      fontSize: 16,
                                      color: (isUpdating)
                                          ? Color(0xFFBEBEBE)
                                          : Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  MdiIcons.alertCircle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                            disabledColor: Color(0xFFE4E4E4),
                            color: Colors.red[400],
                            onPressed: (isUpdating)
                                ? null
                                : () async {
                                    await AuthServices.resetPassword(
                                        widget.user.email);

                                    Flushbar(
                                      duration: Duration(milliseconds: 2000),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Color(0xFFFF5C83),
                                      message:
                                          "The link to change your password has been sent to your email.",
                                    )..show(context);
                                  }),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      (isUpdating)
                          ? SizedBox(
                              width: 50,
                              height: 50,
                              child: SpinKitFadingCircle(
                                color: Color(0xFF3E9D9D),
                              ),
                            )
                          : SizedBox(
                              width: 250,
                              height: 45,
                              child: RaisedButton(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    "Update My Profile",
                                    style: whiteTextFont.copyWith(
                                        fontSize: 16,
                                        color: (isDataEdited)
                                            ? Colors.white
                                            : Color(0xFFBEBEBE)),
                                  ),
                                  disabledColor: Color(0xFFE4E4E4),
                                  color: Color(0xFF3E9D9D),
                                  onPressed: (isDataEdited)
                                      ? () async {
                                          setState(() {
                                            isUpdating = true;
                                          });

                                          if (profileImageFile != null) {
                                            profilePath = await uploadImage(
                                                profileImageFile);
                                          }

                                          context.bloc<UserBloc>().add(
                                              UpdateData(
                                                  name: nameController.text,
                                                  profileImage: profilePath));

                                          context
                                              .bloc<PageBloc>()
                                              .add(GoToProfilePage());
                                        }
                                      : null),
                            )
                    ],
                  )
                ],
              ),
            ),
            SafeArea(
                child: Container(
              margin: EdgeInsets.only(top: 20, left: defaultMargin),
              child: GestureDetector(
                onTap: () {
                  context.bloc<PageBloc>().add(GoToProfilePage());
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
