import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: _privacyPolicyText,
    );
  }
}
var _privacyPolicyText = '''## Privacy Policy

Flutter Example Company built the Star Counter app as an Open Source app. This SERVICE is provided by Flutter Example Company at no cost and is intended for use as is.

This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.

If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.

The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Star Counter unless otherwise defined in this Privacy Policy.
''';