import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

String mapKey = "AIzaSyBr3P4Otv-N9mSbsTLnZtek1F4os-SNpRM";

User currentFirebaseUser;


StreamSubscription<Position> homeTabPageStreamSubscription;