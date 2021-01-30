import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:metrohyp/common.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

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

  String _selectedPlatform; // = 'facebook';
  String _selectedService; // = 'Likes';
  String _selectedServiceCount = '0';
  String _selectedServiceCost = '0';
  String _selectedCountry = 'Nigeria';

  String _requestedService;

  @override
  void initState() {
    super.initState();

    PaystackPlugin.initialize(publicKey: 'paystackPublicKey');

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
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return SimpleDialog(
                            title: Text('Select Platform'),
                            children: [
                              SimpleDialogOption(
                                  onPressed: () {
                                    choosePlatform('facebook', context);
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      _selectedPlatform == 'facebook'
                                          ? Icon(Icons.check)
                                          : Container()
                                    ],
                                  )),
                              SimpleDialogOption(
                                  onPressed: () {
                                    choosePlatform('twitter', context);
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      _selectedPlatform == 'twitter'
                                          ? Icon(Icons.check)
                                          : Container()
                                    ],
                                  )),
                              SimpleDialogOption(
                                  onPressed: () {
                                    choosePlatform('instagram', context);
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      _selectedPlatform == 'instagram'
                                          ? Icon(Icons.check)
                                          : Container()
                                    ],
                                  )),
                              SimpleDialogOption(
                                  onPressed: () {
                                    choosePlatform('youtube', context);
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      _selectedPlatform == 'youtube'
                                          ? Icon(Icons.check)
                                          : Container()
                                    ],
                                  )),
                              SimpleDialogOption(
                                  onPressed: () {
                                    choosePlatform('tiktok', context);
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      _selectedPlatform == 'tiktok'
                                          ? Icon(Icons.check)
                                          : Container()
                                    ],
                                  )),
                              SimpleDialogOption(
                                  onPressed: () {
                                    choosePlatform('audiomack', context);
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      _selectedPlatform == 'audiomack'
                                          ? Icon(Icons.check)
                                          : Container()
                                    ],
                                  )),
                            ]);
                      },
                    );
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bio Data:',
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  renderTextField('John', 'Enter Firstname', null),
                  renderTextField('Doe', 'Enter Lastname', null),
                  renderTextField('+234', 'Enter Telephone', null),
                  renderTextField('johndoe@mail.com', 'Enter Email', null),
                  renderCountries()
                ],
              ),
            ),
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
                          child: Row(
                            children: [
                              Text(
                                _selectedService ?? 'Select $_platform Service',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20.0, color: _platformColor),
                              ),
                            ],
                          ))),
                  renderTextField(
                      'https://...', 'Enter Account username/link', null),
                ],
              ),
            ),
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
                    'How Many $_selectedService:',
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      margin: EdgeInsets.symmetric(vertical: 25.0),
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
                          child: Expanded(
                            flex: 1,
                            child: Text(
                              _requestedService ?? 'How Many $_selectedService',
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: 20.0, color: _platformColor),
                            ),
                          )))
                ],
              ),
            ),
            Container(height: 10.0),
            FlatButton(
                onPressed: () {
                  // get values
                  // validate values
                  // process payment
                  // submit log to the backend
                },
                color: _metroColor,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text('Pay', style: TextStyle(fontSize: 18.0))),
            Container(height: 20.0),
            Image.asset('assets/imgs/paystack.png')
          ])),
        ],
      ),
    ));
  }

  Widget renderTextField(String hint, String label, maxLength) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: TextFormField(
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
        ));
  }

  Widget renderCountries() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        width: MediaQuery.of(context).copyWith().size.width,
        child: DropdownButton<String>(
          value: _selectedCountry,
          iconSize: 24,
          elevation: 15,
          hint: Text('Select Country'),
          isExpanded: true,
          style: TextStyle(color: _platformColor, fontSize: 20.0),
          underline: Container(
            height: 0.4,
            color: Colors.black,
            width: MediaQuery.of(context).copyWith().size.width,
          ),
          onChanged: (String value) {
            setState(() {
              _selectedCountry = value;
            });
          },
          items: _countries.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));
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
    setState(() => _selectedPlatform = platform);

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

  _handleCheckout(BuildContext context) async {
    Charge charge = Charge()
    ..amount = int.parse(_selectedServiceCost) // In base currency
    ..email = '<Enter Email>'
    ..card = _getCardFromUI();

    // charge.accessCode = Subscription.access_code;

    try {
      CheckoutResponse response = await PaystackPlugin.checkout(
        context,
        method: _method,
        charge: charge,
        fullscreen: true,
        logo: SvgPicture.asset(
          "assets/imgs/icons/spicy_guitar_logo.svg",
          width: 40.0,
          matchTextDirection: true,
        ),
      );

      // if (response.verify == true) {
      //   var resp = await request(
      //       'POST', verifyPayment(Subscription.reference),
      //       body: {'email': User.email});
      //   if (resp == false)
      //     Navigator.pushNamedAndRemoveUntil(
      //         context, '/login_page', (route) => false);
      //   // Map<String, dynamic> json = resp;
      //   if (resp['status'] == true) {
      //     Subscription.paystatus = true;
      //     {
      //       // get subscription status
      //       var resp = await request('GET', subscriptionStatus);
      //       if (resp == false)
      //         Navigator.pushNamedAndRemoveUntil(
      //             context, '/login_page', (route) => false);
      //       var data = resp['data'];
      //       if (resp['status'] == true) {
      //         User.subStatus = data['status'];
      //         User.daysRemaining = data['days'];
      //         User.plan = data['plan'];
      //       } else {
      //         User.subStatus = data['status'];
      //         User.daysRemaining = data['days'];
      //         User.plan = '0';
      //       }
      //     }

      //     Navigator.popAndPushNamed(context, "/successful_transaction");
      //   } else {
      //     Navigator.pushNamed(context, "/failed_transaction");
      //   }
      // }
    } catch (e) {
      error(context, "Unknown Error");
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
