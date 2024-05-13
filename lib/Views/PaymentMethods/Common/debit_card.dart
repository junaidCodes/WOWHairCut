// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/image_paths.dart';

class DebitCard extends StatefulWidget {
  String cardHolderName;
  String cardExpireyDate;
  String cardNumber;

  DebitCard({
    super.key,
    required this.cardHolderName,
    required this.cardExpireyDate,
    required this.cardNumber,
  });

  @override
  State<DebitCard> createState() => _DebitCardState();
}

class _DebitCardState extends State<DebitCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          PathToImage.debitCardImage,
          height: 220,
          width: 370,
          // fit: BoxFit.cover,
        ),
        Container(
          height: 200,
          // width: 370,
          decoration: BoxDecoration(
              // color: Colors.amber,

              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 0,
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Card Holder Name",
                              style: GoogleFonts.inter(
                                  fontSize: 10, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 35),
                            child: SizedBox(
                              width: 140,
                              child: Text(
                                widget.cardHolderName.isEmpty
                                    ? "Esther Howard"
                                    : widget.cardHolderName,
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Expiry Date",
                          style: GoogleFonts.inter(
                              fontSize: 10, color: Colors.white),
                        ),
                        Text(
                          widget.cardExpireyDate.isEmpty
                              ? "0230"
                              : widget.cardExpireyDate,
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 100),
              child: Text(
                widget.cardNumber.isEmpty
                    ? "7815 9561 1635 8561"
                    : widget.cardNumber,
                style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            )),
      ],
    );
  }
}
