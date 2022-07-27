import 'package:eventify/eventify.dart' as eventify;

extension EventEmitterToMapSupport on eventify.Event {
  Map<String, dynamic> toMap() {
    return {"eventName": eventName, "data": eventData};
  }
}
