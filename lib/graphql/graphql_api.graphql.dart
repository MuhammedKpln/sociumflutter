// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'graphql_api.graphql.g.dart';

mixin UserFieldsMixin {
  late String username;
  late double id;
  late String email;
  double? gender;
  String? avatar;
  String? bio;
  late bool isEmailConfirmed;
  DateTime? birthday;
  bool? blockIncomingCalls;
}

@JsonSerializable(explicitToJson: true)
class GetUserProfile$Query$GetUser$$count extends JsonSerializable
    with EquatableMixin {
  GetUserProfile$Query$GetUser$$count();

  factory GetUserProfile$Query$GetUser$$count.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserProfile$Query$GetUser$$countFromJson(json);

  late double followers;

  late double followings;

  late double posts;

  @override
  List<Object?> get props => [followers, followings, posts];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserProfile$Query$GetUser$$countToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUserProfile$Query$GetUser extends JsonSerializable
    with EquatableMixin {
  GetUserProfile$Query$GetUser();

  factory GetUserProfile$Query$GetUser.fromJson(Map<String, dynamic> json) =>
      _$GetUserProfile$Query$GetUserFromJson(json);

  late double id;

  late String username;

  String? bio;

  String? avatar;

  DateTime? birthday;

  @JsonKey(name: '_count')
  late GetUserProfile$Query$GetUser$$count $count;

  @override
  List<Object?> get props => [id, username, bio, avatar, birthday, $count];
  @override
  Map<String, dynamic> toJson() => _$GetUserProfile$Query$GetUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUserProfile$Query extends JsonSerializable with EquatableMixin {
  GetUserProfile$Query();

  factory GetUserProfile$Query.fromJson(Map<String, dynamic> json) =>
      _$GetUserProfile$QueryFromJson(json);

  late GetUserProfile$Query$GetUser getUser;

  @override
  List<Object?> get props => [getUser];
  @override
  Map<String, dynamic> toJson() => _$GetUserProfile$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RefreshToken$Mutation$RefreshToken extends JsonSerializable
    with EquatableMixin {
  RefreshToken$Mutation$RefreshToken();

  factory RefreshToken$Mutation$RefreshToken.fromJson(
          Map<String, dynamic> json) =>
      _$RefreshToken$Mutation$RefreshTokenFromJson(json);

  @JsonKey(name: 'access_token')
  late String accessToken;

  @JsonKey(name: 'refresh_token')
  late String refreshToken;

  @JsonKey(name: 'expire_date')
  late DateTime expireDate;

  @override
  List<Object?> get props => [accessToken, refreshToken, expireDate];
  @override
  Map<String, dynamic> toJson() =>
      _$RefreshToken$Mutation$RefreshTokenToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RefreshToken$Mutation extends JsonSerializable with EquatableMixin {
  RefreshToken$Mutation();

  factory RefreshToken$Mutation.fromJson(Map<String, dynamic> json) =>
      _$RefreshToken$MutationFromJson(json);

  late RefreshToken$Mutation$RefreshToken refreshToken;

  @override
  List<Object?> get props => [refreshToken];
  @override
  Map<String, dynamic> toJson() => _$RefreshToken$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchMessages$Query$Messages$Sender extends JsonSerializable
    with EquatableMixin {
  FetchMessages$Query$Messages$Sender();

  factory FetchMessages$Query$Messages$Sender.fromJson(
          Map<String, dynamic> json) =>
      _$FetchMessages$Query$Messages$SenderFromJson(json);

  late double id;

  late String username;

  String? avatar;

  late String email;

  @override
  List<Object?> get props => [id, username, avatar, email];
  @override
  Map<String, dynamic> toJson() =>
      _$FetchMessages$Query$Messages$SenderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchMessages$Query$Messages$Receiver extends JsonSerializable
    with EquatableMixin {
  FetchMessages$Query$Messages$Receiver();

  factory FetchMessages$Query$Messages$Receiver.fromJson(
          Map<String, dynamic> json) =>
      _$FetchMessages$Query$Messages$ReceiverFromJson(json);

  late double id;

  late String username;

  String? avatar;

  late String email;

  @override
  List<Object?> get props => [id, username, avatar, email];
  @override
  Map<String, dynamic> toJson() =>
      _$FetchMessages$Query$Messages$ReceiverToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchMessages$Query$Messages$Room extends JsonSerializable
    with EquatableMixin {
  FetchMessages$Query$Messages$Room();

  factory FetchMessages$Query$Messages$Room.fromJson(
          Map<String, dynamic> json) =>
      _$FetchMessages$Query$Messages$RoomFromJson(json);

  late double id;

  late String roomAdress;

  @JsonKey(name: 'created_at')
  late DateTime createdAt;

  @JsonKey(name: 'updated_at')
  late DateTime updatedAt;

  late DateTime expireDate;

  @override
  List<Object?> get props => [id, roomAdress, createdAt, updatedAt, expireDate];
  @override
  Map<String, dynamic> toJson() =>
      _$FetchMessages$Query$Messages$RoomToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchMessages$Query$Messages extends JsonSerializable
    with EquatableMixin {
  FetchMessages$Query$Messages();

  factory FetchMessages$Query$Messages.fromJson(Map<String, dynamic> json) =>
      _$FetchMessages$Query$MessagesFromJson(json);

  late double id;

  late String message;

  late bool seen;

  late FetchMessages$Query$Messages$Sender sender;

  late FetchMessages$Query$Messages$Receiver receiver;

  late FetchMessages$Query$Messages$Room room;

  @override
  List<Object?> get props => [id, message, seen, sender, receiver, room];
  @override
  Map<String, dynamic> toJson() => _$FetchMessages$Query$MessagesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchMessages$Query extends JsonSerializable with EquatableMixin {
  FetchMessages$Query();

  factory FetchMessages$Query.fromJson(Map<String, dynamic> json) =>
      _$FetchMessages$QueryFromJson(json);

  late List<FetchMessages$Query$Messages> messages;

  @override
  List<Object?> get props => [messages];
  @override
  Map<String, dynamic> toJson() => _$FetchMessages$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Login$Mutation$Login$User extends JsonSerializable
    with EquatableMixin, UserFieldsMixin {
  Login$Mutation$Login$User();

  factory Login$Mutation$Login$User.fromJson(Map<String, dynamic> json) =>
      _$Login$Mutation$Login$UserFromJson(json);

  @override
  List<Object?> get props => [
        username,
        id,
        email,
        gender,
        avatar,
        bio,
        isEmailConfirmed,
        birthday,
        blockIncomingCalls
      ];
  @override
  Map<String, dynamic> toJson() => _$Login$Mutation$Login$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Login$Mutation$Login extends JsonSerializable with EquatableMixin {
  Login$Mutation$Login();

  factory Login$Mutation$Login.fromJson(Map<String, dynamic> json) =>
      _$Login$Mutation$LoginFromJson(json);

  @JsonKey(name: 'access_token')
  late String accessToken;

  @JsonKey(name: 'refresh_token')
  late String refreshToken;

  @JsonKey(name: 'expire_date')
  late DateTime expireDate;

  late Login$Mutation$Login$User user;

  @override
  List<Object?> get props => [accessToken, refreshToken, expireDate, user];
  @override
  Map<String, dynamic> toJson() => _$Login$Mutation$LoginToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Login$Mutation extends JsonSerializable with EquatableMixin {
  Login$Mutation();

  factory Login$Mutation.fromJson(Map<String, dynamic> json) =>
      _$Login$MutationFromJson(json);

  late Login$Mutation$Login login;

  @override
  List<Object?> get props => [login];
  @override
  Map<String, dynamic> toJson() => _$Login$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Register$Mutation$Register$User extends JsonSerializable
    with EquatableMixin, UserFieldsMixin {
  Register$Mutation$Register$User();

  factory Register$Mutation$Register$User.fromJson(Map<String, dynamic> json) =>
      _$Register$Mutation$Register$UserFromJson(json);

  @override
  List<Object?> get props => [
        username,
        id,
        email,
        gender,
        avatar,
        bio,
        isEmailConfirmed,
        birthday,
        blockIncomingCalls
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$Register$Mutation$Register$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Register$Mutation$Register extends JsonSerializable with EquatableMixin {
  Register$Mutation$Register();

  factory Register$Mutation$Register.fromJson(Map<String, dynamic> json) =>
      _$Register$Mutation$RegisterFromJson(json);

  @JsonKey(name: 'access_token')
  late String accessToken;

  @JsonKey(name: 'refresh_token')
  late String refreshToken;

  @JsonKey(name: 'expire_date')
  late DateTime expireDate;

  late Register$Mutation$Register$User user;

  @override
  List<Object?> get props => [accessToken, refreshToken, expireDate, user];
  @override
  Map<String, dynamic> toJson() => _$Register$Mutation$RegisterToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Register$Mutation extends JsonSerializable with EquatableMixin {
  Register$Mutation();

  factory Register$Mutation.fromJson(Map<String, dynamic> json) =>
      _$Register$MutationFromJson(json);

  late Register$Mutation$Register register;

  @override
  List<Object?> get props => [register];
  @override
  Map<String, dynamic> toJson() => _$Register$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchRoomMessage$Query$MessagesFromRoom$Sender extends JsonSerializable
    with EquatableMixin {
  FetchRoomMessage$Query$MessagesFromRoom$Sender();

  factory FetchRoomMessage$Query$MessagesFromRoom$Sender.fromJson(
          Map<String, dynamic> json) =>
      _$FetchRoomMessage$Query$MessagesFromRoom$SenderFromJson(json);

  late String username;

  late double id;

  late String email;

  double? gender;

  String? avatar;

  String? bio;

  late bool isEmailConfirmed;

  DateTime? birthday;

  bool? blockIncomingCalls;

  @override
  List<Object?> get props => [
        username,
        id,
        email,
        gender,
        avatar,
        bio,
        isEmailConfirmed,
        birthday,
        blockIncomingCalls
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$FetchRoomMessage$Query$MessagesFromRoom$SenderToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchRoomMessage$Query$MessagesFromRoom$Receiver extends JsonSerializable
    with EquatableMixin {
  FetchRoomMessage$Query$MessagesFromRoom$Receiver();

  factory FetchRoomMessage$Query$MessagesFromRoom$Receiver.fromJson(
          Map<String, dynamic> json) =>
      _$FetchRoomMessage$Query$MessagesFromRoom$ReceiverFromJson(json);

  late String username;

  late double id;

  late String email;

  double? gender;

  String? avatar;

  String? bio;

  late bool isEmailConfirmed;

  DateTime? birthday;

  bool? blockIncomingCalls;

  @override
  List<Object?> get props => [
        username,
        id,
        email,
        gender,
        avatar,
        bio,
        isEmailConfirmed,
        birthday,
        blockIncomingCalls
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$FetchRoomMessage$Query$MessagesFromRoom$ReceiverToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchRoomMessage$Query$MessagesFromRoom$Room extends JsonSerializable
    with EquatableMixin {
  FetchRoomMessage$Query$MessagesFromRoom$Room();

  factory FetchRoomMessage$Query$MessagesFromRoom$Room.fromJson(
          Map<String, dynamic> json) =>
      _$FetchRoomMessage$Query$MessagesFromRoom$RoomFromJson(json);

  late double id;

  late String roomAdress;

  @override
  List<Object?> get props => [id, roomAdress];
  @override
  Map<String, dynamic> toJson() =>
      _$FetchRoomMessage$Query$MessagesFromRoom$RoomToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchRoomMessage$Query$MessagesFromRoom extends JsonSerializable
    with EquatableMixin {
  FetchRoomMessage$Query$MessagesFromRoom();

  factory FetchRoomMessage$Query$MessagesFromRoom.fromJson(
          Map<String, dynamic> json) =>
      _$FetchRoomMessage$Query$MessagesFromRoomFromJson(json);

  late FetchRoomMessage$Query$MessagesFromRoom$Sender sender;

  late FetchRoomMessage$Query$MessagesFromRoom$Receiver receiver;

  late FetchRoomMessage$Query$MessagesFromRoom$Room room;

  late bool seen;

  late String message;

  @JsonKey(name: 'created_at')
  late DateTime createdAt;

  late double id;

  @override
  List<Object?> get props =>
      [sender, receiver, room, seen, message, createdAt, id];
  @override
  Map<String, dynamic> toJson() =>
      _$FetchRoomMessage$Query$MessagesFromRoomToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchRoomMessage$Query extends JsonSerializable with EquatableMixin {
  FetchRoomMessage$Query();

  factory FetchRoomMessage$Query.fromJson(Map<String, dynamic> json) =>
      _$FetchRoomMessage$QueryFromJson(json);

  late List<FetchRoomMessage$Query$MessagesFromRoom> messagesFromRoom;

  @override
  List<Object?> get props => [messagesFromRoom];
  @override
  Map<String, dynamic> toJson() => _$FetchRoomMessage$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchPosts$Query$Posts$UserLike extends JsonSerializable
    with EquatableMixin {
  FetchPosts$Query$Posts$UserLike();

  factory FetchPosts$Query$Posts$UserLike.fromJson(Map<String, dynamic> json) =>
      _$FetchPosts$Query$Posts$UserLikeFromJson(json);

  late bool liked;

  @override
  List<Object?> get props => [liked];
  @override
  Map<String, dynamic> toJson() =>
      _$FetchPosts$Query$Posts$UserLikeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchPosts$Query$Posts$PostLike extends JsonSerializable
    with EquatableMixin {
  FetchPosts$Query$Posts$PostLike();

  factory FetchPosts$Query$Posts$PostLike.fromJson(Map<String, dynamic> json) =>
      _$FetchPosts$Query$Posts$PostLikeFromJson(json);

  late double likeCount;

  @override
  List<Object?> get props => [likeCount];
  @override
  Map<String, dynamic> toJson() =>
      _$FetchPosts$Query$Posts$PostLikeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchPosts$Query$Posts$User extends JsonSerializable with EquatableMixin {
  FetchPosts$Query$Posts$User();

  factory FetchPosts$Query$Posts$User.fromJson(Map<String, dynamic> json) =>
      _$FetchPosts$Query$Posts$UserFromJson(json);

  late String username;

  String? avatar;

  late double id;

  @override
  List<Object?> get props => [username, avatar, id];
  @override
  Map<String, dynamic> toJson() => _$FetchPosts$Query$Posts$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchPosts$Query$Posts$$count extends JsonSerializable
    with EquatableMixin {
  FetchPosts$Query$Posts$$count();

  factory FetchPosts$Query$Posts$$count.fromJson(Map<String, dynamic> json) =>
      _$FetchPosts$Query$Posts$$countFromJson(json);

  late double comment;

  @override
  List<Object?> get props => [comment];
  @override
  Map<String, dynamic> toJson() => _$FetchPosts$Query$Posts$$countToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchPosts$Query$Posts$Category extends JsonSerializable
    with EquatableMixin {
  FetchPosts$Query$Posts$Category();

  factory FetchPosts$Query$Posts$Category.fromJson(Map<String, dynamic> json) =>
      _$FetchPosts$Query$Posts$CategoryFromJson(json);

  late double id;

  late String name;

  @override
  List<Object?> get props => [id, name];
  @override
  Map<String, dynamic> toJson() =>
      _$FetchPosts$Query$Posts$CategoryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchPosts$Query$Posts extends JsonSerializable with EquatableMixin {
  FetchPosts$Query$Posts();

  factory FetchPosts$Query$Posts.fromJson(Map<String, dynamic> json) =>
      _$FetchPosts$Query$PostsFromJson(json);

  late double id;

  late String content;

  late double type;

  late String slug;

  @JsonKey(name: 'created_at')
  late DateTime createdAt;

  bool? postFromFollowers;

  String? additional;

  FetchPosts$Query$Posts$UserLike? userLike;

  late FetchPosts$Query$Posts$PostLike postLike;

  @JsonKey(name: 'updated_at')
  late DateTime updatedAt;

  late FetchPosts$Query$Posts$User user;

  @JsonKey(name: '_count')
  late FetchPosts$Query$Posts$$count $count;

  late FetchPosts$Query$Posts$Category category;

  @override
  List<Object?> get props => [
        id,
        content,
        type,
        slug,
        createdAt,
        postFromFollowers,
        additional,
        userLike,
        postLike,
        updatedAt,
        user,
        $count,
        category
      ];
  @override
  Map<String, dynamic> toJson() => _$FetchPosts$Query$PostsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchPosts$Query extends JsonSerializable with EquatableMixin {
  FetchPosts$Query();

  factory FetchPosts$Query.fromJson(Map<String, dynamic> json) =>
      _$FetchPosts$QueryFromJson(json);

  late List<FetchPosts$Query$Posts> posts;

  @override
  List<Object?> get props => [posts];
  @override
  Map<String, dynamic> toJson() => _$FetchPosts$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUserProfileArguments extends JsonSerializable with EquatableMixin {
  GetUserProfileArguments({required this.username});

  @override
  factory GetUserProfileArguments.fromJson(Map<String, dynamic> json) =>
      _$GetUserProfileArgumentsFromJson(json);

  late String username;

  @override
  List<Object?> get props => [username];
  @override
  Map<String, dynamic> toJson() => _$GetUserProfileArgumentsToJson(this);
}

final GET_USER_PROFILE_QUERY_DOCUMENT_OPERATION_NAME = 'GET_USER_PROFILE';
final GET_USER_PROFILE_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GET_USER_PROFILE'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'username')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'getUser'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'username'),
                  value: VariableNode(name: NameNode(value: 'username')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'bio'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'avatar'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'birthday'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: '_count'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'followers'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'followings'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'posts'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class GetUserProfileQuery
    extends GraphQLQuery<GetUserProfile$Query, GetUserProfileArguments> {
  GetUserProfileQuery({required this.variables});

  @override
  final DocumentNode document = GET_USER_PROFILE_QUERY_DOCUMENT;

  @override
  final String operationName = GET_USER_PROFILE_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final GetUserProfileArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  GetUserProfile$Query parse(Map<String, dynamic> json) =>
      GetUserProfile$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class RefreshTokenArguments extends JsonSerializable with EquatableMixin {
  RefreshTokenArguments({required this.refreshToken, required this.userId});

  @override
  factory RefreshTokenArguments.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenArgumentsFromJson(json);

  late String refreshToken;

  late double userId;

  @override
  List<Object?> get props => [refreshToken, userId];
  @override
  Map<String, dynamic> toJson() => _$RefreshTokenArgumentsToJson(this);
}

final REFRESH_TOKEN_MUTATION_DOCUMENT_OPERATION_NAME = 'REFRESH_TOKEN';
final REFRESH_TOKEN_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'REFRESH_TOKEN'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'refreshToken')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'userId')),
            type:
                NamedTypeNode(name: NameNode(value: 'Float'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'refreshToken'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'refreshToken'),
                  value: VariableNode(name: NameNode(value: 'refreshToken'))),
              ArgumentNode(
                  name: NameNode(value: 'userId'),
                  value: VariableNode(name: NameNode(value: 'userId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'access_token'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'refresh_token'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'expire_date'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class RefreshTokenMutation
    extends GraphQLQuery<RefreshToken$Mutation, RefreshTokenArguments> {
  RefreshTokenMutation({required this.variables});

  @override
  final DocumentNode document = REFRESH_TOKEN_MUTATION_DOCUMENT;

  @override
  final String operationName = REFRESH_TOKEN_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final RefreshTokenArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  RefreshToken$Mutation parse(Map<String, dynamic> json) =>
      RefreshToken$Mutation.fromJson(json);
}

final FETCH_MESSAGES_QUERY_DOCUMENT_OPERATION_NAME = 'FETCH_MESSAGES';
final FETCH_MESSAGES_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'FETCH_MESSAGES'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'messages'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'pagination'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'offset'),
                        value: IntValueNode(value: '0')),
                    ObjectFieldNode(
                        name: NameNode(value: 'limit'),
                        value: IntValueNode(value: '10'))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'message'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'seen'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'sender'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'avatar'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'email'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'receiver'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'avatar'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'email'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'room'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'roomAdress'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'created_at'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'updated_at'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'expireDate'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class FetchMessagesQuery
    extends GraphQLQuery<FetchMessages$Query, JsonSerializable> {
  FetchMessagesQuery();

  @override
  final DocumentNode document = FETCH_MESSAGES_QUERY_DOCUMENT;

  @override
  final String operationName = FETCH_MESSAGES_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  List<Object?> get props => [document, operationName];
  @override
  FetchMessages$Query parse(Map<String, dynamic> json) =>
      FetchMessages$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class LoginArguments extends JsonSerializable with EquatableMixin {
  LoginArguments({required this.email, required this.password});

  @override
  factory LoginArguments.fromJson(Map<String, dynamic> json) =>
      _$LoginArgumentsFromJson(json);

  late String email;

  late String password;

  @override
  List<Object?> get props => [email, password];
  @override
  Map<String, dynamic> toJson() => _$LoginArgumentsToJson(this);
}

final LOGIN_MUTATION_DOCUMENT_OPERATION_NAME = 'Login';
final LOGIN_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'Login'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'email')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'password')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'login'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'email'),
                        value: VariableNode(name: NameNode(value: 'email'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'password'),
                        value: VariableNode(name: NameNode(value: 'password')))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'access_token'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'refresh_token'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'expire_date'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'UserFields'), directives: [])
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'UserFields'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'username'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'email'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'gender'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'avatar'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'bio'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'isEmailConfirmed'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'birthday'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'blockIncomingCalls'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class LoginMutation extends GraphQLQuery<Login$Mutation, LoginArguments> {
  LoginMutation({required this.variables});

  @override
  final DocumentNode document = LOGIN_MUTATION_DOCUMENT;

  @override
  final String operationName = LOGIN_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final LoginArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  Login$Mutation parse(Map<String, dynamic> json) =>
      Login$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class RegisterArguments extends JsonSerializable with EquatableMixin {
  RegisterArguments(
      {required this.username,
      required this.password,
      required this.passwordConfirmation,
      required this.email});

  @override
  factory RegisterArguments.fromJson(Map<String, dynamic> json) =>
      _$RegisterArgumentsFromJson(json);

  late String username;

  late String password;

  late String passwordConfirmation;

  late String email;

  @override
  List<Object?> get props => [username, password, passwordConfirmation, email];
  @override
  Map<String, dynamic> toJson() => _$RegisterArgumentsToJson(this);
}

final REGISTER_MUTATION_DOCUMENT_OPERATION_NAME = 'REGISTER';
final REGISTER_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'REGISTER'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'username')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'password')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable:
                VariableNode(name: NameNode(value: 'passwordConfirmation')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'email')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'register'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'data'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'username'),
                        value: VariableNode(name: NameNode(value: 'username'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'password'),
                        value: VariableNode(name: NameNode(value: 'password'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'password_confirmation'),
                        value: VariableNode(
                            name: NameNode(value: 'passwordConfirmation'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'email'),
                        value: VariableNode(name: NameNode(value: 'email')))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'access_token'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'refresh_token'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'expire_date'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FragmentSpreadNode(
                        name: NameNode(value: 'UserFields'), directives: [])
                  ]))
            ]))
      ])),
  FragmentDefinitionNode(
      name: NameNode(value: 'UserFields'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(name: NameNode(value: 'User'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'username'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'email'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'gender'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'avatar'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'bio'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'isEmailConfirmed'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'birthday'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'blockIncomingCalls'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null)
      ]))
]);

class RegisterMutation
    extends GraphQLQuery<Register$Mutation, RegisterArguments> {
  RegisterMutation({required this.variables});

  @override
  final DocumentNode document = REGISTER_MUTATION_DOCUMENT;

  @override
  final String operationName = REGISTER_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final RegisterArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  Register$Mutation parse(Map<String, dynamic> json) =>
      Register$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class FetchRoomMessageArguments extends JsonSerializable with EquatableMixin {
  FetchRoomMessageArguments({required this.roomId, this.offset, this.limit});

  @override
  factory FetchRoomMessageArguments.fromJson(Map<String, dynamic> json) =>
      _$FetchRoomMessageArgumentsFromJson(json);

  late double roomId;

  final double? offset;

  final double? limit;

  @override
  List<Object?> get props => [roomId, offset, limit];
  @override
  Map<String, dynamic> toJson() => _$FetchRoomMessageArgumentsToJson(this);
}

final FETCH_ROOM_MESSAGE_QUERY_DOCUMENT_OPERATION_NAME = 'FETCH_ROOM_MESSAGE';
final FETCH_ROOM_MESSAGE_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'FETCH_ROOM_MESSAGE'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'roomId')),
            type:
                NamedTypeNode(name: NameNode(value: 'Float'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'offset')),
            type:
                NamedTypeNode(name: NameNode(value: 'Float'), isNonNull: false),
            defaultValue: DefaultValueNode(value: IntValueNode(value: '0')),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type:
                NamedTypeNode(name: NameNode(value: 'Float'), isNonNull: false),
            defaultValue: DefaultValueNode(value: IntValueNode(value: '15')),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'messagesFromRoom'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'roomId'),
                  value: VariableNode(name: NameNode(value: 'roomId'))),
              ArgumentNode(
                  name: NameNode(value: 'pagination'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'offset'),
                        value: VariableNode(name: NameNode(value: 'offset'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'limit'),
                        value: VariableNode(name: NameNode(value: 'limit')))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'sender'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'email'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'gender'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'avatar'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'bio'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'isEmailConfirmed'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'birthday'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'blockIncomingCalls'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'receiver'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'email'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'gender'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'avatar'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'bio'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'isEmailConfirmed'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'birthday'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'blockIncomingCalls'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'room'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'roomAdress'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'seen'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'message'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'created_at'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class FetchRoomMessageQuery
    extends GraphQLQuery<FetchRoomMessage$Query, FetchRoomMessageArguments> {
  FetchRoomMessageQuery({required this.variables});

  @override
  final DocumentNode document = FETCH_ROOM_MESSAGE_QUERY_DOCUMENT;

  @override
  final String operationName = FETCH_ROOM_MESSAGE_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final FetchRoomMessageArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  FetchRoomMessage$Query parse(Map<String, dynamic> json) =>
      FetchRoomMessage$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class FetchPostsArguments extends JsonSerializable with EquatableMixin {
  FetchPostsArguments({this.limit, this.offset});

  @override
  factory FetchPostsArguments.fromJson(Map<String, dynamic> json) =>
      _$FetchPostsArgumentsFromJson(json);

  final double? limit;

  final double? offset;

  @override
  List<Object?> get props => [limit, offset];
  @override
  Map<String, dynamic> toJson() => _$FetchPostsArgumentsToJson(this);
}

final FETCH_POSTS_QUERY_DOCUMENT_OPERATION_NAME = 'FETCH_POSTS';
final FETCH_POSTS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'FETCH_POSTS'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type:
                NamedTypeNode(name: NameNode(value: 'Float'), isNonNull: false),
            defaultValue: DefaultValueNode(value: IntValueNode(value: '15')),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'offset')),
            type:
                NamedTypeNode(name: NameNode(value: 'Float'), isNonNull: false),
            defaultValue: DefaultValueNode(value: IntValueNode(value: '0')),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'posts'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'pagination'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'limit'),
                        value: VariableNode(name: NameNode(value: 'limit'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'offset'),
                        value: VariableNode(name: NameNode(value: 'offset')))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'content'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'type'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'slug'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'created_at'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'postFromFollowers'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'additional'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'userLike'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'liked'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'postLike'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'likeCount'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'updated_at'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'avatar'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: '_count'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'comment'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'category'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class FetchPostsQuery
    extends GraphQLQuery<FetchPosts$Query, FetchPostsArguments> {
  FetchPostsQuery({required this.variables});

  @override
  final DocumentNode document = FETCH_POSTS_QUERY_DOCUMENT;

  @override
  final String operationName = FETCH_POSTS_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  final FetchPostsArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  FetchPosts$Query parse(Map<String, dynamic> json) =>
      FetchPosts$Query.fromJson(json);
}
