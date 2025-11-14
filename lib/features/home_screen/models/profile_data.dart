class ProfileData {
  const ProfileData({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.resumeUrl,
    required this.photoUrl,
  });

  factory ProfileData.fromMap(Map<String, dynamic> map) {
    String readField(String key) => (map[key] ?? '').toString().trim();

    String fullName = readField('full_name');
    if (fullName.isEmpty) {
      final first = readField('first_name');
      final last = readField('last_name');
      fullName = [first, last].where((e) => e.isNotEmpty).join(' ').trim();
    }

    return ProfileData(
      fullName: fullName,
      phone: readField('phone'),
      email: readField('email'),
      resumeUrl: readField('cv_url'),
      photoUrl: readField('photo_url'),
    );
  }

  final String fullName;
  final String phone;
  final String email;
  final String resumeUrl;
  final String photoUrl;

  String get displayName => fullName.isNotEmpty ? fullName : '-';

  String get initials {
    final parts =
        displayName.split(RegExp(r'\s+')).where((element) => element.isNotEmpty).toList();
    if (parts.isEmpty) return '--';
    if (parts.length == 1) {
      final word = parts.first;
      return word.substring(0, word.length >= 2 ? 2 : 1).toUpperCase();
    }
    final first = parts.first.substring(0, 1);
    final last = parts.last.substring(0, 1);
    return (first + last).toUpperCase();
  }

  String get phoneDisplay => phone.isNotEmpty ? phone : '-';
  String get emailDisplay => email.isNotEmpty ? email : '-';
  String get resumeDisplay => resumeUrl;
  bool get hasResume => resumeUrl.isNotEmpty;
  bool get hasPhoto => photoUrl.isNotEmpty;
}
