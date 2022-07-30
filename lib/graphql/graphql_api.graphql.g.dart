// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserProfile$Query$GetUser$$count
    _$GetUserProfile$Query$GetUser$$countFromJson(Map<String, dynamic> json) =>
        GetUserProfile$Query$GetUser$$count()
          ..followers = (json['followers'] as num).toDouble()
          ..followings = (json['followings'] as num).toDouble()
          ..posts = (json['posts'] as num).toDouble();

Map<String, dynamic> _$GetUserProfile$Query$GetUser$$countToJson(
        GetUserProfile$Query$GetUser$$count instance) =>
    <String, dynamic>{
      'followers': instance.followers,
      'followings': instance.followings,
      'posts': instance.posts,
    };

GetUserProfile$Query$GetUser _$GetUserProfile$Query$GetUserFromJson(
        Map<String, dynamic> json) =>
    GetUserProfile$Query$GetUser()
      ..id = (json['id'] as num).toDouble()
      ..username = json['username'] as String
      ..bio = json['bio'] as String?
      ..avatar = json['avatar'] as String?
      ..birthday = json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String)
      ..$count = GetUserProfile$Query$GetUser$$count.fromJson(
          json['_count'] as Map<String, dynamic>);

Map<String, dynamic> _$GetUserProfile$Query$GetUserToJson(
    GetUserProfile$Query$GetUser instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'username': instance.username,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bio', instance.bio);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('birthday', instance.birthday?.toIso8601String());
  val['_count'] = instance.$count.toJson();
  return val;
}

GetUserProfile$Query _$GetUserProfile$QueryFromJson(
        Map<String, dynamic> json) =>
    GetUserProfile$Query()
      ..getUser = GetUserProfile$Query$GetUser.fromJson(
          json['getUser'] as Map<String, dynamic>);

Map<String, dynamic> _$GetUserProfile$QueryToJson(
        GetUserProfile$Query instance) =>
    <String, dynamic>{
      'getUser': instance.getUser.toJson(),
    };

RefreshToken$Mutation$RefreshToken _$RefreshToken$Mutation$RefreshTokenFromJson(
        Map<String, dynamic> json) =>
    RefreshToken$Mutation$RefreshToken()
      ..accessToken = json['access_token'] as String
      ..refreshToken = json['refresh_token'] as String
      ..expireDate = DateTime.parse(json['expire_date'] as String);

Map<String, dynamic> _$RefreshToken$Mutation$RefreshTokenToJson(
        RefreshToken$Mutation$RefreshToken instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expire_date': instance.expireDate.toIso8601String(),
    };

RefreshToken$Mutation _$RefreshToken$MutationFromJson(
        Map<String, dynamic> json) =>
    RefreshToken$Mutation()
      ..refreshToken = RefreshToken$Mutation$RefreshToken.fromJson(
          json['refreshToken'] as Map<String, dynamic>);

Map<String, dynamic> _$RefreshToken$MutationToJson(
        RefreshToken$Mutation instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken.toJson(),
    };

FetchMessages$Query$Messages$Sender
    _$FetchMessages$Query$Messages$SenderFromJson(Map<String, dynamic> json) =>
        FetchMessages$Query$Messages$Sender()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..avatar = json['avatar'] as String?
          ..email = json['email'] as String;

Map<String, dynamic> _$FetchMessages$Query$Messages$SenderToJson(
    FetchMessages$Query$Messages$Sender instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'username': instance.username,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('avatar', instance.avatar);
  val['email'] = instance.email;
  return val;
}

FetchMessages$Query$Messages$Receiver
    _$FetchMessages$Query$Messages$ReceiverFromJson(
            Map<String, dynamic> json) =>
        FetchMessages$Query$Messages$Receiver()
          ..id = (json['id'] as num).toDouble()
          ..username = json['username'] as String
          ..avatar = json['avatar'] as String?
          ..email = json['email'] as String;

Map<String, dynamic> _$FetchMessages$Query$Messages$ReceiverToJson(
    FetchMessages$Query$Messages$Receiver instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'username': instance.username,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('avatar', instance.avatar);
  val['email'] = instance.email;
  return val;
}

FetchMessages$Query$Messages$Room _$FetchMessages$Query$Messages$RoomFromJson(
        Map<String, dynamic> json) =>
    FetchMessages$Query$Messages$Room()
      ..id = (json['id'] as num).toDouble()
      ..roomAdress = json['roomAdress'] as String
      ..createdAt = DateTime.parse(json['created_at'] as String)
      ..updatedAt = DateTime.parse(json['updated_at'] as String)
      ..expireDate = DateTime.parse(json['expireDate'] as String);

Map<String, dynamic> _$FetchMessages$Query$Messages$RoomToJson(
        FetchMessages$Query$Messages$Room instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomAdress': instance.roomAdress,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'expireDate': instance.expireDate.toIso8601String(),
    };

FetchMessages$Query$Messages _$FetchMessages$Query$MessagesFromJson(
        Map<String, dynamic> json) =>
    FetchMessages$Query$Messages()
      ..id = (json['id'] as num).toDouble()
      ..message = json['message'] as String
      ..seen = json['seen'] as bool
      ..sender = FetchMessages$Query$Messages$Sender.fromJson(
          json['sender'] as Map<String, dynamic>)
      ..receiver = FetchMessages$Query$Messages$Receiver.fromJson(
          json['receiver'] as Map<String, dynamic>)
      ..room = FetchMessages$Query$Messages$Room.fromJson(
          json['room'] as Map<String, dynamic>);

Map<String, dynamic> _$FetchMessages$Query$MessagesToJson(
        FetchMessages$Query$Messages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'seen': instance.seen,
      'sender': instance.sender.toJson(),
      'receiver': instance.receiver.toJson(),
      'room': instance.room.toJson(),
    };

FetchMessages$Query _$FetchMessages$QueryFromJson(Map<String, dynamic> json) =>
    FetchMessages$Query()
      ..messages = (json['messages'] as List<dynamic>)
          .map((e) =>
              FetchMessages$Query$Messages.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FetchMessages$QueryToJson(
        FetchMessages$Query instance) =>
    <String, dynamic>{
      'messages': instance.messages.map((e) => e.toJson()).toList(),
    };

Login$Mutation$Login$User _$Login$Mutation$Login$UserFromJson(
        Map<String, dynamic> json) =>
    Login$Mutation$Login$User()
      ..username = json['username'] as String
      ..id = (json['id'] as num).toDouble()
      ..email = json['email'] as String
      ..gender = (json['gender'] as num?)?.toDouble()
      ..avatar = json['avatar'] as String?
      ..bio = json['bio'] as String?
      ..isEmailConfirmed = json['isEmailConfirmed'] as bool
      ..birthday = json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String)
      ..blockIncomingCalls = json['blockIncomingCalls'] as bool?;

Map<String, dynamic> _$Login$Mutation$Login$UserToJson(
    Login$Mutation$Login$User instance) {
  final val = <String, dynamic>{
    'username': instance.username,
    'id': instance.id,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('gender', instance.gender);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('bio', instance.bio);
  val['isEmailConfirmed'] = instance.isEmailConfirmed;
  writeNotNull('birthday', instance.birthday?.toIso8601String());
  writeNotNull('blockIncomingCalls', instance.blockIncomingCalls);
  return val;
}

Login$Mutation$Login _$Login$Mutation$LoginFromJson(
        Map<String, dynamic> json) =>
    Login$Mutation$Login()
      ..accessToken = json['access_token'] as String
      ..refreshToken = json['refresh_token'] as String
      ..expireDate = DateTime.parse(json['expire_date'] as String)
      ..user = Login$Mutation$Login$User.fromJson(
          json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$Login$Mutation$LoginToJson(
        Login$Mutation$Login instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expire_date': instance.expireDate.toIso8601String(),
      'user': instance.user.toJson(),
    };

Login$Mutation _$Login$MutationFromJson(Map<String, dynamic> json) =>
    Login$Mutation()
      ..login =
          Login$Mutation$Login.fromJson(json['login'] as Map<String, dynamic>);

Map<String, dynamic> _$Login$MutationToJson(Login$Mutation instance) =>
    <String, dynamic>{
      'login': instance.login.toJson(),
    };

Register$Mutation$Register$User _$Register$Mutation$Register$UserFromJson(
        Map<String, dynamic> json) =>
    Register$Mutation$Register$User()
      ..username = json['username'] as String
      ..id = (json['id'] as num).toDouble()
      ..email = json['email'] as String
      ..gender = (json['gender'] as num?)?.toDouble()
      ..avatar = json['avatar'] as String?
      ..bio = json['bio'] as String?
      ..isEmailConfirmed = json['isEmailConfirmed'] as bool
      ..birthday = json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String)
      ..blockIncomingCalls = json['blockIncomingCalls'] as bool?;

Map<String, dynamic> _$Register$Mutation$Register$UserToJson(
    Register$Mutation$Register$User instance) {
  final val = <String, dynamic>{
    'username': instance.username,
    'id': instance.id,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('gender', instance.gender);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('bio', instance.bio);
  val['isEmailConfirmed'] = instance.isEmailConfirmed;
  writeNotNull('birthday', instance.birthday?.toIso8601String());
  writeNotNull('blockIncomingCalls', instance.blockIncomingCalls);
  return val;
}

Register$Mutation$Register _$Register$Mutation$RegisterFromJson(
        Map<String, dynamic> json) =>
    Register$Mutation$Register()
      ..accessToken = json['access_token'] as String
      ..refreshToken = json['refresh_token'] as String
      ..expireDate = DateTime.parse(json['expire_date'] as String)
      ..user = Register$Mutation$Register$User.fromJson(
          json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$Register$Mutation$RegisterToJson(
        Register$Mutation$Register instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expire_date': instance.expireDate.toIso8601String(),
      'user': instance.user.toJson(),
    };

Register$Mutation _$Register$MutationFromJson(Map<String, dynamic> json) =>
    Register$Mutation()
      ..register = Register$Mutation$Register.fromJson(
          json['register'] as Map<String, dynamic>);

Map<String, dynamic> _$Register$MutationToJson(Register$Mutation instance) =>
    <String, dynamic>{
      'register': instance.register.toJson(),
    };

FetchRoomMessage$Query$MessagesFromRoom$Sender
    _$FetchRoomMessage$Query$MessagesFromRoom$SenderFromJson(
            Map<String, dynamic> json) =>
        FetchRoomMessage$Query$MessagesFromRoom$Sender()
          ..username = json['username'] as String
          ..id = (json['id'] as num).toDouble()
          ..email = json['email'] as String
          ..gender = (json['gender'] as num?)?.toDouble()
          ..avatar = json['avatar'] as String?
          ..bio = json['bio'] as String?
          ..isEmailConfirmed = json['isEmailConfirmed'] as bool
          ..birthday = json['birthday'] == null
              ? null
              : DateTime.parse(json['birthday'] as String)
          ..blockIncomingCalls = json['blockIncomingCalls'] as bool?;

Map<String, dynamic> _$FetchRoomMessage$Query$MessagesFromRoom$SenderToJson(
    FetchRoomMessage$Query$MessagesFromRoom$Sender instance) {
  final val = <String, dynamic>{
    'username': instance.username,
    'id': instance.id,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('gender', instance.gender);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('bio', instance.bio);
  val['isEmailConfirmed'] = instance.isEmailConfirmed;
  writeNotNull('birthday', instance.birthday?.toIso8601String());
  writeNotNull('blockIncomingCalls', instance.blockIncomingCalls);
  return val;
}

FetchRoomMessage$Query$MessagesFromRoom$Receiver
    _$FetchRoomMessage$Query$MessagesFromRoom$ReceiverFromJson(
            Map<String, dynamic> json) =>
        FetchRoomMessage$Query$MessagesFromRoom$Receiver()
          ..username = json['username'] as String
          ..id = (json['id'] as num).toDouble()
          ..email = json['email'] as String
          ..gender = (json['gender'] as num?)?.toDouble()
          ..avatar = json['avatar'] as String?
          ..bio = json['bio'] as String?
          ..isEmailConfirmed = json['isEmailConfirmed'] as bool
          ..birthday = json['birthday'] == null
              ? null
              : DateTime.parse(json['birthday'] as String)
          ..blockIncomingCalls = json['blockIncomingCalls'] as bool?;

Map<String, dynamic> _$FetchRoomMessage$Query$MessagesFromRoom$ReceiverToJson(
    FetchRoomMessage$Query$MessagesFromRoom$Receiver instance) {
  final val = <String, dynamic>{
    'username': instance.username,
    'id': instance.id,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('gender', instance.gender);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('bio', instance.bio);
  val['isEmailConfirmed'] = instance.isEmailConfirmed;
  writeNotNull('birthday', instance.birthday?.toIso8601String());
  writeNotNull('blockIncomingCalls', instance.blockIncomingCalls);
  return val;
}

FetchRoomMessage$Query$MessagesFromRoom$Room
    _$FetchRoomMessage$Query$MessagesFromRoom$RoomFromJson(
            Map<String, dynamic> json) =>
        FetchRoomMessage$Query$MessagesFromRoom$Room()
          ..id = (json['id'] as num).toDouble()
          ..roomAdress = json['roomAdress'] as String;

Map<String, dynamic> _$FetchRoomMessage$Query$MessagesFromRoom$RoomToJson(
        FetchRoomMessage$Query$MessagesFromRoom$Room instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomAdress': instance.roomAdress,
    };

FetchRoomMessage$Query$MessagesFromRoom
    _$FetchRoomMessage$Query$MessagesFromRoomFromJson(
            Map<String, dynamic> json) =>
        FetchRoomMessage$Query$MessagesFromRoom()
          ..sender = FetchRoomMessage$Query$MessagesFromRoom$Sender.fromJson(
              json['sender'] as Map<String, dynamic>)
          ..receiver =
              FetchRoomMessage$Query$MessagesFromRoom$Receiver.fromJson(
                  json['receiver'] as Map<String, dynamic>)
          ..room = FetchRoomMessage$Query$MessagesFromRoom$Room.fromJson(
              json['room'] as Map<String, dynamic>)
          ..seen = json['seen'] as bool
          ..message = json['message'] as String
          ..createdAt = DateTime.parse(json['created_at'] as String)
          ..id = (json['id'] as num).toDouble();

Map<String, dynamic> _$FetchRoomMessage$Query$MessagesFromRoomToJson(
        FetchRoomMessage$Query$MessagesFromRoom instance) =>
    <String, dynamic>{
      'sender': instance.sender.toJson(),
      'receiver': instance.receiver.toJson(),
      'room': instance.room.toJson(),
      'seen': instance.seen,
      'message': instance.message,
      'created_at': instance.createdAt.toIso8601String(),
      'id': instance.id,
    };

FetchRoomMessage$Query _$FetchRoomMessage$QueryFromJson(
        Map<String, dynamic> json) =>
    FetchRoomMessage$Query()
      ..messagesFromRoom = (json['messagesFromRoom'] as List<dynamic>)
          .map((e) => FetchRoomMessage$Query$MessagesFromRoom.fromJson(
              e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FetchRoomMessage$QueryToJson(
        FetchRoomMessage$Query instance) =>
    <String, dynamic>{
      'messagesFromRoom':
          instance.messagesFromRoom.map((e) => e.toJson()).toList(),
    };

FetchPosts$Query$Posts$UserLike _$FetchPosts$Query$Posts$UserLikeFromJson(
        Map<String, dynamic> json) =>
    FetchPosts$Query$Posts$UserLike()..liked = json['liked'] as bool;

Map<String, dynamic> _$FetchPosts$Query$Posts$UserLikeToJson(
        FetchPosts$Query$Posts$UserLike instance) =>
    <String, dynamic>{
      'liked': instance.liked,
    };

FetchPosts$Query$Posts$PostLike _$FetchPosts$Query$Posts$PostLikeFromJson(
        Map<String, dynamic> json) =>
    FetchPosts$Query$Posts$PostLike()
      ..likeCount = (json['likeCount'] as num).toDouble();

Map<String, dynamic> _$FetchPosts$Query$Posts$PostLikeToJson(
        FetchPosts$Query$Posts$PostLike instance) =>
    <String, dynamic>{
      'likeCount': instance.likeCount,
    };

FetchPosts$Query$Posts$User _$FetchPosts$Query$Posts$UserFromJson(
        Map<String, dynamic> json) =>
    FetchPosts$Query$Posts$User()
      ..username = json['username'] as String
      ..avatar = json['avatar'] as String?
      ..id = (json['id'] as num).toDouble();

Map<String, dynamic> _$FetchPosts$Query$Posts$UserToJson(
    FetchPosts$Query$Posts$User instance) {
  final val = <String, dynamic>{
    'username': instance.username,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('avatar', instance.avatar);
  val['id'] = instance.id;
  return val;
}

FetchPosts$Query$Posts$$count _$FetchPosts$Query$Posts$$countFromJson(
        Map<String, dynamic> json) =>
    FetchPosts$Query$Posts$$count()
      ..comment = (json['comment'] as num).toDouble();

Map<String, dynamic> _$FetchPosts$Query$Posts$$countToJson(
        FetchPosts$Query$Posts$$count instance) =>
    <String, dynamic>{
      'comment': instance.comment,
    };

FetchPosts$Query$Posts$Category _$FetchPosts$Query$Posts$CategoryFromJson(
        Map<String, dynamic> json) =>
    FetchPosts$Query$Posts$Category()
      ..id = (json['id'] as num).toDouble()
      ..name = json['name'] as String;

Map<String, dynamic> _$FetchPosts$Query$Posts$CategoryToJson(
        FetchPosts$Query$Posts$Category instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

FetchPosts$Query$Posts _$FetchPosts$Query$PostsFromJson(
        Map<String, dynamic> json) =>
    FetchPosts$Query$Posts()
      ..id = (json['id'] as num).toDouble()
      ..content = json['content'] as String
      ..type = (json['type'] as num).toDouble()
      ..slug = json['slug'] as String
      ..createdAt = DateTime.parse(json['created_at'] as String)
      ..postFromFollowers = json['postFromFollowers'] as bool?
      ..additional = json['additional'] as String?
      ..userLike = json['userLike'] == null
          ? null
          : FetchPosts$Query$Posts$UserLike.fromJson(
              json['userLike'] as Map<String, dynamic>)
      ..postLike = FetchPosts$Query$Posts$PostLike.fromJson(
          json['postLike'] as Map<String, dynamic>)
      ..updatedAt = DateTime.parse(json['updated_at'] as String)
      ..user = FetchPosts$Query$Posts$User.fromJson(
          json['user'] as Map<String, dynamic>)
      ..$count = FetchPosts$Query$Posts$$count.fromJson(
          json['_count'] as Map<String, dynamic>)
      ..category = FetchPosts$Query$Posts$Category.fromJson(
          json['category'] as Map<String, dynamic>);

Map<String, dynamic> _$FetchPosts$Query$PostsToJson(
    FetchPosts$Query$Posts instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'content': instance.content,
    'type': instance.type,
    'slug': instance.slug,
    'created_at': instance.createdAt.toIso8601String(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('postFromFollowers', instance.postFromFollowers);
  writeNotNull('additional', instance.additional);
  writeNotNull('userLike', instance.userLike?.toJson());
  val['postLike'] = instance.postLike.toJson();
  val['updated_at'] = instance.updatedAt.toIso8601String();
  val['user'] = instance.user.toJson();
  val['_count'] = instance.$count.toJson();
  val['category'] = instance.category.toJson();
  return val;
}

FetchPosts$Query _$FetchPosts$QueryFromJson(Map<String, dynamic> json) =>
    FetchPosts$Query()
      ..posts = (json['posts'] as List<dynamic>)
          .map(
              (e) => FetchPosts$Query$Posts.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FetchPosts$QueryToJson(FetchPosts$Query instance) =>
    <String, dynamic>{
      'posts': instance.posts.map((e) => e.toJson()).toList(),
    };

EditProfile$Mutation$EditProfile _$EditProfile$Mutation$EditProfileFromJson(
        Map<String, dynamic> json) =>
    EditProfile$Mutation$EditProfile()
      ..username = json['username'] as String
      ..id = (json['id'] as num).toDouble()
      ..email = json['email'] as String
      ..gender = (json['gender'] as num?)?.toDouble()
      ..avatar = json['avatar'] as String?
      ..bio = json['bio'] as String?
      ..isEmailConfirmed = json['isEmailConfirmed'] as bool
      ..birthday = json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String)
      ..blockIncomingCalls = json['blockIncomingCalls'] as bool?;

Map<String, dynamic> _$EditProfile$Mutation$EditProfileToJson(
    EditProfile$Mutation$EditProfile instance) {
  final val = <String, dynamic>{
    'username': instance.username,
    'id': instance.id,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('gender', instance.gender);
  writeNotNull('avatar', instance.avatar);
  writeNotNull('bio', instance.bio);
  val['isEmailConfirmed'] = instance.isEmailConfirmed;
  writeNotNull('birthday', instance.birthday?.toIso8601String());
  writeNotNull('blockIncomingCalls', instance.blockIncomingCalls);
  return val;
}

EditProfile$Mutation _$EditProfile$MutationFromJson(
        Map<String, dynamic> json) =>
    EditProfile$Mutation()
      ..editProfile = EditProfile$Mutation$EditProfile.fromJson(
          json['editProfile'] as Map<String, dynamic>);

Map<String, dynamic> _$EditProfile$MutationToJson(
        EditProfile$Mutation instance) =>
    <String, dynamic>{
      'editProfile': instance.editProfile.toJson(),
    };

GetUserProfileArguments _$GetUserProfileArgumentsFromJson(
        Map<String, dynamic> json) =>
    GetUserProfileArguments(
      username: json['username'] as String,
    );

Map<String, dynamic> _$GetUserProfileArgumentsToJson(
        GetUserProfileArguments instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

RefreshTokenArguments _$RefreshTokenArgumentsFromJson(
        Map<String, dynamic> json) =>
    RefreshTokenArguments(
      refreshToken: json['refreshToken'] as String,
      userId: (json['userId'] as num).toDouble(),
    );

Map<String, dynamic> _$RefreshTokenArgumentsToJson(
        RefreshTokenArguments instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
      'userId': instance.userId,
    };

LoginArguments _$LoginArgumentsFromJson(Map<String, dynamic> json) =>
    LoginArguments(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginArgumentsToJson(LoginArguments instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

RegisterArguments _$RegisterArgumentsFromJson(Map<String, dynamic> json) =>
    RegisterArguments(
      username: json['username'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['passwordConfirmation'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$RegisterArgumentsToJson(RegisterArguments instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'passwordConfirmation': instance.passwordConfirmation,
      'email': instance.email,
    };

FetchRoomMessageArguments _$FetchRoomMessageArgumentsFromJson(
        Map<String, dynamic> json) =>
    FetchRoomMessageArguments(
      roomId: (json['roomId'] as num).toDouble(),
      offset: (json['offset'] as num?)?.toDouble(),
      limit: (json['limit'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FetchRoomMessageArgumentsToJson(
    FetchRoomMessageArguments instance) {
  final val = <String, dynamic>{
    'roomId': instance.roomId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('offset', instance.offset);
  writeNotNull('limit', instance.limit);
  return val;
}

FetchPostsArguments _$FetchPostsArgumentsFromJson(Map<String, dynamic> json) =>
    FetchPostsArguments(
      limit: (json['limit'] as num?)?.toDouble(),
      offset: (json['offset'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FetchPostsArgumentsToJson(FetchPostsArguments instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('limit', instance.limit);
  writeNotNull('offset', instance.offset);
  return val;
}

EditProfileArguments _$EditProfileArgumentsFromJson(
        Map<String, dynamic> json) =>
    EditProfileArguments(
      biography: json['biography'] as String?,
      username: json['username'] as String?,
      blockIncomingCalls: json['blockIncomingCalls'] as bool?,
      birthday: json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$EditProfileArgumentsToJson(
    EditProfileArguments instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('biography', instance.biography);
  writeNotNull('username', instance.username);
  writeNotNull('blockIncomingCalls', instance.blockIncomingCalls);
  writeNotNull('birthday', instance.birthday?.toIso8601String());
  writeNotNull('avatar', instance.avatar);
  return val;
}
