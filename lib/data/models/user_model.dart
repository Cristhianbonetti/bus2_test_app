import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.gender,
    required super.name,
    required super.location,
    required super.email,
    required super.login,
    required super.dob,
    required super.registered,
    required super.phone,
    required super.cell,
    required super.id,
    required super.picture,
    required super.nat,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      gender: json['gender'] as String,
      name: UserNameModel.fromJson(json['name'] as Map<String, dynamic>),
      location:
          UserLocationModel.fromJson(json['location'] as Map<String, dynamic>),
      email: json['email'] as String,
      login: UserLoginModel.fromJson(json['login'] as Map<String, dynamic>),
      dob: UserDobModel.fromJson(json['dob'] as Map<String, dynamic>),
      registered: UserRegisteredModel.fromJson(
          json['registered'] as Map<String, dynamic>),
      phone: json['phone'] as String,
      cell: json['cell'] as String,
      id: UserIDModel.fromJson(json['id'] as Map<String, dynamic>),
      picture:
          UserPictureModel.fromJson(json['picture'] as Map<String, dynamic>),
      nat: json['nat'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'name': (name as UserNameModel).toJson(),
      'location': (location as UserLocationModel).toJson(),
      'email': email,
      'login': (login as UserLoginModel).toJson(),
      'dob': (dob as UserDobModel).toJson(),
      'registered': (registered as UserRegisteredModel).toJson(),
      'phone': phone,
      'cell': cell,
      'id': (id as UserIDModel).toJson(),
      'picture': (picture as UserPictureModel).toJson(),
      'nat': nat,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      gender: entity.gender,
      name: entity.name,
      location: entity.location,
      email: entity.email,
      login: entity.login,
      dob: entity.dob,
      registered: entity.registered,
      phone: entity.phone,
      cell: entity.cell,
      id: entity.id,
      picture: entity.picture,
      nat: entity.nat,
    );
  }
}

class UserNameModel extends UserName {
  const UserNameModel({
    required super.title,
    required super.first,
    required super.last,
  });

  factory UserNameModel.fromJson(Map<String, dynamic> json) {
    return UserNameModel(
      title: json['title'] as String,
      first: json['first'] as String,
      last: json['last'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'first': first,
      'last': last,
    };
  }
}

class UserLocationModel extends UserLocation {
  const UserLocationModel({
    required super.street,
    required super.city,
    required super.state,
    required super.country,
    required super.postcode,
    required super.coordinates,
    required super.timezone,
  });

  factory UserLocationModel.fromJson(Map<String, dynamic> json) {
    return UserLocationModel(
      street: UserStreetModel.fromJson(json['street'] as Map<String, dynamic>),
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      postcode: json['postcode'],
      coordinates: UserCoordinatesModel.fromJson(
          json['coordinates'] as Map<String, dynamic>),
      timezone: UserTimezoneModel.fromJson(
          json['timezone'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': (street as UserStreetModel).toJson(),
      'city': city,
      'state': state,
      'country': country,
      'postcode': postcode,
      'coordinates': (coordinates as UserCoordinatesModel).toJson(),
      'timezone': (timezone as UserTimezoneModel).toJson(),
    };
  }
}

class UserStreetModel extends UserStreet {
  const UserStreetModel({
    required super.number,
    required super.name,
  });

  factory UserStreetModel.fromJson(Map<String, dynamic> json) {
    return UserStreetModel(
      number: json['number'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
    };
  }
}

class UserCoordinatesModel extends UserCoordinates {
  const UserCoordinatesModel({
    required super.latitude,
    required super.longitude,
  });

  factory UserCoordinatesModel.fromJson(Map<String, dynamic> json) {
    return UserCoordinatesModel(
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class UserTimezoneModel extends UserTimezone {
  const UserTimezoneModel({
    required super.offset,
    required super.description,
  });

  factory UserTimezoneModel.fromJson(Map<String, dynamic> json) {
    return UserTimezoneModel(
      offset: json['offset'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'offset': offset,
      'description': description,
    };
  }
}

class UserLoginModel extends UserLogin {
  const UserLoginModel({
    required super.uuid,
    required super.username,
    required super.password,
    required super.salt,
    required super.md5,
    required super.sha1,
    required super.sha256,
  });

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      uuid: json['uuid'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      salt: json['salt'] as String,
      md5: json['md5'] as String,
      sha1: json['sha1'] as String,
      sha256: json['sha256'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'username': username,
      'password': password,
      'salt': salt,
      'md5': md5,
      'sha1': sha1,
      'sha256': sha256,
    };
  }
}

class UserDobModel extends UserDob {
  const UserDobModel({
    required super.date,
    required super.age,
  });

  factory UserDobModel.fromJson(Map<String, dynamic> json) {
    return UserDobModel(
      date: json['date'] as String,
      age: json['age'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'age': age,
    };
  }
}

class UserRegisteredModel extends UserRegistered {
  const UserRegisteredModel({
    required super.date,
    required super.age,
  });

  factory UserRegisteredModel.fromJson(Map<String, dynamic> json) {
    return UserRegisteredModel(
      date: json['date'] as String,
      age: json['age'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'age': age,
    };
  }
}

class UserIDModel extends UserID {
  const UserIDModel({
    super.name,
    super.value,
  });

  factory UserIDModel.fromJson(Map<String, dynamic> json) {
    return UserIDModel(
      name: json['name'] as String?,
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }
}

class UserPictureModel extends UserPicture {
  const UserPictureModel({
    required super.large,
    required super.medium,
    required super.thumbnail,
  });

  factory UserPictureModel.fromJson(Map<String, dynamic> json) {
    return UserPictureModel(
      large: json['large'] as String,
      medium: json['medium'] as String,
      thumbnail: json['thumbnail'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'large': large,
      'medium': medium,
      'thumbnail': thumbnail,
    };
  }
}

