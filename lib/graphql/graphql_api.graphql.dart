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
