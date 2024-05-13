import 'package:flutter/material.dart';
import 'package:wowcut/Routes/route_name.dart';
import 'package:wowcut/Utils/bottom_bar.dart';
import 'package:wowcut/Views/Authentication/ForgetPassword/forget_password.dart';
import 'package:wowcut/Views/Authentication/Location/location_access.dart';
import 'package:wowcut/Views/Authentication/Location/location_manually.dart';
import 'package:wowcut/Views/Authentication/NewPassword/new_password.dart';
import 'package:wowcut/Views/Authentication/OtpVerifyScreen/otp_verify_view.dart';
import 'package:wowcut/Views/Authentication/SignInScreen/sign_in_view.dart';
import 'package:wowcut/Views/Authentication/SignUpScreen/sign_up_view.dart';
import 'package:wowcut/Views/BookingScreen/booking_view.dart';
import 'package:wowcut/Views/BookingTabs/booking_tab_bar.dart';
import 'package:wowcut/Views/Chat/chat_screen.dart';
import 'package:wowcut/Views/Chat/filter.dart';
import 'package:wowcut/Views/HomeScreen/home_screen.dart';
import 'package:wowcut/Views/NewPassword/new_password_in_profile.dart';
import 'package:wowcut/Views/Notifications/notifications.dart';
import 'package:wowcut/Views/OnBoarding/Common/onboard_slider.dart';
import 'package:wowcut/Views/OnBoarding/onboarding_1.dart';
import 'package:wowcut/Views/OnBoarding/onboarding_2.dart';
import 'package:wowcut/Views/PaymentMethods/card_details.dart';
import 'package:wowcut/Views/PaymentMethods/e-reciept_view.dart';
import 'package:wowcut/Views/PaymentMethods/payment_method.dart';
import 'package:wowcut/Views/PaymentMethods/payment_successfull.dart';
import 'package:wowcut/Views/PaymentMethods/review_summary.dart';
import 'package:wowcut/Views/Profile/ProfileScreens/privacy_policy.dart';
import 'package:wowcut/Views/Profile/ProfileScreens/payment_method_in_profile.dart';
import 'package:wowcut/Views/Profile/ProfileScreens/update_profile.dart';

import 'package:wowcut/Views/SalonDetailsAndServices/deals_services.dart';
import 'package:wowcut/Views/Profile/ProfileScreens/saved_screen.dart';
import 'package:wowcut/Views/Profile/ProfileScreens/transactions.dart';
import 'package:wowcut/Views/Profile/ProfileScreens/settings.dart';
import 'package:wowcut/Views/SplashScreen/splash_view.dart';
import 'package:wowcut/Views/TabBarTabs/submit_review.dart';

class Routes {
  static Route<dynamic> genrateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashView:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
        );
      case RouteName.onBoarding1View:
        return MaterialPageRoute(
          builder: (context) => OnBoarding1View(),
        );
      case RouteName.onBoardSlider:
        return MaterialPageRoute(
          builder: (context) => const OnBoardSlider(),
        );
      case RouteName.onBoarding2View:
        return MaterialPageRoute(
          builder: (context) => OnBoarding2View(),
        );
      case RouteName.signInView:
        return MaterialPageRoute(
          builder: (context) => const SignInView(),
        );

      case RouteName.signUpView:
        return MaterialPageRoute(
          builder: (context) => const SignUpView(),
        );

      case RouteName.otpVerifyView:
        return MaterialPageRoute(
          builder: (context) => OtpVerifyView(),
        );

      case RouteName.newPasswordView:
        return MaterialPageRoute(
          builder: (context) => const NewPasswordView(),
        );

      case RouteName.locationAccessView:
        return MaterialPageRoute(
          builder: (context) => LocationAccessView(),
        );

      case RouteName.locationManualView:
        return MaterialPageRoute(
          builder: (context) => const LocationManualView(),
        );
      case RouteName.homeView:
        return MaterialPageRoute(
          builder: (context) => HomeView(),
        );

      case RouteName.bottomBarr:
        return MaterialPageRoute(
          builder: (context) => BottomBarr(),
        );
      case RouteName.locationOnMapView:
        return MaterialPageRoute(
          builder: (context) => BottomBarr(),
        );

      case RouteName.salonServicesView:
        return MaterialPageRoute(
          builder: (context) => const SalonServicesView(),
        );
      case RouteName.submitReviewView:
        return MaterialPageRoute(
          builder: (context) => SubmitReviewView(),
        );

      case RouteName.bookingView:
        return MaterialPageRoute(
          builder: (context) => const BookingView(),
        );

      case RouteName.paymentMethod:
        return MaterialPageRoute(
          builder: (context) => const PaymentMethod(),
        );

      case RouteName.cardDetailsView:
        return MaterialPageRoute(
          builder: (context) => const CardDetailsView(),
        );

      case RouteName.reviewSummaryView:
        return MaterialPageRoute(
          builder: (context) => ReviewSummaryView(),
        );

      case RouteName.forgetPasswordView:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordView(),
        );
      case RouteName.paymentSuccessFullView:
        return MaterialPageRoute(
          builder: (context) => const PaymentSuccessFullView(),
        );
      case RouteName.eReciptView:
        return MaterialPageRoute(
          builder: (context) => EReciptView(),
        );

      case RouteName.bookingTabBarView:
        return MaterialPageRoute(
          builder: (context) => const BookingTabBarView(),
        );

      case RouteName.chatScreen:
        return MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        );

      case RouteName.filterView:
        return MaterialPageRoute(
          builder: (context) => FilterView(),
        );
      case RouteName.notificationsView:
        return MaterialPageRoute(
          builder: (context) => const NotificationsView(),
        );
      case RouteName.updateProfile:
        return MaterialPageRoute(
          builder: (context) => const ProfileUpdate(),
        );
      case RouteName.paymentMethodInProfile:
        return MaterialPageRoute(
          builder: (context) => const PaymentMethodInProfile(),
        );
      case RouteName.savedView:
        return MaterialPageRoute(
          builder: (context) => const SavedView(),
        );
      case RouteName.settingView:
        return MaterialPageRoute(
          builder: (context) => SettingView(),
        );
      case RouteName.transactionsView:
        return MaterialPageRoute(
          builder: (context) => const TransactionsView(),
        );
      case RouteName.newPasswordViewInProfile:
        return MaterialPageRoute(
          builder: (context) => const NewPasswordViewInProfile(),
        );
      case RouteName.privacyPolicyView:
        return MaterialPageRoute(
          builder: (context) => const PrivacyPolicyView(),
        );

      default:
        {
          return MaterialPageRoute(
              builder: ((context) => const Scaffold(
                    body: Center(
                      child: Text("No Route Found"),
                    ),
                  )));
        }
    }
  }
}
