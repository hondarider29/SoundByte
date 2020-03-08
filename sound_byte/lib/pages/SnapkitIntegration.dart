import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sound_byte/pages/chatScreen.dart';
import 'package:sound_byte/services/authentication.dart';
import 'package:sound_byte/pages/userProfile.dart';
import 'package:sound_byte/pages/friendProfile.dart';
import 'package:sound_byte/pages/friendScreen.dart';

class Snapkit {
  String _clientOAuthIntegration;
  int numberOfEndPoints;
  bool connectedToEndPoint;
  

  Snapkit (int numberOfEndPoints) {
    _clientOAuthIntegration = "fc8f651e-839f-471e-810a-ba81a9137d98";
    this.numberOfEndPoints = numberOfEndPoints;
    connectedToEndPoint = false;
  }

  void connectToEndPoint () {
    OAuthProvider.connectEndPortion(_clientOAuthIntegration);
    this.numberOfEndPoints += 1;
    this.connectedToEndPoint = true;
  }

  void disconnectFromEndPoint () {
    OAuthProvider.disconnectEndPortion(_clientOAuthIntegration);
    this.numberOfEndPoints -= 1;
    this.connectedToEndPoint = false;
  }

  void connectOrDisconnect () {
    if (!connectedToEndPoint) {
      connectedToEndPoint();
    } else {
      disconnectFromEndPoint();
    }
  }
}
