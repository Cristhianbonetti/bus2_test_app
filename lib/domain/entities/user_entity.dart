import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String gender;
  final UserName name;
  final UserLocation location;
  final String email;
  final UserLogin login;
  final UserDob dob;
  final UserRegistered registered;
  final String phone;
  final String cell;
  final UserID id;
  final UserPicture picture;
  final String nat;

  const UserEntity({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.login,
    required this.dob,
    required this.registered,
    required this.phone,
    required this.cell,
    required this.id,
    required this.picture,
    required this.nat,
  });

  @override
  List<Object?> get props => [
        gender,
        name,
        location,
        email,
        login,
        dob,
        registered,
        phone,
        cell,
        id,
        picture,
        nat,
      ];
}

class UserName extends Equatable {
  final String title;
  final String first;
  final String last;

  const UserName({
    required this.title,
    required this.first,
    required this.last,
  });

  String get fullName => '$title $first $last';

  @override
  List<Object?> get props => [title, first, last];
}

class UserLocation extends Equatable {
  final UserStreet street;
  final String city;
  final String state;
  final String country;
  final dynamic postcode;
  final UserCoordinates coordinates;
  final UserTimezone timezone;

  const UserLocation({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  String get fullAddress =>
      '${street.number} ${street.name}, $city, $state, $country - $postcode';

  @override
  List<Object?> get props =>
      [street, city, state, country, postcode, coordinates, timezone];
}

class UserStreet extends Equatable {
  final int number;
  final String name;

  const UserStreet({
    required this.number,
    required this.name,
  });

  @override
  List<Object?> get props => [number, name];
}

class UserCoordinates extends Equatable {
  final String latitude;
  final String longitude;

  const UserCoordinates({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}

class UserTimezone extends Equatable {
  final String offset;
  final String description;

  const UserTimezone({
    required this.offset,
    required this.description,
  });

  @override
  List<Object?> get props => [offset, description];
}

class UserLogin extends Equatable {
  final String uuid;
  final String username;
  final String password;
  final String salt;
  final String md5;
  final String sha1;
  final String sha256;

  const UserLogin({
    required this.uuid,
    required this.username,
    required this.password,
    required this.salt,
    required this.md5,
    required this.sha1,
    required this.sha256,
  });

  @override
  List<Object?> get props => [uuid, username, password, salt, md5, sha1, sha256];
}

class UserDob extends Equatable {
  final String date;
  final int age;

  const UserDob({
    required this.date,
    required this.age,
  });

  @override
  List<Object?> get props => [date, age];
}

class UserRegistered extends Equatable {
  final String date;
  final int age;

  const UserRegistered({
    required this.date,
    required this.age,
  });

  @override
  List<Object?> get props => [date, age];
}

class UserID extends Equatable {
  final String? name;
  final String? value;

  const UserID({
    this.name,
    this.value,
  });

  @override
  List<Object?> get props => [name, value];
}

class UserPicture extends Equatable {
  final String large;
  final String medium;
  final String thumbnail;

  const UserPicture({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [large, medium, thumbnail];
}

