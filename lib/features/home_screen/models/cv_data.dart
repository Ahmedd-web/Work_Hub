class CvData {
  const CvData({
    required this.jobTitleAr,
    required this.jobTitleEn,
    required this.educationLevel,
    required this.yearsExperience,
    required this.phones,
    required this.email,
    required this.skills,
    required this.summaryAr,
    required this.summaryEn,
    required this.education,
    required this.experiences,
    required this.courses,
    required this.updatedAt,
  });

  factory CvData.fromMap(Map<String, dynamic> map) {
    return CvData(
      jobTitleAr: (map['jobTitleAr'] ?? '').toString(),
      jobTitleEn: (map['jobTitleEn'] ?? '').toString(),
      educationLevel: (map['educationLevel'] ?? '').toString(),
      yearsExperience: (map['yearsExperience'] ?? '').toString(),
      phones:
          (map['phones'] as List<dynamic>? ?? const [])
              .map((e) => e.toString())
              .toList(),
      email: (map['email'] ?? '').toString(),
      skills:
          (map['skills'] as List<dynamic>? ?? const [])
              .map((e) => e.toString())
              .toList(),
      summaryAr: (map['summaryAr'] ?? '').toString(),
      summaryEn: (map['summaryEn'] ?? '').toString(),
      education:
          (map['education'] as List<dynamic>? ?? const [])
              .map((e) => CvEducationEntry.fromMap(e as Map<String, dynamic>))
              .toList(),
      experiences:
          (map['experiences'] as List<dynamic>? ?? const [])
              .map((e) => CvExperienceEntry.fromMap(e as Map<String, dynamic>))
              .toList(),
      courses:
          (map['courses'] as List<dynamic>? ?? const [])
              .map((e) => CvCourseEntry.fromMap(e as Map<String, dynamic>))
              .toList(),
      updatedAt: DateTime.tryParse((map['updatedAt'] ?? '').toString()) ??
          DateTime.now(),
    );
  }

  final String jobTitleAr;
  final String jobTitleEn;
  final String educationLevel;
  final String yearsExperience;
  final List<String> phones;
  final String email;
  final List<String> skills;
  final String summaryAr;
  final String summaryEn;
  final List<CvEducationEntry> education;
  final List<CvExperienceEntry> experiences;
  final List<CvCourseEntry> courses;
  final DateTime updatedAt;

  Map<String, dynamic> toMap() {
    return {
      'jobTitleAr': jobTitleAr,
      'jobTitleEn': jobTitleEn,
      'educationLevel': educationLevel,
      'yearsExperience': yearsExperience,
      'phones': phones,
      'email': email,
      'skills': skills,
      'summaryAr': summaryAr,
      'summaryEn': summaryEn,
      'education': education.map((e) => e.toMap()).toList(),
      'experiences': experiences.map((e) => e.toMap()).toList(),
      'courses': courses.map((e) => e.toMap()).toList(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  CvData copyWith({
    String? jobTitleAr,
    String? jobTitleEn,
    String? educationLevel,
    String? yearsExperience,
    List<String>? phones,
    String? email,
    List<String>? skills,
    String? summaryAr,
    String? summaryEn,
    List<CvEducationEntry>? education,
    List<CvExperienceEntry>? experiences,
    List<CvCourseEntry>? courses,
    DateTime? updatedAt,
  }) {
    return CvData(
      jobTitleAr: jobTitleAr ?? this.jobTitleAr,
      jobTitleEn: jobTitleEn ?? this.jobTitleEn,
      educationLevel: educationLevel ?? this.educationLevel,
      yearsExperience: yearsExperience ?? this.yearsExperience,
      phones: phones ?? this.phones,
      email: email ?? this.email,
      skills: skills ?? this.skills,
      summaryAr: summaryAr ?? this.summaryAr,
      summaryEn: summaryEn ?? this.summaryEn,
      education: education ?? this.education,
      experiences: experiences ?? this.experiences,
      courses: courses ?? this.courses,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CvEducationEntry {
  const CvEducationEntry({
    required this.institution,
    required this.majorAr,
    required this.majorEn,
    required this.startDate,
    required this.endDate,
  });

  factory CvEducationEntry.fromMap(Map<String, dynamic> map) {
    return CvEducationEntry(
      institution: (map['institution'] ?? '').toString(),
      majorAr: (map['majorAr'] ?? '').toString(),
      majorEn: (map['majorEn'] ?? '').toString(),
      startDate: (map['startDate'] ?? '').toString(),
      endDate: (map['endDate'] ?? '').toString(),
    );
  }

  final String institution;
  final String majorAr;
  final String majorEn;
  final String startDate;
  final String endDate;

  Map<String, dynamic> toMap() {
    return {
      'institution': institution,
      'majorAr': majorAr,
      'majorEn': majorEn,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}

class CvExperienceEntry {
  const CvExperienceEntry({
    required this.companyAr,
    required this.companyEn,
    required this.roleAr,
    required this.roleEn,
    required this.description,
    required this.startDate,
    required this.endDate,
  });

  factory CvExperienceEntry.fromMap(Map<String, dynamic> map) {
    return CvExperienceEntry(
      companyAr: (map['companyAr'] ?? '').toString(),
      companyEn: (map['companyEn'] ?? '').toString(),
      roleAr: (map['roleAr'] ?? '').toString(),
      roleEn: (map['roleEn'] ?? '').toString(),
      description: (map['description'] ?? '').toString(),
      startDate: (map['startDate'] ?? '').toString(),
      endDate: (map['endDate'] ?? '').toString(),
    );
  }

  final String companyAr;
  final String companyEn;
  final String roleAr;
  final String roleEn;
  final String description;
  final String startDate;
  final String endDate;

  Map<String, dynamic> toMap() {
    return {
      'companyAr': companyAr,
      'companyEn': companyEn,
      'roleAr': roleAr,
      'roleEn': roleEn,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
    };
  }
}

class CvCourseEntry {
  const CvCourseEntry({
    required this.organization,
    required this.title,
    required this.date,
  });

  factory CvCourseEntry.fromMap(Map<String, dynamic> map) {
    return CvCourseEntry(
      organization: (map['organization'] ?? '').toString(),
      title: (map['title'] ?? '').toString(),
      date: (map['date'] ?? '').toString(),
    );
  }

  final String organization;
  final String title;
  final String date;

  Map<String, dynamic> toMap() {
    return {
      'organization': organization,
      'title': title,
      'date': date,
    };
  }
}
