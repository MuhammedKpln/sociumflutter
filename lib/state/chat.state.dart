import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

ValueNotifier<bool> chatMicMuted = ValueNotifier<bool>(false);
ValueNotifier<bool> chatCameraOpened = ValueNotifier<bool>(false);
ValueNotifier<MediaStream?> remoteStream = ValueNotifier(null);
ValueNotifier<MediaStream?> localStream = ValueNotifier(null);
ValueNotifier<bool> connectedToCall = ValueNotifier<bool>(false);
