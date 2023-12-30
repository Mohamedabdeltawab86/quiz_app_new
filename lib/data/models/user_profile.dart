import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String name;
  final bool authenticated;
  final String authorization;

  const UserProfile(
      {this.name = 'UserProfile',
      this.authenticated = false,
      this.authorization = ''});

  UserProfile copyWith(
      {String? name, bool? authenticated, String? authorization}) {
    return UserProfile(
        name: name ?? this.name,
        authenticated: authenticated ?? this.authenticated,
        authorization: authorization ?? this.authorization);
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'],
      authenticated: json['authenticated'],
      authorization: json['authorization'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'authenticated': authenticated,
      'authorization': authorization,
    };
  }

  @override
  List<Object?> get props => [name, authenticated, authorization];
}
