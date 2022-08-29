import 'package:scflutter/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BaseRepositoryArguments {
  bool? userData;
  bool? receiverData;
  bool? actorData;
  bool? roomData;
  BaseRepositoryArguments(
      {this.userData, this.receiverData, this.roomData, this.actorData});
}

class BaseRepositoryClass with LoggerMixin {
  final SupabaseClient supabase = Supabase.instance.client;

  final userMeta = ["*"];

  BaseRepositoryClass([BaseRepositoryArguments? args]) {
    if (args == null) return;

    if (args.userData != null && args.userData != false) {
      userMeta.add('user_data:user(*)');
    }

    if (args.receiverData != null && args.receiverData != false) {
      userMeta.add('receiver_data:receiver(*)');
    }

    if (args.roomData != null && args.roomData != false) {
      userMeta.add('room_data:room(*)');
    }
    if (args.actorData != null && args.actorData != false) {
      userMeta.add('actor_data:user(*)');
    }
  }
}
