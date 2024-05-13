// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Common/image_paths.dart';
import 'package:wowcut/Common/toast_message.dart';
import 'package:wowcut/Utils/app_colors.dart';
import 'package:wowcut/Views/Chat/bubble.dart';
import 'package:wowcut/Views/Chat/chat.dart';
import 'package:wowcut/Views/Chat/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              PathToImage.arrow,
              color: Colors.white,
            ),
          ),
        ),
        flexibleSpace: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, top: 20, right: 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Jenny Wilson",
                  style: GoogleFonts.inter(fontSize: 18, color: Colors.white),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Online ",
                      style:
                          GoogleFonts.inter(fontSize: 10, color: Colors.white),
                    ),
                    const Badge(
                      backgroundColor: Colors.amber,
                      smallSize: 5,
                    ),
                    Text(
                      "  10 minutes ago",
                      style:
                          GoogleFonts.inter(fontSize: 10, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: AppColors.primaryColor,
        actions: [
          InkWell(
            onTap: () {
              ToastMessage().toastMessage("Coming Soon", color: Colors.green);
            },
            child: const Icon(
              Icons.more_vert_sharp,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context.read<ChatController>().focusNode.unfocus();
                  // FocusScope.of(context).unfocus();
                },
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Selector<ChatController, List<Chat>>(
                    selector: (context, controller) =>
                        controller.chatList.reversed.toList(),
                    builder: (context, chatList, child) {
                      return Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(35),
                                topLeft: Radius.circular(35))),
                        child: ListView.separated(
                          shrinkWrap: true,
                          reverse: true,
                          padding: const EdgeInsets.only(top: 12, bottom: 20) +
                              const EdgeInsets.symmetric(horizontal: 12),
                          separatorBuilder: (_, __) => const SizedBox(
                            height: 12,
                          ),
                          controller:
                              context.read<ChatController>().scrollController,
                          itemCount: chatList.length,
                          itemBuilder: (context, index) {
                            return Bubble(chat: chatList[index]);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const _BottomInputField(),
          ],
        ),
      ),
    );
  }
}

/// Bottom Fixed Filed
class _BottomInputField extends StatelessWidget {
  const _BottomInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        constraints: const BoxConstraints(minHeight: 48),
        width: double.infinity,
        decoration: const BoxDecoration(),
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: TextField(
                  focusNode: context.read<ChatController>().focusNode,
                  onChanged: context.read<ChatController>().onFieldChanged,
                  controller:
                      context.read<ChatController>().textEditingController,
                  maxLines: null,
                  // textAlignVertical: TextAlignVertical.top,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                    // border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                      right: 42,
                      left: 16,
                      top: 18,
                    ),

                    hintText: 'type here',

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
            // custom suffix btn
            Positioned(
              bottom: 0,
              right: 15,
              child: IconButton(
                icon: SvgPicture.asset(
                  PathToImage.sendMessage,
                  colorFilter: ColorFilter.mode(
                    context.select<ChatController, bool>(
                            (value) => value.isTextFieldEnable)
                        ? AppColors.primaryColor
                        : AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: context.read<ChatController>().onFieldSubmitted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
