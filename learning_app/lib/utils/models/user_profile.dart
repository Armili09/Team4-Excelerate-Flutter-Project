class UserProfile {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String? bio;
  final String? profileImageUrl;
  final DateTime? dateOfBirth;
  final String? location;
  final String? occupation;
  final String? organization;
  final List<String> interests;
  final List<String> skills;
  final EducationLevel? educationLevel;
  final String? linkedInUrl;
  final String? githubUrl;
  final bool isPublicProfile;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.bio,
    this.profileImageUrl,
    this.dateOfBirth,
    this.location,
    this.occupation,
    this.organization,
    this.interests = const [],
    this.skills = const [],
    this.educationLevel,
    this.linkedInUrl,
    this.githubUrl,
    this.isPublicProfile = false,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName => '$firstName $lastName';

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'],
      bio: json['bio'],
      profileImageUrl: json['profileImageUrl'],
      dateOfBirth: json['dateOfBirth'] != null 
          ? DateTime.parse(json['dateOfBirth']) 
          : null,
      location: json['location'],
      occupation: json['occupation'],
      organization: json['organization'],
      interests: List<String>.from(json['interests'] ?? []),
      skills: List<String>.from(json['skills'] ?? []),
      educationLevel: json['educationLevel'] != null 
          ? EducationLevel.values.firstWhere(
              (e) => e.toString() == 'EducationLevel.${json['educationLevel']}',
              orElse: () => EducationLevel.other,
            )
          : null,
      linkedInUrl: json['linkedInUrl'],
      githubUrl: json['githubUrl'],
      isPublicProfile: json['isPublicProfile'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'location': location,
      'occupation': occupation,
      'organization': organization,
      'interests': interests,
      'skills': skills,
      'educationLevel': educationLevel?.toString().split('.').last,
      'linkedInUrl': linkedInUrl,
      'githubUrl': githubUrl,
      'isPublicProfile': isPublicProfile,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? bio,
    String? profileImageUrl,
    DateTime? dateOfBirth,
    String? location,
    String? occupation,
    String? organization,
    List<String>? interests,
    List<String>? skills,
    EducationLevel? educationLevel,
    String? linkedInUrl,
    String? githubUrl,
    bool? isPublicProfile,
  }) {
    return UserProfile(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      location: location ?? this.location,
      occupation: occupation ?? this.occupation,
      organization: organization ?? this.organization,
      interests: interests ?? this.interests,
      skills: skills ?? this.skills,
      educationLevel: educationLevel ?? this.educationLevel,
      linkedInUrl: linkedInUrl ?? this.linkedInUrl,
      githubUrl: githubUrl ?? this.githubUrl,
      isPublicProfile: isPublicProfile ?? this.isPublicProfile,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}

enum EducationLevel {
  highSchool,
  associate,
  bachelor,
  master,
  doctorate,
  other,
}
