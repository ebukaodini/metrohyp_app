import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[800],
          title: Text('Privacy Policy'),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: Column(children: [
              Text(
                  '''This policy describes what information we collect and how it is used. As you review our policy, keep in mind that it applies to all METROHYP applications and services.


'''),
              Text(
                'What kinds of information do we collect?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  '''

From our services and applications we collect only your contact information from or about you. This information is collected from contact forms or contact activity (in our applications) only when you decide to get in touch with us.


'''),
              Text(
                'How do we use this information?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  '''

We are passionate about our app users and clients, so we use the information you provide to provide support and also improve our services/apps We also use the information you provide to communicate with you about our products, services and applications.


'''),
              Text(
                'Sharing of information',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                  '''

Please bear in mind that METROHYP International does not share your contact details with any third party software or company. Applying changes to this policy. We will get through to all our clients and app users before we adjust any part of this policy


Date of Last Revision: January 13, 2018'''),
            ])));
  }
}
