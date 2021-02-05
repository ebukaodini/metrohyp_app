import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:metrohyp/common.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ChoosePlan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChoosePlanState();
}

class ChoosePlanState extends State<ChoosePlan> {
  List<String> _countries = [];
  List<dynamic> _platforms;
  List<dynamic> _platformServices;
  List<dynamic> _platformServicePricing;

  CheckoutMethod _method = CheckoutMethod.card;

  String _platform = 'Facebook';
  dynamic _platformLogo = SvgPicture.asset(
    'assets/imgs/facebook.svg',
    width: 20.0,
  );
  Color _platformColor = Color.fromRGBO(59, 89, 152, 1.0);
  Color _metroColor = Color.fromRGBO(244, 163, 31, 1.0);
  // Color _metroColor2 = Color.fromRGBO(244, 163, 25, 1.0);

  String _selectedPlatform; // = 'facebook';
  String _selectedService; // = 'Likes';
  String _selectedServiceCount = '0';
  String _selectedServiceCost = '0';
  String _selectedCountry = 'Nigeria';

  String _requestedService;

  final _formKey = new GlobalKey<FormState>();
  final _formKey1 = new GlobalKey<FormState>();

  final _fname = new TextEditingController();
  final _lname = new TextEditingController();
  final _tel = new TextEditingController();
  final _email = new TextEditingController();
  final _link = new TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    // pull bio data from sharedpreference
    initiateBioData();

    // TODO: Get metrohyp paystack details
    PaystackPlugin.initialize(
        publicKey: 'pk_test_24c22a9f195e11266eef0cbc7cccbeb48e5cf584');

    String countries =
        '["Afghanistan","Åland Islands","Albania","Algeria","American Samoa","AndorrA","Angola","Anguilla","Antarctica","Antigua and Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Bosnia and Herzegovina","Botswana","Bouvet Island","Brazil","British Indian Ocean Territory","Brunei Darussalam","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Cape Verde","Cayman Islands","Central African Republic","Chad","Chile","China","Christmas Island","Cocos (Keeling) Islands","Colombia","Comoros","Congo","Congo, The Democratic Republic of the","Cook Islands","Costa Rica","Cote D\'Ivoire","Croatia","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Estonia","Ethiopia","Falkland Islands (Malvinas)","Faroe Islands","Fiji","Finland","France","French Guiana","French Polynesia","French Southern Territories","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guadeloupe","Guam","Guatemala","Guernsey","Guinea","Guinea-Bissau","Guyana","Haiti","Heard Island and Mcdonald Islands","Holy See (Vatican City State)","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran, Islamic Republic Of","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kiribati","Korea, Democratic People\'S Republic of","Korea, Republic of","Kuwait","Kyrgyzstan","Lao People\'S Democratic Republic","Latvia","Lebanon","Lesotho","Liberia","Libyan Arab Jamahiriya","Liechtenstein","Lithuania","Luxembourg","Macao","Macedonia, The Former Yugoslav Republic of","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands","Martinique","Mauritania","Mauritius","Mayotte","Mexico","Micronesia, Federated States of","Moldova, Republic of","Monaco","Mongolia","Montserrat","Morocco","Mozambique","Myanmar","Namibia","Nauru","Nepal","Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Niue","Norfolk Island","Northern Mariana Islands","Norway","Oman","Pakistan","Palau","Palestinian Territory, Occupied","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Pitcairn","Poland","Portugal","Puerto Rico","Qatar","Reunion","Romania","Russian Federation","RWANDA","Saint Helena","Saint Kitts and Nevis","Saint Lucia","Saint Pierre and Miquelon","Saint Vincent and the Grenadines","Samoa","San Marino","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia and Montenegro","Seychelles","Sierra Leone","Singapore","Slovakia","Slovenia","Solomon Islands","Somalia","South Africa","South Georgia and the South Sandwich Islands","Spain","Sri Lanka","Sudan","Suriname","Svalbard and Jan Mayen","Swaziland","Sweden","Switzerland","Syrian Arab Republic","Taiwan, Province of China","Tajikistan","Tanzania, United Republic of","Thailand","Timor-Leste","Togo","Tokelau","Tonga","Trinidad and Tobago","Tunisia","Turkey","Turkmenistan","Turks and Caicos Islands","Tuvalu","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States","United States Minor Outlying Islands","Uruguay","Uzbekistan","Vanuatu","Venezuela","Viet Nam","Virgin Islands, British","Virgin Islands, U.S.","Wallis and Futuna","Western Sahara","Yemen","Zambia","Zimbabwe"]';

    jsonDecode(countries).toList().forEach((country) {
      _countries.add(country.toString());
    });

    dynamic respbody =
        '[{"platform":"Facebook","services":[{"name":"Likes","pricing":[{"count":"100","price":"1000"},{"count":"200","price":"2000"},{"count":"300","price":"3000"},{"count":"400","price":"4000"},{"count":"500","price":"5000"}]},{"name":"Followers","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]},{"name":"Comments","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"100","price":"4000"}]},{"name":"Shares","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]},{"name":"Unlikes","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]},{"name":"Reposts","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]}]},{"platform":"Instagram","services":[{"name":"Likes","pricing":[{"count":"100","price":"1000"},{"count":"200","price":"2000"},{"count":"300","price":"3000"},{"count":"400","price":"4000"},{"count":"500","price":"5000"}]},{"name":"Followers","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]},{"name":"Comments","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"100","price":"4000"}]},{"name":"Shares","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]},{"name":"Reposts","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]}]},{"platform":"Twitter","services":[{"name":"Likes","pricing":[{"count":"100","price":"1000"},{"count":"200","price":"2000"},{"count":"300","price":"3000"},{"count":"400","price":"4000"},{"count":"500","price":"5000"}]},{"name":"Followers","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]},{"name":"Comments","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"100","price":"4000"}]},{"name":"Shares","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]},{"name":"Retweets","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]}]},{"platform":"Youtube","services":[{"name":"Likes","pricing":[{"count":"100","price":"1000"},{"count":"200","price":"2000"},{"count":"300","price":"3000"},{"count":"400","price":"4000"},{"count":"500","price":"5000"}]},{"name":"Subscribers","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]},{"name":"Comments","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"100","price":"4000"}]},{"name":"Shares","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]},{"name":"Unlikes","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]}]},{"platform":"Tiktok","services":[{"name":"Likes","pricing":[{"count":"100","price":"1000"},{"count":"200","price":"2000"},{"count":"300","price":"3000"},{"count":"400","price":"4000"},{"count":"500","price":"5000"}]},{"name":"Followers","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]},{"name":"Comments","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"100","price":"4000"}]},{"name":"Shares","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]},{"name":"Unlikes","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]},{"name":"Reposts","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]}]},{"platform":"Audiomack","services":[{"name":"Likes","pricing":[{"count":"100","price":"1000"},{"count":"200","price":"2000"},{"count":"300","price":"3000"},{"count":"400","price":"4000"},{"count":"500","price":"5000"}]},{"name":"Followers","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]},{"name":"Comments","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"100","price":"4000"}]},{"name":"Shares","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]},{"name":"Unlikes","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]},{"name":"Upvotes","pricing":[{"count":"25","price":"1000"},{"count":"50","price":"2000"},{"count":"75","price":"3000"},{"count":"100","price":"4000"}]}]}]';

    _platforms = jsonDecode(respbody);

    choosePlatform(_platforms[0]['platform'].toString().toLowerCase(), context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              expandedHeight: 150.0,
              pinned: true,
              snap: true,
              floating: true,
              backgroundColor: _platformColor,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  _platform,
                  style: TextStyle(color: _metroColor),
                ),
                centerTitle: true,
              ),
              title: Container(
                  width: MediaQuery.of(context).copyWith().size.width - 360,
                  child: Image.asset(
                    'assets/imgs/metrohyp_logo_128.png',
                    fit: BoxFit.contain,
                  )),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu, color: _metroColor),
                  tooltip: 'Select Platform',
                  onPressed: () {
                    _scaffoldKey.currentState.openEndDrawer();
                  },
                ),
              ]),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              width: MediaQuery.of(context).copyWith().size.width,
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: _platformColor,
                  border: Border.all(color: _platformColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _platformLogo,
                  Container(height: 10.0),
                  Text(
                      "Buy Likes, Comments and Views for $_platform on MetroHyp",
                      style: TextStyle(color: Colors.white))
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).copyWith().size.width,
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    // boxShadow: <BoxShadow>[BoxShadow(color: _platformColor)],
                    border: Border.all(color: _platformColor),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bio Data:',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            controller: _fname,
                            autocorrect: true,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(fontSize: 20.0),
                            decoration: InputDecoration(
                              hintText: 'John',
                              labelText: 'Enter Firstname',
                              labelStyle: TextStyle(color: _platformColor),
                              alignLabelWithHint: true,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _platformColor,
                                      style: BorderStyle.solid)),
                            ),
                            validator: ((value) {
                              if (value.isEmpty)
                                return 'Firstname cannot be empty';
                              return null;
                            }),
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            controller: _lname,
                            autocorrect: true,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(fontSize: 20.0),
                            decoration: InputDecoration(
                              hintText: 'Doe',
                              labelText: 'Enter Lastname',
                              labelStyle: TextStyle(color: _platformColor),
                              alignLabelWithHint: true,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _platformColor,
                                      style: BorderStyle.solid)),
                            ),
                            validator: ((value) {
                              if (value.isEmpty)
                                return 'Lastname cannot be empty';
                              return null;
                            }),
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            controller: _tel,
                            autocorrect: true,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(fontSize: 20.0),
                            decoration: InputDecoration(
                              hintText: '+234',
                              labelText: 'Enter Telephone',
                              labelStyle: TextStyle(color: _platformColor),
                              alignLabelWithHint: true,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _platformColor,
                                      style: BorderStyle.solid)),
                            ),
                            validator: ((value) {
                              if (value.isEmpty)
                                return 'Telephone cannot be empty';
                              if (!RegExp(r"^[0-9-+()]+$").hasMatch(value))
                                return 'Enter a valid telephone number';
                              return null;
                            }),
                          )),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            controller: _email,
                            autocorrect: true,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(fontSize: 20.0),
                            decoration: InputDecoration(
                              hintText: 'johndoe@mail.com',
                              labelText: 'Enter Email',
                              labelStyle: TextStyle(color: _platformColor),
                              alignLabelWithHint: true,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _platformColor,
                                      style: BorderStyle.solid)),
                            ),
                            validator: ((value) {
                              if (value.isEmpty)
                                return 'Telephone cannot be empty';
                              EmailValidator(
                                      errorText: 'Enter a valid email address')
                                  .call(value);

                              return null;
                            }),
                          )),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          width: MediaQuery.of(context).copyWith().size.width,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: _platformColor,
                                      style: BorderStyle.solid))),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return renderCountries();
                                },
                              );
                            },
                            child: Text(
                              _selectedCountry ?? 'Select Country',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 20.0, color: _platformColor),
                            ),
                          )),
                    ],
                  ),
                )),
            Container(
              width: MediaQuery.of(context).copyWith().size.width,
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: _platformColor),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Service:',
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      width: MediaQuery.of(context).copyWith().size.width,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: _platformColor,
                                  style: BorderStyle.solid))),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return renderPlatformServices();
                            },
                          );
                        },
                        child: Text(
                          _selectedService ?? 'Select $_platform Service',
                          textAlign: TextAlign.start,
                          style:
                              TextStyle(fontSize: 20.0, color: _platformColor),
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      width: MediaQuery.of(context).copyWith().size.width,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: _platformColor,
                                  style: BorderStyle.solid))),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return renderPlatformServiceAmount();
                            },
                          );
                        },
                        child: Text(
                          _requestedService ?? 'How Many $_selectedService',
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style:
                              TextStyle(fontSize: 20.0, color: _platformColor),
                        ),
                      )),
                  Form(
                      key: _formKey1,
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: TextFormField(
                            controller: _link,
                            autocorrect: true,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(fontSize: 20.0),
                            decoration: InputDecoration(
                              hintText: 'https://...',
                              labelText: 'Enter Account Username/Link',
                              labelStyle: TextStyle(color: _platformColor),
                              alignLabelWithHint: true,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: _platformColor,
                                      style: BorderStyle.solid)),
                            ),
                            validator: ((value) {
                              if (value.isEmpty)
                                return 'Username/Link cannot be empty';
                              return null;
                            }),
                          ))),
                ],
              ),
            ),
            Container(height: 10.0),
            FlatButton(
                onPressed: () async {
                  var vresp = _formKey.currentState.validate();
                  var vresp1 = _formKey1.currentState.validate();
                  if (vresp && vresp1) {
                    // get values
                    String firstname = _fname.text;
                    String lastname = _lname.text;
                    String telephone = _tel.text;
                    String email = _email.text;
                    String link = _link.text;

                    // store redundant values in sharedpreference
                    final SharedPreferences prefs = await _prefs;
                    prefs.setString('firstname', firstname);
                    prefs.setString('lastname', lastname);
                    prefs.setString('email', email);
                    prefs.setString('telephone', telephone);
                    prefs.setString('selectedCountry', _selectedCountry);

                    if (_selectedService == null) {
                      error(context,
                          'Please select a service for $_platform');
                      return;
                    }

                    if (int.parse(_selectedServiceCount) == 0 ||
                        int.parse(_selectedServiceCost) == 0) {
                      error(context,
                          'Please select your how much $_selectedService you want');
                      return;
                    }

                    // process payment $firstname $lastname $email $telephone
                    _handleCheckout(
                        context,
                        email,
                        (int.parse(_selectedServiceCost) * 100).toString(),
                        link);
                  } else {
                    error(context, 'Enter valid data');
                  }
                },
                color: _metroColor,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text('Pay', style: TextStyle(fontSize: 18.0))),
            Container(height: 20.0),
            Image.asset('assets/imgs/paystack.png')
          ])),
        ],
      ),
      endDrawer: Drawer(
          // Odini Software
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  Center(
                      child: Image.asset('assets/imgs/metrohyp_logo.png',
                          width: 100.0, fit: BoxFit.contain)),
                  SizedBox(height: 30.0),
                  FlatButton(
                      onPressed: () {
                        // _scaffoldKey.currentState. closeEndDrawer();
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return renderSelectPlatforms();
                          },
                        );
                      },
                      color: Color(0xFFFDE7C6),
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.layers_rounded, size: 21.0),
                          SizedBox(width: 5),
                          Text('Select Platform',
                              style: TextStyle(fontSize: 20.0))
                        ],
                      )),
                  SizedBox(height: 15.0),
                  FlatButton(
                      onPressed: () {
                        contactUs();
                      },
                      color: Color(0xFFFDE7C6),
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.message_outlined, size: 20.0),
                          SizedBox(width: 5),
                          Text('Contact Us', style: TextStyle(fontSize: 20.0))
                        ],
                      )),
                  SizedBox(height: 15.0),
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        requestService();
                      },
                      color: Color(0xFFFDE7C6),
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.help_outline, size: 20.0),
                          SizedBox(width: 5),
                          Text('Request a Service',
                              style: TextStyle(fontSize: 20.0))
                        ],
                      )),
                  SizedBox(height: 15.0),
                  Container(
                    height: 1.0,
                    color: Colors.black,
                  ),
                  SizedBox(height: 15.0),
                  Text('Developed by'),
                  SizedBox(height: 2.0),
                  SvgPicture.asset(
                    'assets/imgs/odinisoftware.svg',
                    width: 120.0,
                  ),
                ],
              ))),
    ));
  }

  Future<void> requestService() async {
    final Email email = Email(
      body:
          'I will like to request and make enquiries for .............. Social Media Verification package. My handle is .............. and my contact number is ...............',
      subject: 'Requesting a Service',
      recipients: ['metrohypcom@gmail.com'],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      Navigator.pop(context);
      if (!mounted) return;
      success(context,
          'Your request was received. We will email or call you soon.');
    } catch (error) {
      if (!mounted) return;
      error(context, error.toString());
    }
  }

  Future<void> contactUs() async {
    final Email email = Email(
      body: '',
      subject: 'Contact Us',
      recipients: ['metrohypcom@gmail.com'],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      Navigator.pop(context);
      if (!mounted) return;
      success(context, 'Thank you for contacting us.');
    } catch (error) {
      if (!mounted) return;
      error(context, error.toString());
    }
  }

  initiateBioData() async {
    final SharedPreferences prefs = await _prefs;
    _fname.text = prefs.getString('firstname') ?? '';
    _lname.text = prefs.getString('lastname') ?? '';
    _tel.text = prefs.getString('telephone') ?? '';
    _email.text = prefs.getString('email') ?? '';
    setState(() =>
        _selectedCountry = prefs.getString('selectedCountry') ?? 'Nigeria');
  }

  Widget renderTextField(
      String hint, String label, TextEditingController controller,
      {int maxLength, dynamic validator, String initialValue}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
          controller: controller,
          // initialValue: '',
          autocorrect: true,
          maxLength: maxLength,
          maxLengthEnforced: maxLength != null,
          textInputAction: TextInputAction.next,
          style: TextStyle(fontSize: 20.0),
          decoration: InputDecoration(
            hintText: hint,
            labelText: label,
            labelStyle: TextStyle(color: _platformColor),
            alignLabelWithHint: true,
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: _platformColor, style: BorderStyle.solid)),
          ),
          validator: ((value) {
            if (validator != null) {
              return validator(value);
            }
            return null;
          }),
        ));
  }

  SimpleDialog renderSelectPlatforms() {
    return SimpleDialog(title: Text('Select Platform'), children: [
      SimpleDialogOption(
          onPressed: () {
            choosePlatform('facebook', context);
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/imgs/facebook.svg',
                    width: 20.0,
                  ),
                  Text('  Facebook'),
                ],
              ),
              _selectedPlatform == 'facebook' ? Icon(Icons.check) : Container()
            ],
          )),
      SimpleDialogOption(
          onPressed: () {
            choosePlatform('twitter', context);
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/imgs/twitter.svg',
                    width: 20.0,
                  ),
                  Text('  Twitter'),
                ],
              ),
              _selectedPlatform == 'twitter' ? Icon(Icons.check) : Container()
            ],
          )),
      SimpleDialogOption(
          onPressed: () {
            choosePlatform('instagram', context);
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/imgs/instagram.svg',
                    width: 20.0,
                  ),
                  Text('  Instagram'),
                ],
              ),
              _selectedPlatform == 'instagram' ? Icon(Icons.check) : Container()
            ],
          )),
      SimpleDialogOption(
          onPressed: () {
            choosePlatform('youtube', context);
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/imgs/youtube.svg',
                    width: 20.0,
                  ),
                  Text('  Youtube'),
                ],
              ),
              _selectedPlatform == 'youtube' ? Icon(Icons.check) : Container()
            ],
          )),
      SimpleDialogOption(
          onPressed: () {
            choosePlatform('tiktok', context);
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/imgs/tiktok.svg',
                    width: 20.0,
                  ),
                  Text('  TikTok'),
                ],
              ),
              _selectedPlatform == 'tiktok' ? Icon(Icons.check) : Container()
            ],
          )),
      SimpleDialogOption(
          onPressed: () {
            choosePlatform('audiomack', context);
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/imgs/audiomack.jpeg',
                    width: 20.0,
                  ),
                  Text('  Audiomack'),
                ],
              ),
              _selectedPlatform == 'audiomack' ? Icon(Icons.check) : Container()
            ],
          )),
    ]);
  }

  SimpleDialog renderPlatformServices() {
    List<SimpleDialogOption> options = [];
    _platformServices.forEach((service) {
      // print(service);
      options.add(renderPlatformServicesDialogOption(service.toString()));
    });

    return SimpleDialog(
        title: Text(
          'Select $_platform Services',
          textAlign: TextAlign.center,
        ),
        children: options);
  }

  SimpleDialog renderCountries() {
    List<SimpleDialogOption> options = [];
    _countries.forEach((country) {
      // print(service);
      options.add(renderCountriesDialogOption(country.toString()));
    });

    return SimpleDialog(
        title: Text(
          'Select Nationality',
          textAlign: TextAlign.center,
        ),
        children: options);
  }

  SimpleDialogOption renderCountriesDialogOption(String country) {
    return SimpleDialogOption(
        onPressed: () {
          setState(() => _selectedCountry = country);
          _requestedService = null;
          Navigator.pop(context);
        },
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: Text('$country',
                  overflow: TextOverflow.clip,
                  style: TextStyle(color: _platformColor))),
          _selectedCountry == country ? Icon(Icons.check) : Icon(null)
        ]));
  }

  SimpleDialog renderPlatformServiceAmount() {
    // print(_platformServicePricing);
    List<SimpleDialogOption> options = [];

    _platformServicePricing.toList().forEach((service) {
      if (service['name'] == _selectedService) {
        // print(service);
        service['pricing'].toList().forEach((pricing) {
          // print(pricing);
          options.add(renderPlatformServiceCostsDialogOption(
              '${pricing['count']}', '${pricing['price']}'));
        });
      }
    });

    return SimpleDialog(
        title: Text(
          'How many $_selectedService',
          textAlign: TextAlign.center,
        ),
        children: options);
  }

  SimpleDialogOption renderPlatformServicesDialogOption(String service) {
    IconData serviceIcon;
    switch (service) {
      case 'Likes':
        serviceIcon = Icons.thumb_up;
        break;
      case 'Followers':
      case 'Subscribers':
        serviceIcon = Icons.people_rounded;
        break;
      case 'Comments':
        serviceIcon = Icons.mode_comment_rounded;
        break;
      case 'Shares':
        serviceIcon = Icons.share;
        break;
      case 'Retweets':
      case 'Upvotes':
      case 'Reposts':
        serviceIcon = Icons.repeat_sharp;
        break;
      case 'Unlikes':
        serviceIcon = Icons.thumb_down;
        break;
      default:
        serviceIcon = Icons.thumb_up;
        break;
    }
    return SimpleDialogOption(
        onPressed: () {
          setState(() => _selectedService = service);
          _requestedService = null;
          Navigator.pop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('$service', style: TextStyle(color: _platformColor)),
            Icon(
              serviceIcon,
              color: _platformColor,
            ),
          ],
        ));
  }

  SimpleDialogOption renderPlatformServiceCostsDialogOption(
      String count, String price) {
    return SimpleDialogOption(
        onPressed: () {
          setState(() {
            _selectedServiceCount = count;
            _selectedServiceCost = price;
            _requestedService =
                '$_selectedServiceCount $_platform $_selectedService - NGN $_selectedServiceCost';
          });
          Navigator.pop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('$count $_selectedService',
                style: TextStyle(color: _platformColor)),
            Text('NGN $price', style: TextStyle(color: _platformColor))
          ],
        ));
  }

  choosePlatform(String platform, BuildContext context) {
    // for the icon
    setState(() {
      _selectedPlatform = platform;
      _requestedService = null;
    });

    switch (platform) {
      case 'facebook':
        setState(() {
          _platform = 'Facebook';
          _platformLogo = SvgPicture.asset(
            'assets/imgs/facebook.svg',
            width: 20.0,
          );
          _platformColor = Color.fromRGBO(52, 79, 137, 1.0);
          loadPlatformServices('Facebook');
        });
        break;
      case 'instagram':
        setState(() {
          _platform = 'Instagram';
          _platformLogo = SvgPicture.asset(
            'assets/imgs/instagram.svg',
            width: 20.0,
          );
          _platformColor = Color.fromRGBO(221, 42, 123, 1.0);
          loadPlatformServices('Instagram');
        });
        break;
      case 'twitter':
        setState(() {
          _platform = 'Twitter';
          _platformLogo = SvgPicture.asset(
            'assets/imgs/twitter.svg',
            width: 20.0,
          );
          _platformColor = Color.fromRGBO(73, 147, 203, 1.0);
          loadPlatformServices('Twitter');
        });
        break;
      case 'youtube':
        setState(() {
          _platform = 'Youtube';
          _platformLogo = SvgPicture.asset(
            'assets/imgs/youtube.svg',
            width: 20.0,
          );
          _platformColor = Color.fromRGBO(200, 7, 7, 1.0);
          loadPlatformServices('Youtube');
        });
        break;
      case 'tiktok':
        setState(() {
          _platform = 'TikTok';
          _platformLogo = SvgPicture.asset(
            'assets/imgs/tiktok.svg',
            width: 20.0,
          );
          _platformColor = Color.fromRGBO(163, 0, 49, 1.0);
          loadPlatformServices('Tiktok');
        });
        break;
      case 'audiomack':
        setState(() {
          _platform = 'Audiomack';
          _platformLogo = Image.asset(
            'assets/imgs/audiomack.jpeg',
            width: 20.0,
          );
          _platformColor = Color.fromRGBO(39, 33, 27, 1.0);
          loadPlatformServices('Audiomack');
        });
        break;
      default:
    }
  }

  void loadPlatformServices(String platform) {
    List<dynamic> services = [];
    List<dynamic> pricing = [];

    _platforms.toList().forEach((_platform) {
      if (_platform['platform'] == platform) {
        _platform['services'].toList().forEach((_service) {
          services.add(_service['name']);
          pricing.add(_service);
        });
      }
    });

    _platformServices = services;
    _platformServicePricing = pricing;
    _selectedService = _platformServices[0];
  }

  String _getReference(String userLink) {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return '$_selectedPlatform|$_selectedService|$_selectedServiceCount|$_selectedServiceCost|$userLink|$platform|${DateTime.now().millisecondsSinceEpoch}';
  }

  _handleCheckout(BuildContext context, String email, String amount,
      String userLink) async {
    Charge charge = Charge()
      ..amount = int.parse(amount) // In base currency
      ..email = email
      ..card = _getCardFromUI();

    charge.reference = _getReference(userLink);

    try {
      CheckoutResponse response = await PaystackPlugin.checkout(
        context,
        method: _method,
        charge: charge,
        fullscreen: true,
        logo: Image.asset(
          "assets/imgs/metrohyp_logo_128.png",
          width: 40.0,
          matchTextDirection: true,
        ),
      );

      if (response.status == true) {
        success(context,
            'You have successfully submitted request for $_selectedServiceCount $_selectedService on $_selectedPlatform. You would get a confirmation mail shortly.');
      } else {
        error(context, response.message);
      }
    } catch (e) {
      error(context, "Please confirm your details");
      rethrow;
    }
  }

  PaymentCard _getCardFromUI() {
    return PaymentCard(
      number: '',
      cvc: '',
      expiryMonth: 0,
      expiryYear: 0,
    );
  }
}

/*
Facebook
Instagram
Twitter
Youtube
Tiktok
Audiomack

Fullname
Email
Phone number

service
Account username/link
Amount
Country

Pay

Likes
Followers
Subscribers
Views
Comments
Shares
Unlikes
Reposts
Retweets

$platforms = [];
$platforms[] = 'Facebook';       
$platforms[] = 'Instagram';   
$platforms[] = 'Twitter';
$platforms[] = 'Youtube';
$platforms[] = 'Tiktok';
$platforms[] = 'Audiomack';

$platform['Facebook']['services'] = ['Likes','Followers','Comments','Shares','Unlikes','Reposts'];
$platform['Facebook']['services']['Likes]['input'] = 'Enter post link';
$platform['Facebook']['services']['Followers]['input'] = 'Enter username';
$platform['Facebook']['services']['Comments]['input'] = 'Enter username';
$platform['Facebook']['services']['Shares]['input'] = 'Enter post link';
$platform['Facebook']['services']['Unlikes]['input'] = 'Enter post link';
$platform['Facebook']['services']['Reposts]['input'] = 'Enter post link';

echo json_encode($platform);

*/
