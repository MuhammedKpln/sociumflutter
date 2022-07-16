// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
        Login$Mutation$Login$User instance) =>
    <String, dynamic>{
      'username': instance.username,
      'id': instance.id,
      'email': instance.email,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'bio': instance.bio,
      'isEmailConfirmed': instance.isEmailConfirmed,
      'birthday': instance.birthday?.toIso8601String(),
      'blockIncomingCalls': instance.blockIncomingCalls,
    };

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
        Register$Mutation$Register$User instance) =>
    <String, dynamic>{
      'username': instance.username,
      'id': instance.id,
      'email': instance.email,
      'gender': instance.gender,
      'avatar': instance.avatar,
      'bio': instance.bio,
      'isEmailConfirmed': instance.isEmailConfirmed,
      'birthday': instance.birthday?.toIso8601String(),
      'blockIncomingCalls': instance.blockIncomingCalls,
    };

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
        FetchPosts$Query$Posts$User instance) =>
    <String, dynamic>{
      'username': instance.username,
      'avatar': instance.avatar,
      'id': instance.id,
    };

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
        FetchPosts$Query$Posts instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'type': instance.type,
      'slug': instance.slug,
      'created_at': instance.createdAt.toIso8601String(),
      'postFromFollowers': instance.postFromFollowers,
      'additional': instance.additional,
      'userLike': instance.userLike?.toJson(),
      'postLike': instance.postLike.toJson(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'user': instance.user.toJson(),
      '_count': instance.$count.toJson(),
      'category': instance.category.toJson(),
    };

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

FetchPostsArguments _$FetchPostsArgumentsFromJson(Map<String, dynamic> json) =>
    FetchPostsArguments(
      limit: (json['limit'] as num?)?.toDouble(),
      offset: (json['offset'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FetchPostsArgumentsToJson(
        FetchPostsArguments instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
    };
