import 'package:flutter/material.dart';


abstract class AppConstants {
 static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const int defaultWaitingTime = 10;
  static const double fieldsBorderRadius = 8;
  static const double dialogsBorderRadius = 10;
  static double HorizontelPadding =
      MediaQuery.sizeOf(navigatorKey.currentContext!).width * 0.03;
  static const double customButtonHeight = 30;
  static const double fieldsheight = 40;
  static const double elevatedButtonHeight = 40;
  static const double custombuttonradius = 4;
  static const double heightValueBetweenFields = 20;
  static const double horizontelPaddingForWhiteMainContainer = 15;
  static const double verticalPaddingForWhiteMainContainer = 20;
  static const double borderradiusWhiteMainContainer = 20;
  static const double widthBetweenRadioButtons = 20;
  static const String userCurrentAddressKey = "userCurrentAddress";
  static const String userIDKey = "userID";
  static const String cancelBookingIDKey = "cancelBookingIDKey";
  static const String editBookingIDKey = "editBookingIDKey";
  static const String userApiTokenKey = "userApiToken";
  static const String driverSignUpDataKey = "driverSignUpDataKey";
  static const String accessTokenkeyForSmsSystem = "AccessTokenForSmsSystem";
  static const String deviceFcmTokenKey = "deviceFcmTokenKey";
  static const String accessTokenExpiryDatekeyForGetQuote =
      "accessTokenExpiryDatekeyForGetQuote";
  static const String csrChatIDKey = "csrChatIDKey";
  static const String countryCodeKey = "countryCodeKey";
  static const String userNumberKey = "userNumberKey";
  static const String userProfilePicKey = "userProfilePicKey";
  static const String userNameKey = "userNameKey";
  static const String usergmailKey = "usergmailKey";
  static const String usergenderKey = "usergenderKey";
  static const String appFont = "Poppins";
  static const String mqttHostName = "mqtt.dev.bookukride.co.uk";
  static const String tenantName = "ukride";
  static double keyboardHeight =
      MediaQuery.of(navigatorKey.currentContext!).viewInsets.bottom + 50;

  /// ride statuses string
  static const String rideAccepted = "Ride has been accepted";
  static const String driverOnRoute = "Driver On Route";
  static const String driverReached = "Driver Arrived";
  static const String passengerOnBorad = "Passenger On Borad";
  static const String rideStarted = "Ride Started";
  static const String rideCompleted = "Ride Completed";
  static const String bookingDetailsUpdated = "Ride Completed";
}
