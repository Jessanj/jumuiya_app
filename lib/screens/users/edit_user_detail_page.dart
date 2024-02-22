import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jumuiya_app/Helpers/api_URL.dart';
import 'package:jumuiya_app/models/user.dart';
import 'package:jumuiya_app/screens/members_page.dart';

import '../../Helpers/api_services.dart';
import '../../util/app_colors.dart';
import '../../util/app_layouts.dart';
import '../../util/constants.dart';
import '../../widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

String API_URL = ApiConstants.baseUrl+ ApiConstants.updateProfileImage;
const String API_KEY = 'your_api_key';

class EditUserDetailPage extends StatefulWidget {
  final UserModel userData;
  const EditUserDetailPage(this.userData, {super.key});

  @override
  State<EditUserDetailPage> createState() => _EditUserDetailPageState();
}

class _EditUserDetailPageState extends State<EditUserDetailPage> {

  @override
  void initState() {
    // TODO: implement initState
    first_name.text = widget.userData.first_name;
    middle_name.text = widget.userData.middle_name;
    last_name.text = widget.userData.last_name;
    NIN.text = widget.userData.nida!;
    email.text = widget.userData.email;
    phone1.text = widget.userData.phone;
    address.text = widget.userData.address;

  }

  final GlobalKey<FormState>  editMemberForm = GlobalKey<FormState>();
  late var first_name = TextEditingController();
  late var last_name = TextEditingController();
  late var middle_name = TextEditingController();
  late var phone1 = TextEditingController();
  late var  phone2 = TextEditingController();
  late var  email = TextEditingController();
  late var NIN = TextEditingController();
  late var address = TextEditingController();
  XFile? pickedImage;

  _saveMember() {
    var memberDetail =  Map<String, dynamic>();
    memberDetail['id'] = widget.userData.id;
    memberDetail['jumuiya_name'] =
    memberDetail['first_name'] = first_name.text;
    memberDetail['last_name'] = last_name.text;
    memberDetail['middle_name'] = middle_name.text;
    memberDetail['phone1'] = phone1.text;
    memberDetail['phone2'] = phone2.text;
    memberDetail['email'] = email.text;
    memberDetail['NIN'] = NIN.text;
    memberDetail['address'] = address.text;
    print(memberDetail);
    var response = ApiService.updateUser(memberDetail);
    // print(response.toString() + "context101");

    if(response.toString() == 'true'){
      Navigator.of(context).pop(AlertDialog);

    }else{
      // Navigator.pop(context);
      // return response;
    }
    return response;

  }

  Uint8List? _image;
  XFile? _getFile;
   pickImage(ImageSource source) async {
    try {
      final ImagePicker _imagePicker = ImagePicker();
      XFile? _file = await _imagePicker.pickImage(source: source);


      if(_file != null){
        return await _file;
      }
      print('No Images Selected');
    } catch (e) {
      print(e); // Handle errors gracefully, e.g., show a snackbar
    }
  }

  void selectImage() async {
    _getFile  = await pickImage(ImageSource.gallery);
    Uint8List? img = await _getFile?.readAsBytes();
    setState(() {
      _image = img;
    });
  }

  void uploadImage() async {
    if (_image == null) {
      print('No image selected!');
      return;
    }

    try {
      var file_length = await  _getFile!.length();
      final stream = new http.ByteStream(_getFile!.openRead());
      stream.cast();
      print(Uri.parse(API_URL));
      print(file_length);
      var bytes = await _getFile!.readAsBytes();
      final request = http.MultipartRequest('POST', Uri.parse(API_URL));
      request.headers['Content-Type'] = 'application/json'; // Set your API key if needed
      var multport = http.MultipartFile.fromBytes('image', bytes);
      request.files.add(multport);
      request.fields['id'] = widget.userData.id.toString();
      final response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
      } else {
        print('Error uploading image: ${response.statusCode}');
        // Handle the error appropriately
      }
    } catch (e) {
      print(e); // Log or handle errors
    }
  }

  @override
  Widget build(BuildContext context) {

    final size  = AppLayouts.getSize(context);

    showLoaderDialog(BuildContext context){
      AlertDialog alert=AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            Container(margin: const EdgeInsets.only(left: 10),child: const Text("Loading..." )),
          ],),
      );

      showDialog(barrierDismissible: false,
        context:context,
        builder:(BuildContext context){
          return alert;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: Text(AppLocalizations.of(context)!.edit_user_detail),
      ),
      body: ListView(
    padding:  const  EdgeInsets.only(left: 20 , right: 20),
    scrollDirection: Axis.vertical,
    children:[
    const Gap(10),
    Form(
    key:editMemberForm ,
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        height: 100,
        child:   Stack(
          children: [
            _image != null
                ? CircleAvatar(
              radius: 64,
              backgroundImage: MemoryImage(_image!),
            )
                :  widget.userData.profile_image.toString() == 'null' ?
                const CircleAvatar(radius: 64, backgroundImage:  AssetImage('assets/images/avatorProfile.png')) :
                 CircleAvatar(radius: 64,
        backgroundImage: NetworkImage(widget.userData.profile_image.toString()),
    ),
            Positioned(
              bottom: -10,
              left: 80,
              child: IconButton(
                onPressed: selectImage,
                icon: const Icon(Icons.add_a_photo),
              ),
            ),
          ],
        ),
      ),
    _image != null ?
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: (){
            uploadImage();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.upload, color: Colors.white),
              Text('Upload Image' , style: TextStyle(color: Colors.white),),
              const Gap(4),
            ],
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            padding: MaterialStateProperty.all(EdgeInsets.all(6)),
          ),
        ),
      ],
    ) :
    const Gap(20),
    Padding(
    padding: const EdgeInsets.only( bottom: 20 , top: 20),
    child: TextFormField(
      enabled: false,
    decoration: AppConstants.inputDecorationLogin.copyWith(
    labelText: 'National Identity Number' ,
    hintText: 'Enter NIN Number ',
    ),
    validator: (value) {
    if(value == null || value.trim() == ""){
    return "NIN cannot be null";
    }
    return null;
    },
    controller: NIN,
    ),
    ),
    Padding(
    padding: const EdgeInsets.only( bottom: 20),
    child: TextFormField(
    scrollPadding: EdgeInsets.only(bottom:100),
    decoration: AppConstants.inputDecorationForms.copyWith(
    labelText: 'First Name',
    hintText: 'Enter members first name',
    ),
    validator: (value) {
    if (value == null || value == "") {
    return "First name cannot be null.";
    }
    return null;
    },
    controller: first_name,
    ),
    ),
    Padding(
    padding: const EdgeInsets.only( bottom: 20),
    child: TextFormField(
    scrollPadding: EdgeInsets.only(bottom:100),
    decoration:  AppConstants.inputDecorationForms.copyWith(
    labelText: 'Middle Name',
    hintText: 'Enter Members Middle Name',
    ),
    controller: middle_name,
    validator: (value) {
    if (value == null || value == "") {
    return "Middle name cannot be null.";
    }
    return null;
    },
    ),
    ),
    Padding(
    padding: const EdgeInsets.only( bottom: 20),
    child: TextFormField(
    scrollPadding: EdgeInsets.only(bottom:100),
    decoration: AppConstants.inputDecorationForms.copyWith(
    labelText: 'Last Name',
    hintText: 'Enter Members Last Name',
    ),
    controller: last_name,
    validator: (value) {
    if (value == null || value == "") {
    return "Last name cannot be null.";
    }
    return null;
    },
    ),
    ),

    Padding(
    padding: const EdgeInsets.only( bottom: 20),
    child: TextFormField(
    scrollPadding: EdgeInsets.only(bottom:100),
    decoration: AppConstants.inputDecorationForms.copyWith(
    labelText: 'Address/Location',
    hintText: 'Enter members address location',
    ),
    controller: address,
    validator: (value) {
    if (value == null || value == "") {
    return "Address/Location cannot be null.";
    }
    return null;
    },
    ),
    ),

    Padding(
    padding: const EdgeInsets.only( bottom: 20),
    child: TextFormField(
    scrollPadding: EdgeInsets.only(bottom:100),
    decoration: AppConstants.inputDecorationForms.copyWith(
    labelText: 'Email',
    hintText: 'Enter Members Email',
    ),
    controller: email,
    validator: (value) {
    if (value == null || value == "") {
    return "Email cannot be null.";
    }
    return null;
    },
    ),
    ),
    Padding(
    padding: const EdgeInsets.only( bottom: 10),
    child: TextFormField(
    scrollPadding: EdgeInsets.only(bottom:250),
    decoration: AppConstants.inputDecorationForms.copyWith(
    labelText: 'Phone Number',
    hintText: 'Enter Members Phonenumber',
    ),
    controller: phone1,
    validator: (value) {
    if (value == null || value == "") {
    return "Phonenumber cannot be null.";
    }
    return null;
    },
    ),
    ),
    ]),
    ),

    const Gap(15),

    Container(
    alignment: Alignment.center,
    child:  CustomButton(
    onTap: (){
    showLoaderDialog(context);
      _saveMember();
    },
    title: AppLocalizations.of(context)!.update,
    ),
    ),

    ],
    ),
    );
  }
}
