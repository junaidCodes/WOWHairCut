import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/app_bar.dart';
import 'package:wowcut/Utils/button.dart';
import 'package:wowcut/Views/Authentication/SignInScreen/Common/label_text_field.dart';
import 'package:wowcut/Views/OnBoarding/Common/text_field.dart';
import 'package:wowcut/Views/PaymentMethods/Common/debit_card.dart';

class CardDetailsView extends StatefulWidget {
  const CardDetailsView({Key? key}) : super(key: key);

  @override
  State<CardDetailsView> createState() => _CardDetailsViewState();
}

class _CardDetailsViewState extends State<CardDetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardExpireyDateController =
      TextEditingController();
  final TextEditingController _cardCvvController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customBar("Card Details", true, context),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DebitCard(
              cardHolderName: _cardHolderNameController.text,
              cardExpireyDate: _cardExpireyDateController.text,
              cardNumber: _cardNumberController.text,
            ),
            const SizedBox(height: 15),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelTextField(label: "Card Holder Name"),
                  const SizedBox(height: 10),
                  TextfieldCustom(
                    length: [LengthLimitingTextInputFormatter(30)],
                    validator: (value) =>
                        value!.isEmpty ? "Fill Name fields" : null,
                    onTapOutsidee: (_) => context.unFocus(),
                    controller: _cardHolderNameController,
                    inputType: TextInputType.name,
                    hintText: "Esther Howard",
                    onChange: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 20),
                  LabelTextField(label: "Card Number"),
                  const SizedBox(height: 10),
                  TextfieldCustom(
                    // length: [LengthLimitingTextInputFormatter(16)],
                    length: [
                      CreditCardFormatter(),
                      LengthLimitingTextInputFormatter(19)
                    ],
                    validator: (value) =>
                        value!.isEmpty ? "Fill Card Number field" : null,
                    controller: _cardNumberController,
                    inputType: TextInputType.phone,
                    hintText: "7815 9561 1635 8561",
                    onChange: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 115,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelTextField(label: "Expiry Date"),
                              const SizedBox(height: 10),
                              // TextfieldCustom(
                              //   length: [LengthLimitingTextInputFormatter(30)],
                              //   validator: (value) =>
                              //       value!.isEmpty ? "Fill Date" : null,
                              //   onTapOutsidee: (_) => context.unFocus(),
                              //   controller: _cardExpireyDateController,
                              //   inputType: TextInputType.name,
                              //   hintText: "02/30",
                              //   onChange: (_) => setState(() {}),
                              // ),

                              TextfieldCustom(
                                readOnly: true,
                                controller: dobController,
                                // readOnly: false,
                                onTap: () async {
                                  datePicker(context);
                                },
                                validator: (value) {
                                  if (value == "") {
                                    return "Select Expiry";
                                  }
                                  return null;
                                },
                                inputType: TextInputType.datetime,
                                hintText: 'MM/YYYY',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelTextField(label: "CVV"),
                              const SizedBox(height: 10),
                              TextfieldCustom(
                                length: [LengthLimitingTextInputFormatter(3)],
                                validator: (value) =>
                                    value!.isEmpty ? "Fill CVV field" : null,
                                onTapOutsidee: (_) => context.unFocus(),
                                controller: _cardCvvController,
                                inputType: TextInputType.number,
                                hintText: "000",
                                onChange: (_) => setState(() {}),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  PrimaryButton(
                    text: "Next",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(
                            context, RouteName.reviewSummaryView);
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
      // resizeToAvoidBottomInset: false,
    );
  }

  Future datePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 124),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = "${picked.month}/${picked.year}";
    }
  }

  @override
  void dispose() {
    _cardHolderNameController.dispose();
    _cardNumberController.dispose();
    _cardExpireyDateController.dispose();
    _cardCvvController.dispose();
    super.dispose();
  }
}

class CreditCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-digit characters
    String cleanedText = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Add space after every four digits
    String formattedText = '';
    for (int i = 0; i < cleanedText.length; i++) {
      if (i % 4 == 0 && i > 0) {
        formattedText += ' ';
      }
      formattedText += cleanedText[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
