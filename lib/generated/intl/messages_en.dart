import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(error) => "An error occurred while loading data: ${error}";

  static String m1(error) => "Failed to save bio: ${error}";

  static String m2(error) => "Failed to save: ${error}";

  static String m3(value) => "Education level: ${value}";

  static String m4(value) => "Experience: ${value}";

  static String m5(error) => "Couldn\'t load jobs: ${error}";

  static String m6(count) => "${count} ad edits";

  static String m7(count) => "${count} featured boosts";

  static String m8(count) => "${count} job posts";

  static String m9(count) => "${count} resume views";

  static String m10(days) => "Listing visible for ${days} days";

  static String m11(price) => "Subscribe now (${price}\\\$)";

  static String m12(days) => "posted at: ${days} days ago";

  static String m13(tab) => "${tab} tab coming soon";

  final messages = notInlinedMessages(notInlinedMessages);
  static Map<String, Function> notInlinedMessages(_) => <String, Function>{
    "actionCreateResume": MessageLookupByLibrary.simpleMessage(
      "Create your resume",
    ),
    "actionPostJob": MessageLookupByLibrary.simpleMessage(
      "Post a job for free",
    ),
    "actionSeeMore": MessageLookupByLibrary.simpleMessage("See more"),
    "appLoading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "appTitle": MessageLookupByLibrary.simpleMessage("Mhnty"),
    "applyNow": MessageLookupByLibrary.simpleMessage("Apply Now"),
    "authErrorEmailInUse": MessageLookupByLibrary.simpleMessage(
      "The account already exists for that email",
    ),
    "authErrorUserNotFound": MessageLookupByLibrary.simpleMessage(
      "No user found for that email",
    ),
    "authErrorWeakPassword": MessageLookupByLibrary.simpleMessage(
      "The password provided is too weak",
    ),
    "authErrorWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Wrong password provided for that user",
    ),
    "bannerDreamBadge": MessageLookupByLibrary.simpleMessage("Apply now"),
    "bannerDreamSubtitle": MessageLookupByLibrary.simpleMessage(
      "Explore curated openings tailored to your skills.",
    ),
    "bannerDreamTitle": MessageLookupByLibrary.simpleMessage("Your Dream Job"),
    "bannerRemoteBadge": MessageLookupByLibrary.simpleMessage("See all roles"),
    "bannerRemoteSubtitle": MessageLookupByLibrary.simpleMessage(
      "Discover remote roles across multiple industries.",
    ),
    "bannerRemoteTitle": MessageLookupByLibrary.simpleMessage(
      "Remote Friendly",
    ),
    "bannerTopCompaniesBadge": MessageLookupByLibrary.simpleMessage(
      "View companies",
    ),
    "bannerTopCompaniesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Connect with leading teams hiring this week.",
    ),
    "bannerTopCompaniesTitle": MessageLookupByLibrary.simpleMessage(
      "Top Companies",
    ),
    "categoryAdministration": MessageLookupByLibrary.simpleMessage(
      "Administration & Secretary",
    ),
    "categoryCustomerSupport": MessageLookupByLibrary.simpleMessage(
      "Customer Support",
    ),
    "categoryDesigner": MessageLookupByLibrary.simpleMessage("Designer"),
    "categoryEngineering": MessageLookupByLibrary.simpleMessage("Engineering"),
    "categoryInternationalOrganizations": MessageLookupByLibrary.simpleMessage(
      "International Organizations",
    ),
    "categoryMarketing": MessageLookupByLibrary.simpleMessage("Marketing"),
    "categoryProgramming": MessageLookupByLibrary.simpleMessage("Programming"),
    "categorySales": MessageLookupByLibrary.simpleMessage("Sales"),
    "commonCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "commonOk": MessageLookupByLibrary.simpleMessage("OK"),
    "companyInfoSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Company Information",
    ),
    "companyInfoTab": MessageLookupByLibrary.simpleMessage("Company Info"),
    "cvAddSkill": MessageLookupByLibrary.simpleMessage("Add skill"),
    "cvButtonAdd": MessageLookupByLibrary.simpleMessage("Add"),
    "cvButtonFinish": MessageLookupByLibrary.simpleMessage("Finish"),
    "cvButtonPrevious": MessageLookupByLibrary.simpleMessage("Previous"),
    "cvButtonSaveContinue": MessageLookupByLibrary.simpleMessage(
      "Save & continue",
    ),
    "cvButtonStart": MessageLookupByLibrary.simpleMessage("Create your CV"),
    "cvCourseDate": MessageLookupByLibrary.simpleMessage("Course date"),
    "cvCourseOrganization": MessageLookupByLibrary.simpleMessage(
      "Course organizer",
    ),
    "cvCourseTitle": MessageLookupByLibrary.simpleMessage("Course title"),
    "cvCreateCta": MessageLookupByLibrary.simpleMessage(
      "Start building your CV",
    ),
    "cvCreateTitle": MessageLookupByLibrary.simpleMessage("Build your CV"),
    "cvDownloadButton": MessageLookupByLibrary.simpleMessage("Download"),
    "cvDownloadComingSoon": MessageLookupByLibrary.simpleMessage("Coming soon"),
    "cvDownloadCta": MessageLookupByLibrary.simpleMessage("Download my CV"),
    "cvDownloadFree": MessageLookupByLibrary.simpleMessage("Free CV"),
    "cvDownloadFreeDesc": MessageLookupByLibrary.simpleMessage(
      "Standard PDF export.",
    ),
    "cvDownloadFreePrice": MessageLookupByLibrary.simpleMessage("\$0"),
    "cvDownloadGold": MessageLookupByLibrary.simpleMessage("Gold"),
    "cvDownloadGoldDesc": MessageLookupByLibrary.simpleMessage(
      "Premium template with advanced styling.",
    ),
    "cvDownloadGoldPrice": MessageLookupByLibrary.simpleMessage("\$10"),
    "cvDownloadPremium": MessageLookupByLibrary.simpleMessage("Premium"),
    "cvDownloadPremiumDesc": MessageLookupByLibrary.simpleMessage(
      "Enhanced formatting and layout.",
    ),
    "cvDownloadPremiumPrice": MessageLookupByLibrary.simpleMessage("\$5"),
    "cvDownloadSubtitle": MessageLookupByLibrary.simpleMessage(
      "Choose how you’d like to export your CV.",
    ),
    "cvDownloadTitle": MessageLookupByLibrary.simpleMessage("Download my CV"),
    "cvDownloadToast": MessageLookupByLibrary.simpleMessage(
      "Download options will be available soon.",
    ),
    "cvEditButton": MessageLookupByLibrary.simpleMessage("Edit my CV"),
    "cvEducationEndDate": MessageLookupByLibrary.simpleMessage("End date"),
    "cvEducationInstitution": MessageLookupByLibrary.simpleMessage(
      "Educational institution",
    ),
    "cvEducationMajorAr": MessageLookupByLibrary.simpleMessage(
      "Major in Arabic",
    ),
    "cvEducationMajorEn": MessageLookupByLibrary.simpleMessage(
      "Major in English",
    ),
    "cvEducationStartDate": MessageLookupByLibrary.simpleMessage("Start date"),
    "cvEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "You have not created your CV yet.",
    ),
    "cvExperienceCompanyAr": MessageLookupByLibrary.simpleMessage(
      "Company name (Arabic)",
    ),
    "cvExperienceCompanyEn": MessageLookupByLibrary.simpleMessage(
      "Company name (English)",
    ),
    "cvExperienceDescription": MessageLookupByLibrary.simpleMessage(
      "Description",
    ),
    "cvExperienceEndDate": MessageLookupByLibrary.simpleMessage("End date"),
    "cvExperienceRoleAr": MessageLookupByLibrary.simpleMessage(
      "Job title (Arabic)",
    ),
    "cvExperienceRoleEn": MessageLookupByLibrary.simpleMessage(
      "Job title (English)",
    ),
    "cvExperienceStartDate": MessageLookupByLibrary.simpleMessage("Start date"),
    "cvFieldEducationLevel": MessageLookupByLibrary.simpleMessage(
      "Education level",
    ),
    "cvFieldEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "cvFieldJobTitleAr": MessageLookupByLibrary.simpleMessage(
      "Job title (Arabic)",
    ),
    "cvFieldJobTitleEn": MessageLookupByLibrary.simpleMessage(
      "Job title (English)",
    ),
    "cvFieldPhone1": MessageLookupByLibrary.simpleMessage("Phone number (1)"),
    "cvFieldPhone2": MessageLookupByLibrary.simpleMessage("Phone number (2)"),
    "cvFieldPhone3": MessageLookupByLibrary.simpleMessage("Phone number (3)"),
    "cvFieldSkillPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Type a skill then press add",
    ),
    "cvFieldSummaryAr": MessageLookupByLibrary.simpleMessage(
      "Objective in Arabic",
    ),
    "cvFieldSummaryEn": MessageLookupByLibrary.simpleMessage(
      "Objective in English",
    ),
    "cvFieldYearsExperience": MessageLookupByLibrary.simpleMessage(
      "Years of experience",
    ),
    "cvNoData": MessageLookupByLibrary.simpleMessage("No data"),
    "cvSectionContact": MessageLookupByLibrary.simpleMessage(
      "Contact information",
    ),
    "cvSectionContactEmail": MessageLookupByLibrary.simpleMessage(
      "Email address",
    ),
    "cvSectionContactPhones": MessageLookupByLibrary.simpleMessage(
      "Phone numbers",
    ),
    "cvSectionCourses": MessageLookupByLibrary.simpleMessage(
      "Training courses",
    ),
    "cvSectionEducation": MessageLookupByLibrary.simpleMessage("Education"),
    "cvSectionExperience": MessageLookupByLibrary.simpleMessage(
      "Work experience",
    ),
    "cvSectionMainInfo": MessageLookupByLibrary.simpleMessage(
      "Main information",
    ),
    "cvSectionSkills": MessageLookupByLibrary.simpleMessage("Personal skills"),
    "cvSectionSummary": MessageLookupByLibrary.simpleMessage("About me"),
    "cvSkillsEmpty": MessageLookupByLibrary.simpleMessage(
      "No skills added yet.",
    ),
    "cvStepContact": MessageLookupByLibrary.simpleMessage(
      "Contact information",
    ),
    "cvStepCourses": MessageLookupByLibrary.simpleMessage("Training courses"),
    "cvStepEducation": MessageLookupByLibrary.simpleMessage("Education"),
    "cvStepExperience": MessageLookupByLibrary.simpleMessage("Work experience"),
    "cvStepPersonalInfo": MessageLookupByLibrary.simpleMessage(
      "Personal information",
    ),
    "cvStepSkills": MessageLookupByLibrary.simpleMessage("Personal skills"),
    "cvStepSummary": MessageLookupByLibrary.simpleMessage("About me"),
    "cvSummaryEmpty": MessageLookupByLibrary.simpleMessage(
      "No summary provided.",
    ),
    "deleteAccountMessage": MessageLookupByLibrary.simpleMessage(
      "This will permanently remove your account and data. Continue?",
    ),
    "deleteAccountReauth": MessageLookupByLibrary.simpleMessage(
      "Please log in again before deleting your account.",
    ),
    "deleteAccountSuccess": MessageLookupByLibrary.simpleMessage(
      "Your account has been deleted.",
    ),
    "deleteAccountTitle": MessageLookupByLibrary.simpleMessage(
      "Delete account?",
    ),
    "dialogErrorTitle": MessageLookupByLibrary.simpleMessage("Error"),
    "editProfileCv": MessageLookupByLibrary.simpleMessage("CV link"),
    "editProfileEmail": MessageLookupByLibrary.simpleMessage("Email address"),
    "editProfileFullName": MessageLookupByLibrary.simpleMessage("Full name"),
    "editProfilePhone": MessageLookupByLibrary.simpleMessage("Phone number"),
    "editProfileSave": MessageLookupByLibrary.simpleMessage("Save"),
    "editProfileSuccessMessage": MessageLookupByLibrary.simpleMessage(
      "Your profile information has been updated.",
    ),
    "editProfileSuccessTitle": MessageLookupByLibrary.simpleMessage(
      "Changes saved",
    ),
    "editProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Personal information",
    ),
    "editProfileUpload": MessageLookupByLibrary.simpleMessage("Upload CV"),
    "employerAccountAboutArabic": MessageLookupByLibrary.simpleMessage(
      "Company bio (Arabic)",
    ),
    "employerAccountAboutEnglish": MessageLookupByLibrary.simpleMessage(
      "Company bio (English)",
    ),
    "employerAccountDefaultCompanyName": MessageLookupByLibrary.simpleMessage(
      "Company Account",
    ),
    "employerAccountFieldCompanyName": MessageLookupByLibrary.simpleMessage(
      "Company name",
    ),
    "employerAccountFieldEmail": MessageLookupByLibrary.simpleMessage(
      "Company email",
    ),
    "employerAccountFieldIndustry": MessageLookupByLibrary.simpleMessage(
      "Industry",
    ),
    "employerAccountFieldPhone1": MessageLookupByLibrary.simpleMessage(
      "Company phone 1",
    ),
    "employerAccountFieldPhone2": MessageLookupByLibrary.simpleMessage(
      "Company phone 2",
    ),
    "employerAccountFieldWebsite": MessageLookupByLibrary.simpleMessage(
      "Company website",
    ),
    "employerAccountIndustryPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Select your company industry",
    ),
    "employerAccountLoadError": m0,
    "employerAccountLoginRequired": MessageLookupByLibrary.simpleMessage(
      "Please sign in as an employer to view this page.",
    ),
    "employerAccountSectionContactTitle": MessageLookupByLibrary.simpleMessage(
      "Contact details",
    ),
    "employerAccountSectionInfoTitle": MessageLookupByLibrary.simpleMessage(
      "Company information",
    ),
    "employerAccountTabAbout": MessageLookupByLibrary.simpleMessage(
      "Company bio",
    ),
    "employerAccountTabInfo": MessageLookupByLibrary.simpleMessage(
      "Account info",
    ),
    "employerAccountTitle": MessageLookupByLibrary.simpleMessage("Account"),
    "employerDashboardLatestResumes": MessageLookupByLibrary.simpleMessage(
      "Latest resumes",
    ),
    "employerDashboardNoData": MessageLookupByLibrary.simpleMessage("No data"),
    "employerDashboardSeeMore": MessageLookupByLibrary.simpleMessage(
      "See more",
    ),
    "employerEditAboutFailure": m1,
    "employerEditAboutHeader": MessageLookupByLibrary.simpleMessage(
      "Company bio",
    ),
    "employerEditAboutLabelArabic": MessageLookupByLibrary.simpleMessage(
      "Company bio (Arabic)",
    ),
    "employerEditAboutLabelEnglish": MessageLookupByLibrary.simpleMessage(
      "Company bio (English)",
    ),
    "employerEditAboutSaveButton": MessageLookupByLibrary.simpleMessage("Save"),
    "employerEditAboutSuccess": MessageLookupByLibrary.simpleMessage(
      "Company bio updated successfully.",
    ),
    "employerEditAboutValidationRequired": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "employerEditInfoAddressBenghazi": MessageLookupByLibrary.simpleMessage(
      "Benghazi",
    ),
    "employerEditInfoAddressDerna": MessageLookupByLibrary.simpleMessage(
      "Derna",
    ),
    "employerEditInfoAddressGharyan": MessageLookupByLibrary.simpleMessage(
      "Gharyan",
    ),
    "employerEditInfoAddressMisrata": MessageLookupByLibrary.simpleMessage(
      "Misrata",
    ),
    "employerEditInfoAddressSabha": MessageLookupByLibrary.simpleMessage(
      "Sabha",
    ),
    "employerEditInfoAddressTripoli": MessageLookupByLibrary.simpleMessage(
      "Tripoli",
    ),
    "employerEditInfoFailure": m2,
    "employerEditInfoHeader": MessageLookupByLibrary.simpleMessage(
      "Company information",
    ),
    "employerEditInfoLabelAddress": MessageLookupByLibrary.simpleMessage(
      "Address",
    ),
    "employerEditInfoLabelAdvertiserRole": MessageLookupByLibrary.simpleMessage(
      "Advertiser role",
    ),
    "employerEditInfoLabelCompanyName": MessageLookupByLibrary.simpleMessage(
      "Company name (Arabic)",
    ),
    "employerEditInfoLabelEmail": MessageLookupByLibrary.simpleMessage(
      "Email address",
    ),
    "employerEditInfoLabelIndustry": MessageLookupByLibrary.simpleMessage(
      "Industry (Arabic)",
    ),
    "employerEditInfoLabelPhonePrimary": MessageLookupByLibrary.simpleMessage(
      "Primary phone",
    ),
    "employerEditInfoLabelPhoneSecondary": MessageLookupByLibrary.simpleMessage(
      "Secondary phone (optional)",
    ),
    "employerEditInfoLabelWebsite": MessageLookupByLibrary.simpleMessage(
      "Company website",
    ),
    "employerEditInfoPhoneHint": MessageLookupByLibrary.simpleMessage(
      "945236782",
    ),
    "employerEditInfoRoleAgency": MessageLookupByLibrary.simpleMessage(
      "Recruitment agency",
    ),
    "employerEditInfoRoleHR": MessageLookupByLibrary.simpleMessage(
      "HR representative",
    ),
    "employerEditInfoRoleOwner": MessageLookupByLibrary.simpleMessage(
      "Business owner",
    ),
    "employerEditInfoSaveButton": MessageLookupByLibrary.simpleMessage("Save"),
    "employerEditInfoSectionPhones": MessageLookupByLibrary.simpleMessage(
      "Contact details",
    ),
    "employerEditInfoSelectAddressTitle": MessageLookupByLibrary.simpleMessage(
      "Select city",
    ),
    "employerEditInfoSelectRoleTitle": MessageLookupByLibrary.simpleMessage(
      "Select advertiser role",
    ),
    "employerEditInfoSuccess": MessageLookupByLibrary.simpleMessage(
      "Company information saved successfully.",
    ),
    "employerEditInfoValidationRequired": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "employerJobsActionLabel": MessageLookupByLibrary.simpleMessage("Active"),
    "employerJobsDefaultTitle": MessageLookupByLibrary.simpleMessage("Job"),
    "employerJobsEducationLabel": m3,
    "employerJobsEmpty": MessageLookupByLibrary.simpleMessage("No jobs found."),
    "employerJobsExperienceLabel": m4,
    "employerJobsLoadError": m5,
    "employerJobsLoginPrompt": MessageLookupByLibrary.simpleMessage(
      "Please sign in to view your jobs.",
    ),
    "employerJobsSearchHint": MessageLookupByLibrary.simpleMessage(
      "Search jobs",
    ),
    "employerJobsStatusActive": MessageLookupByLibrary.simpleMessage("Active"),
    "employerJobsStatusArchived": MessageLookupByLibrary.simpleMessage(
      "Archived",
    ),
    "employerJobsStatusDeleted": MessageLookupByLibrary.simpleMessage(
      "Deleted",
    ),
    "employerNavAccount": MessageLookupByLibrary.simpleMessage("Account"),
    "employerNavHome": MessageLookupByLibrary.simpleMessage("Home"),
    "employerNavJobs": MessageLookupByLibrary.simpleMessage("Jobs"),
    "employerNavResumes": MessageLookupByLibrary.simpleMessage("Resumes"),
    "employerPlanBenefitEdits": m6,
    "employerPlanBenefitEditsUnlimited": MessageLookupByLibrary.simpleMessage(
      "Unlimited ad edits",
    ),
    "employerPlanBenefitFeaturedAds": m7,
    "employerPlanBenefitJobPosts": m8,
    "employerPlanBenefitResumeViews": m9,
    "employerPlanBenefitVisibilityDays": m10,
    "employerPlanLabelMonth": MessageLookupByLibrary.simpleMessage(
      "Duration 1 month",
    ),
    "employerPlanLabelSixMonths": MessageLookupByLibrary.simpleMessage(
      "Duration 6 months",
    ),
    "employerPlanLabelThreeMonths": MessageLookupByLibrary.simpleMessage(
      "Duration 3 months",
    ),
    "employerPlanLabelWeek": MessageLookupByLibrary.simpleMessage(
      "Duration 1 week",
    ),
    "employerPlanLabelYear": MessageLookupByLibrary.simpleMessage(
      "Duration 1 year",
    ),
    "employerPostJobCta": MessageLookupByLibrary.simpleMessage(
      "Post your job for free",
    ),
    "employerPremiumChooseDuration": MessageLookupByLibrary.simpleMessage(
      "Choose subscription duration",
    ),
    "employerPremiumHeaderLabel": MessageLookupByLibrary.simpleMessage(
      "Premium",
    ),
    "employerPremiumOverviewBody": MessageLookupByLibrary.simpleMessage(
      "Flexible posting plans tailored to your hiring needs\nImproved visibility through featured ads\nCost-effective hiring with scalable options.",
    ),
    "employerPremiumOverviewTitle": MessageLookupByLibrary.simpleMessage(
      "Work",
    ),
    "employerPremiumPopularBadge": MessageLookupByLibrary.simpleMessage(
      "Most popular 🔥",
    ),
    "employerPremiumSubscribeNow": m11,
    "employerResumesCatAdmin": MessageLookupByLibrary.simpleMessage(
      "Administration",
    ),
    "employerResumesCatAll": MessageLookupByLibrary.simpleMessage(
      "All categories",
    ),
    "employerResumesCatEngineering": MessageLookupByLibrary.simpleMessage(
      "Engineering",
    ),
    "employerResumesCatMarketing": MessageLookupByLibrary.simpleMessage(
      "Marketing",
    ),
    "employerResumesCatTech": MessageLookupByLibrary.simpleMessage("Tech"),
    "employerResumesCategoryLabel": MessageLookupByLibrary.simpleMessage(
      "Category",
    ),
    "employerResumesSearchHint": MessageLookupByLibrary.simpleMessage(
      "Search resumes...",
    ),
    "employerResumesSubtitle": MessageLookupByLibrary.simpleMessage(
      "Filter resumes by time and specialty to pick the best fit.",
    ),
    "employerResumesTime24h": MessageLookupByLibrary.simpleMessage("Last 24h"),
    "employerResumesTime30d": MessageLookupByLibrary.simpleMessage(
      "Last 30 days",
    ),
    "employerResumesTime7d": MessageLookupByLibrary.simpleMessage(
      "Last 7 days",
    ),
    "employerResumesTimeAny": MessageLookupByLibrary.simpleMessage("Anytime"),
    "employerResumesTimeLabel": MessageLookupByLibrary.simpleMessage("Time"),
    "employerResumesTitle": MessageLookupByLibrary.simpleMessage("Explore CVs"),
    "fieldRequired": MessageLookupByLibrary.simpleMessage("Required"),
    "filterAllCategories": MessageLookupByLibrary.simpleMessage(
      "All categories",
    ),
    "filterAnyTime": MessageLookupByLibrary.simpleMessage("Any time"),
    "filterCategory": MessageLookupByLibrary.simpleMessage("Category"),
    "filterChooseCountry": MessageLookupByLibrary.simpleMessage(
      "Choose country",
    ),
    "filterLast24h": MessageLookupByLibrary.simpleMessage("Last 24 hours"),
    "filterLast30d": MessageLookupByLibrary.simpleMessage("Past month"),
    "filterLast7d": MessageLookupByLibrary.simpleMessage("Past week"),
    "jobCompanyConfidential": MessageLookupByLibrary.simpleMessage(
      "Confidential",
    ),
    "jobCompanySummaryDefault": MessageLookupByLibrary.simpleMessage(
      "We invest in continuous learning, transparent leadership, and an inclusive culture so every team member can grow.",
    ),
    "jobDeptAdministration": MessageLookupByLibrary.simpleMessage(
      "Administration",
    ),
    "jobDeptFinance": MessageLookupByLibrary.simpleMessage("Finance"),
    "jobDeptQuality": MessageLookupByLibrary.simpleMessage("Quality"),
    "jobDescriptionDefault": MessageLookupByLibrary.simpleMessage(
      "Present your profile with confidence. Review the requirements, highlight your key achievements, and submit an application tailored to the hiring manager.",
    ),
    "jobDescriptionTitle": MessageLookupByLibrary.simpleMessage(
      "Job Description",
    ),
    "jobDetailCity": MessageLookupByLibrary.simpleMessage("City"),
    "jobDetailCompanyNameLabel": MessageLookupByLibrary.simpleMessage(
      "Company name",
    ),
    "jobDetailCompanySummary": MessageLookupByLibrary.simpleMessage(
      "Company Summary",
    ),
    "jobDetailDeadline": MessageLookupByLibrary.simpleMessage("Apply Before"),
    "jobDetailDepartment": MessageLookupByLibrary.simpleMessage("Department"),
    "jobDetailEducationLevel": MessageLookupByLibrary.simpleMessage(
      "Education Level",
    ),
    "jobDetailExperienceLabel": MessageLookupByLibrary.simpleMessage(
      "Experience",
    ),
    "jobDetailExperienceYears": MessageLookupByLibrary.simpleMessage(
      "Years of Experience",
    ),
    "jobDetailJobTitle": MessageLookupByLibrary.simpleMessage("Job Title"),
    "jobDetailLocationLabel": MessageLookupByLibrary.simpleMessage("Location"),
    "jobDetailNationality": MessageLookupByLibrary.simpleMessage("Nationality"),
    "jobDetailSalaryLabel": MessageLookupByLibrary.simpleMessage("Salary"),
    "jobDetailWorkLocation": MessageLookupByLibrary.simpleMessage(
      "Work Location",
    ),
    "jobFeaturedBadge": MessageLookupByLibrary.simpleMessage("Featured post"),
    "jobInfoSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Job Information",
    ),
    "jobInfoTab": MessageLookupByLibrary.simpleMessage("Job Info"),
    "jobLocationJordan": MessageLookupByLibrary.simpleMessage("Tripoli"),
    "jobLocationSaudi": MessageLookupByLibrary.simpleMessage("Benghazi"),
    "jobPostedAt": m12,
    "jobTitleAdminOfficer": MessageLookupByLibrary.simpleMessage(
      "Admin Officer",
    ),
    "jobTitleFinanceSpecialist": MessageLookupByLibrary.simpleMessage(
      "Finance Specialist",
    ),
    "jobTitleInternalAuditor": MessageLookupByLibrary.simpleMessage(
      "Internal Auditor",
    ),
    "jobTitleQualitySupervisor": MessageLookupByLibrary.simpleMessage(
      "Quality Supervisor",
    ),
    "languageArabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "loginButton": MessageLookupByLibrary.simpleMessage("Login"),
    "loginEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "loginEmailHint": MessageLookupByLibrary.simpleMessage(
      "Enter your email...",
    ),
    "loginEmailRequired": MessageLookupByLibrary.simpleMessage("Required"),
    "loginNoAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "loginPassword": MessageLookupByLibrary.simpleMessage("Password"),
    "loginPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Enter your password...",
    ),
    "loginPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Password is required",
    ),
    "loginPasswordTooShort": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 6 characters",
    ),
    "loginRegister": MessageLookupByLibrary.simpleMessage("Register"),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Welcome Back!"),
    "logoutSuccess": MessageLookupByLibrary.simpleMessage(
      "You have been logged out",
    ),
    "menuAbout": MessageLookupByLibrary.simpleMessage("About Us"),
    "menuContact": MessageLookupByLibrary.simpleMessage("Contact Us"),
    "menuDeleteAccount": MessageLookupByLibrary.simpleMessage("Delete Account"),
    "menuLogin": MessageLookupByLibrary.simpleMessage("Login"),
    "menuLogout": MessageLookupByLibrary.simpleMessage("Logout"),
    "menuMembershipStatusFree": MessageLookupByLibrary.simpleMessage("Free"),
    "menuMembershipTitle": MessageLookupByLibrary.simpleMessage(
      "Your current membership",
    ),
    "menuPrivacy": MessageLookupByLibrary.simpleMessage(
      "Privacy Policy and Terms of Use",
    ),
    "menuServicesAds": MessageLookupByLibrary.simpleMessage("Services Ads"),
    "navHome": MessageLookupByLibrary.simpleMessage("Home"),
    "navJobs": MessageLookupByLibrary.simpleMessage("Jobs"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Profile"),
    "navSaved": MessageLookupByLibrary.simpleMessage("Saved"),
    "offerBoostedBadge": MessageLookupByLibrary.simpleMessage("Premium"),
    "offerBoostedSubtitle": MessageLookupByLibrary.simpleMessage(
      "Appear at the top of every search for 7 days.",
    ),
    "offerBoostedTitle": MessageLookupByLibrary.simpleMessage(
      "Boosted Listing",
    ),
    "offerSpotlightBadge": MessageLookupByLibrary.simpleMessage("Popular"),
    "offerSpotlightSubtitle": MessageLookupByLibrary.simpleMessage(
      "Showcase your profile to companies looking now.",
    ),
    "offerSpotlightTitle": MessageLookupByLibrary.simpleMessage(
      "Talent Spotlight",
    ),
    "offerUrgentBadge": MessageLookupByLibrary.simpleMessage("Sponsored"),
    "offerUrgentSubtitle": MessageLookupByLibrary.simpleMessage(
      "Highlight your role with an urgent badge and alert.",
    ),
    "offerUrgentTitle": MessageLookupByLibrary.simpleMessage("Urgent Hire"),
    "placeholderTab": m13,
    "profileAddress": MessageLookupByLibrary.simpleMessage("Address"),
    "profileCity": MessageLookupByLibrary.simpleMessage("City / Region"),
    "profileEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "profileNameArabic": MessageLookupByLibrary.simpleMessage("Name (Arabic)"),
    "profileNameEnglish": MessageLookupByLibrary.simpleMessage(
      "Name (English)",
    ),
    "profileNameLabel": MessageLookupByLibrary.simpleMessage("Full Name"),
    "profileNationality": MessageLookupByLibrary.simpleMessage("Nationality"),
    "profileNoData": MessageLookupByLibrary.simpleMessage(
      "We couldn’t find your profile data yet. Please complete registration.",
    ),
    "profilePersonalTab": MessageLookupByLibrary.simpleMessage("Personal Info"),
    "profilePhone": MessageLookupByLibrary.simpleMessage("Phone Number"),
    "profileResumePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Your CV will appear here when uploaded.",
    ),
    "profileResumeTab": MessageLookupByLibrary.simpleMessage("My Resume"),
    "profileResumeTitle": MessageLookupByLibrary.simpleMessage("Resume"),
    "registerButton": MessageLookupByLibrary.simpleMessage("Register"),
    "registerConfirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Re-enter password...",
    ),
    "registerConfirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "registerEmailHint": MessageLookupByLibrary.simpleMessage(
      "example@gmail.com",
    ),
    "registerEmailLabel": MessageLookupByLibrary.simpleMessage("Email"),
    "registerEmployerNameHint": MessageLookupByLibrary.simpleMessage(
      "Company, organization, restaurant name...",
    ),
    "registerEmployerNameLabel": MessageLookupByLibrary.simpleMessage(
      "Employer name",
    ),
    "registerFirstNameHint": MessageLookupByLibrary.simpleMessage(
      "Enter first name...",
    ),
    "registerFirstNameLabel": MessageLookupByLibrary.simpleMessage(
      "First Name",
    ),
    "registerHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "registerLastNameHint": MessageLookupByLibrary.simpleMessage(
      "Enter last name...",
    ),
    "registerLastNameLabel": MessageLookupByLibrary.simpleMessage("Last Name"),
    "registerLoginLink": MessageLookupByLibrary.simpleMessage("Login"),
    "registerPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Enter password...",
    ),
    "registerPasswordLabel": MessageLookupByLibrary.simpleMessage("Password"),
    "registerPasswordMismatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "registerPasswordTooShort": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 6 characters",
    ),
    "registerPhoneHint": MessageLookupByLibrary.simpleMessage(
      "Enter phone number...",
    ),
    "registerPhoneLabel": MessageLookupByLibrary.simpleMessage("Phone Number"),
    "registerSuccessDesc": MessageLookupByLibrary.simpleMessage(
      "You can now log in",
    ),
    "registerSuccessTitle": MessageLookupByLibrary.simpleMessage(
      "Account created",
    ),
    "registerTabEmployer": MessageLookupByLibrary.simpleMessage(
      "Register Employer",
    ),
    "registerTabJobSeeker": MessageLookupByLibrary.simpleMessage(
      "Register Job Seeker",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Create Account"),
    "savedEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "You haven’t saved any jobs yet.",
    ),
    "searchHint": MessageLookupByLibrary.simpleMessage("Looking for a job.."),
    "sectionFeaturedOffers": MessageLookupByLibrary.simpleMessage(
      "Featured Offers",
    ),
    "sectionJobCategories": MessageLookupByLibrary.simpleMessage(
      "Job Categories",
    ),
    "themeDarkModeLabel": MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "welcomeBrowseAsGuest": MessageLookupByLibrary.simpleMessage(
      "Or you can browse as a guest",
    ),
    "welcomeContinueGuest": MessageLookupByLibrary.simpleMessage(
      "Continue as Guest",
    ),
    "welcomeEmployer": MessageLookupByLibrary.simpleMessage("I am an Employer"),
    "welcomeHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Do you already have an account?",
    ),
    "welcomeJobSeeker": MessageLookupByLibrary.simpleMessage("I am job Seeker"),
    "welcomeLogin": MessageLookupByLibrary.simpleMessage("Login"),
    "welcomeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Your gateway to seamless work management.",
    ),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Welcome to Nuqta Wasl",
    ),
  };
}
