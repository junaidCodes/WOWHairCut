import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/app_colors.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    String pirvacyPolicy = """

Last updated: [07 March 2024]

This Privacy Policy describes how your personal information is collected, used, and shared when you use the Wow Hair Cut mobile application (the "App").

PERSONAL INFORMATION WE COLLECT
When you use the App, we may collect certain information from you, including:
- Your name
- Your email address
- Your phone number
- Information about the services you use

HOW WE USE YOUR PERSONAL INFORMATION
We use the personal information collected from you to:
- Provide and improve our services
- Communicate with you
- Send you promotional materials

SHARING YOUR PERSONAL INFORMATION
We may share your personal information with third parties to help us use your personal information, as described above. For example, we use Shopify to power our online store—you can read more about how Shopify uses your personal information here: https://www.shopify.com/legal/privacy.

Additionally, we may also share your personal information to comply with applicable laws and regulations, to respond to a subpoena, search warrant, or other lawful request for information we receive, or to otherwise protect our rights.

YOUR RIGHTS
If you are a European resident, you have the right to access personal information we hold about you and to ask that your personal information be corrected, updated, or deleted. If you would like to exercise this right, please contact us through the contact information below.

DATA RETENTION
When you place an order through the App, we will maintain your Order Information for our records unless and until you ask us to delete this information.

CHANGES
We may update this privacy policy from time to time in order to reflect, for example, changes to our practices or for other operational, legal, or regulatory reasons.

CONTACT US
For more information about our privacy practices, if you have questions, or if you would like to make a complaint, please contact us by e-mail at privacy@wowhaircut.com or by mail using the details provided below:

Wow Hair Cut
123 Main St, Anytown, USA
""";

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        flexibleSpace: AppBarCustom(
          title: "Privacy Policy",
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Welcome to wow Hair Cut",
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              pirvacyPolicy,
              style: GoogleFonts.inter(
                  // fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            )
          ],
        ),
      )),
    );
  }
}
