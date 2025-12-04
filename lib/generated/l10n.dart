import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

class S {
  S();

  static S? currentt;

  static S get current {
    assert(
      current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S.currentt = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get appTitle {
    return Intl.message('Mhnty', name: 'appTitle', desc: '', args: []);
  }

  String get searchHint {
    return Intl.message(
      'Looking for a job..',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  String get menuAbout {
    return Intl.message('About Us', name: 'menuAbout', desc: '', args: []);
  }

  String get menuServicesAds {
    return Intl.message(
      'Services Ads',
      name: 'menuServicesAds',
      desc: '',
      args: [],
    );
  }

  String get menuContact {
    return Intl.message('Contact Us', name: 'menuContact', desc: '', args: []);
  }

  String get menuPrivacy {
    return Intl.message(
      'Privacy Policy and Terms of Use',
      name: 'menuPrivacy',
      desc: '',
      args: [],
    );
  }

  String get menuLogin {
    return Intl.message('Login', name: 'menuLogin', desc: '', args: []);
  }

  String get menuLogout {
    return Intl.message('Logout', name: 'menuLogout', desc: '', args: []);
  }

  String get menuDeleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'menuDeleteAccount',
      desc: '',
      args: [],
    );
  }

  String get menuMembershipTitle {
    return Intl.message(
      'Your current membership',
      name: 'menuMembershipTitle',
      desc: '',
      args: [],
    );
  }

  String get menuMembershipStatusFree {
    return Intl.message(
      'Free',
      name: 'menuMembershipStatusFree',
      desc: '',
      args: [],
    );
  }

  String get actionCreateResume {
    return Intl.message(
      'Create your resume',
      name: 'actionCreateResume',
      desc: '',
      args: [],
    );
  }

  String get actionPostJob {
    return Intl.message(
      'Post a job for free',
      name: 'actionPostJob',
      desc: '',
      args: [],
    );
  }

  String get sectionJobCategories {
    return Intl.message(
      'Job Categories',
      name: 'sectionJobCategories',
      desc: '',
      args: [],
    );
  }

  String get actionSeeMore {
    return Intl.message('See more', name: 'actionSeeMore', desc: '', args: []);
  }

  String get sectionFeaturedOffers {
    return Intl.message(
      'Featured Offers',
      name: 'sectionFeaturedOffers',
      desc: '',
      args: [],
    );
  }

  String get bannerDreamTitle {
    return Intl.message(
      'Your Dream Job',
      name: 'bannerDreamTitle',
      desc: '',
      args: [],
    );
  }

  String get bannerDreamSubtitle {
    return Intl.message(
      'Explore curated openings tailored to your skills.',
      name: 'bannerDreamSubtitle',
      desc: '',
      args: [],
    );
  }

 
  String get bannerDreamBadge {
    return Intl.message(
      'Apply now',
      name: 'bannerDreamBadge',
      desc: '',
      args: [],
    );
  }

  
  String get bannerTopCompaniesTitle {
    return Intl.message(
      'Top Companies',
      name: 'bannerTopCompaniesTitle',
      desc: '',
      args: [],
    );
  }

  String get bannerTopCompaniesSubtitle {
    return Intl.message(
      'Connect with leading teams hiring this week.',
      name: 'bannerTopCompaniesSubtitle',
      desc: '',
      args: [],
    );
  }

  
  String get bannerTopCompaniesBadge {
    return Intl.message(
      'View companies',
      name: 'bannerTopCompaniesBadge',
      desc: '',
      args: [],
    );
  }

  
  String get bannerRemoteTitle {
    return Intl.message(
      'Remote Friendly',
      name: 'bannerRemoteTitle',
      desc: '',
      args: [],
    );
  }

  String get bannerRemoteSubtitle {
    return Intl.message(
      'Discover remote roles across multiple industries.',
      name: 'bannerRemoteSubtitle',
      desc: '',
      args: [],
    );
  }

  String get bannerRemoteBadge {
    return Intl.message(
      'See all roles',
      name: 'bannerRemoteBadge',
      desc: '',
      args: [],
    );
  }
  String get employerResumesTitle {
    return Intl.message(
      'Explore CVs',
      name: 'employerResumesTitle',
      desc: '',
      args: [],
    );
  }

  String get employerResumesSubtitle {
    return Intl.message(
      'Filter resumes by time and specialty to pick the best fit.',
      name: 'employerResumesSubtitle',
      desc: '',
      args: [],
    );
  }

  String get employerResumesTimeLabel {
    return Intl.message(
      'Time',
      name: 'employerResumesTimeLabel',
      desc: '',
      args: [],
    );
  }

  String get employerResumesCategoryLabel {
    return Intl.message(
      'Category',
      name: 'employerResumesCategoryLabel',
      desc: '',
      args: [],
    );
  }

  String get employerResumesTime24h {
    return Intl.message(
      'Last 24h',
      name: 'employerResumesTime24h',
      desc: '',
      args: [],
    );
  }

  String get employerResumesTime7d {
    return Intl.message(
      'Last 7 days',
      name: 'employerResumesTime7d',
      desc: '',
      args: [],
    );
  }

  String get employerResumesTime30d {
    return Intl.message(
      'Last 30 days',
      name: 'employerResumesTime30d',
      desc: '',
      args: [],
    );
  }

  String get employerResumesTimeAny {
    return Intl.message(
      'Anytime',
      name: 'employerResumesTimeAny',
      desc: '',
      args: [],
    );
  }

  String get employerResumesCatAll {
    return Intl.message(
      'All categories',
      name: 'employerResumesCatAll',
      desc: '',
      args: [],
    );
  }

  String get employerResumesCatTech {
    return Intl.message(
      'Tech',
      name: 'employerResumesCatTech',
      desc: '',
      args: [],
    );
  }

  String get employerResumesCatMarketing {
    return Intl.message(
      'Marketing',
      name: 'employerResumesCatMarketing',
      desc: '',
      args: [],
    );
  }

  String get employerResumesCatAdmin {
    return Intl.message(
      'Administration',
      name: 'employerResumesCatAdmin',
      desc: '',
      args: [],
    );
  }

  String get employerResumesCatEngineering {
    return Intl.message(
      'Engineering',
      name: 'employerResumesCatEngineering',
      desc: '',
      args: [],
    );
  }

  String get employerDashboardLatestResumes {
    return Intl.message(
      'Latest resumes',
      name: 'employerDashboardLatestResumes',
      desc: '',
      args: [],
    );
  }

  String get employerDashboardSeeMore {
    return Intl.message(
      'See more',
      name: 'employerDashboardSeeMore',
      desc: '',
      args: [],
    );
  }

  String get employerDashboardNoData {
    return Intl.message(
      'No data',
      name: 'employerDashboardNoData',
      desc: '',
      args: [],
    );
  }

  String get employerPostJobCta {
    return Intl.message(
      'Post your job for free',
      name: 'employerPostJobCta',
      desc: '',
      args: [],
    );
  }

  String get categoryInternationalOrganizations {
    return Intl.message(
      'International Organizations',
      name: 'categoryInternationalOrganizations',
      desc: '',
      args: [],
    );
  }

  String get categorySales {
    return Intl.message('Sales', name: 'categorySales', desc: '', args: []);
  }

  String get categoryAdministration {
    return Intl.message(
      'Administration & Secretary',
      name: 'categoryAdministration',
      desc: '',
      args: [],
    );
  }

  String get categoryEngineering {
    return Intl.message(
      'Engineering',
      name: 'categoryEngineering',
      desc: '',
      args: [],
    );
  }

  String get categoryDesigner {
    return Intl.message(
      'Designer',
      name: 'categoryDesigner',
      desc: '',
      args: [],
    );
  }

  String get categoryProgramming {
    return Intl.message(
      'Programming',
      name: 'categoryProgramming',
      desc: '',
      args: [],
    );
  }

  String get categoryMarketing {
    return Intl.message(
      'Marketing',
      name: 'categoryMarketing',
      desc: '',
      args: [],
    );
  }

  String get categoryCustomerSupport {
    return Intl.message(
      'Customer Support',
      name: 'categoryCustomerSupport',
      desc: '',
      args: [],
    );
  }

  String get jobDeptQuality {
    return Intl.message('Quality', name: 'jobDeptQuality', desc: '', args: []);
  }

  String get jobDeptAdministration {
    return Intl.message(
      'Administration',
      name: 'jobDeptAdministration',
      desc: '',
      args: [],
    );
  }

  String get jobDeptFinance {
    return Intl.message('Finance', name: 'jobDeptFinance', desc: '', args: []);
  }

  String get offerBoostedTitle {
    return Intl.message(
      'Boosted Listing',
      name: 'offerBoostedTitle',
      desc: '',
      args: [],
    );
  }

  String get offerBoostedSubtitle {
    return Intl.message(
      'Appear at the top of every search for 7 days.',
      name: 'offerBoostedSubtitle',
      desc: '',
      args: [],
    );
  }

  String get offerBoostedBadge {
    return Intl.message(
      'Premium',
      name: 'offerBoostedBadge',
      desc: '',
      args: [],
    );
  }

  String get offerUrgentTitle {
    return Intl.message(
      'Urgent Hire',
      name: 'offerUrgentTitle',
      desc: '',
      args: [],
    );
  }

  String get offerUrgentSubtitle {
    return Intl.message(
      'Highlight your role with an urgent badge and alert.',
      name: 'offerUrgentSubtitle',
      desc: '',
      args: [],
    );
  }

  String get offerUrgentBadge {
    return Intl.message(
      'Sponsored',
      name: 'offerUrgentBadge',
      desc: '',
      args: [],
    );
  }

  String get offerSpotlightTitle {
    return Intl.message(
      'Talent Spotlight',
      name: 'offerSpotlightTitle',
      desc: '',
      args: [],
    );
  }

  String get offerSpotlightSubtitle {
    return Intl.message(
      'Showcase your profile to companies looking now.',
      name: 'offerSpotlightSubtitle',
      desc: '',
      args: [],
    );
  }

  String get offerSpotlightBadge {
    return Intl.message(
      'Popular',
      name: 'offerSpotlightBadge',
      desc: '',
      args: [],
    );
  }

  String get filterAnyTime {
    return Intl.message('Any time', name: 'filterAnyTime', desc: '', args: []);
  }

  String get filterCategory {
    return Intl.message('Category', name: 'filterCategory', desc: '', args: []);
  }

  String get filterLast24h {
    return Intl.message(
      'Last 24 hours',
      name: 'filterLast24h',
      desc: '',
      args: [],
    );
  }

  String get filterLast7d {
    return Intl.message('Past week', name: 'filterLast7d', desc: '', args: []);
  }

  String get filterLast30d {
    return Intl.message(
      'Past month',
      name: 'filterLast30d',
      desc: '',
      args: [],
    );
  }

  String get filterAllCategories {
    return Intl.message(
      'All categories',
      name: 'filterAllCategories',
      desc: '',
      args: [],
    );
  }
  String get filterChooseCountry {
    return Intl.message(
      'Choose country',
      name: 'filterChooseCountry',
      desc: '',
      args: [],
    );
  }

  String get jobCompanyConfidential {
    return Intl.message(
      'Confidential',
      name: 'jobCompanyConfidential',
      desc: '',
      args: [],
    );
  }

  String get jobLocationJordan {
    return Intl.message(
      'Tripoli',
      name: 'jobLocationJordan',
      desc: '',
      args: [],
    );
  }

  String get jobLocationSaudi {
    return Intl.message(
      'Benghazi',
      name: 'jobLocationSaudi',
      desc: '',
      args: [],
    );
  }
  String get jobFeaturedBadge {
    return Intl.message(
      'Featured post',
      name: 'jobFeaturedBadge',
      desc: '',
      args: [],
    );
  }

  String get jobTitleQualitySupervisor {
    return Intl.message(
      'Quality Supervisor',
      name: 'jobTitleQualitySupervisor',
      desc: '',
      args: [],
    );
  }

  String get jobTitleAdminOfficer {
    return Intl.message(
      'Admin Officer',
      name: 'jobTitleAdminOfficer',
      desc: '',
      args: [],
    );
  }

  String get jobTitleInternalAuditor {
    return Intl.message(
      'Internal Auditor',
      name: 'jobTitleInternalAuditor',
      desc: '',
      args: [],
    );
  }

  String get jobTitleFinanceSpecialist {
    return Intl.message(
      'Finance Specialist',
      name: 'jobTitleFinanceSpecialist',
      desc: '',
      args: [],
    );
  }

  String get languageEnglish {
    return Intl.message('English', name: 'languageEnglish', desc: '', args: []);
  }

  String get languageArabic {
    return Intl.message('Arabic', name: 'languageArabic', desc: '', args: []);
  }

  String get appLoading {
    return Intl.message('Loading...', name: 'appLoading', desc: '', args: []);
  }

  String get welcomeTitle {
    return Intl.message(
      'Welcome to Nuqta Wasl',
      name: 'welcomeTitle',
      desc: '',
      args: [],
    );
  }

  String get welcomeSubtitle {
    return Intl.message(
      'Your gateway to seamless work management.',
      name: 'welcomeSubtitle',
      desc: '',
      args: [],
    );
  }

  String get welcomeJobSeeker {
    return Intl.message(
      'I am job Seeker',
      name: 'welcomeJobSeeker',
      desc: '',
      args: [],
    );
  }

  String get welcomeEmployer {
    return Intl.message(
      'I am an Employer',
      name: 'welcomeEmployer',
      desc: '',
      args: [],
    );
  }

  String get welcomeBrowseAsGuest {
    return Intl.message(
      'Or you can browse as a guest',
      name: 'welcomeBrowseAsGuest',
      desc: '',
      args: [],
    );
  }

  String get welcomeContinueGuest {
    return Intl.message(
      'Continue as Guest',
      name: 'welcomeContinueGuest',
      desc: '',
      args: [],
    );
  }

  String get welcomeHaveAccount {
    return Intl.message(
      'Do you already have an account?',
      name: 'welcomeHaveAccount',
      desc: '',
      args: [],
    );
  }

  String get welcomeLogin {
    return Intl.message('Login', name: 'welcomeLogin', desc: '', args: []);
  }

  String get loginTitle {
    return Intl.message(
      'Welcome Back!',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  String get loginEmail {
    return Intl.message('Email', name: 'loginEmail', desc: '', args: []);
  }

  String get loginEmailHint {
    return Intl.message(
      'Enter your email...',
      name: 'loginEmailHint',
      desc: '',
      args: [],
    );
  }

  String get loginEmailRequired {
    return Intl.message(
      'Required',
      name: 'loginEmailRequired',
      desc: '',
      args: [],
    );
  }

  String get loginPassword {
    return Intl.message('Password', name: 'loginPassword', desc: '', args: []);
  }

  String get loginPasswordHint {
    return Intl.message(
      'Enter your password...',
      name: 'loginPasswordHint',
      desc: '',
      args: [],
    );
  }

  String get loginPasswordRequired {
    return Intl.message(
      'Password is required',
      name: 'loginPasswordRequired',
      desc: '',
      args: [],
    );
  }

  String get loginPasswordTooShort {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'loginPasswordTooShort',
      desc: '',
      args: [],
    );
  }

  String get loginButton {
    return Intl.message('Login', name: 'loginButton', desc: '', args: []);
  }

  String get loginNoAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'loginNoAccount',
      desc: '',
      args: [],
    );
  }

  String get loginRegister {
    return Intl.message('Register', name: 'loginRegister', desc: '', args: []);
  }

  String get registerTitle {
    return Intl.message(
      'Create Account',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  String get registerTabEmployer {
    return Intl.message(
      'Register Employer',
      name: 'registerTabEmployer',
      desc: '',
      args: [],
    );
  }

  String get registerTabJobSeeker {
    return Intl.message(
      'Register Job Seeker',
      name: 'registerTabJobSeeker',
      desc: '',
      args: [],
    );
  }

  String get fieldRequired {
    return Intl.message('Required', name: 'fieldRequired', desc: '', args: []);
  }

  String get registerFirstNameLabel {
    return Intl.message(
      'First Name',
      name: 'registerFirstNameLabel',
      desc: '',
      args: [],
    );
  }

  String get registerFirstNameHint {
    return Intl.message(
      'Enter first name...',
      name: 'registerFirstNameHint',
      desc: '',
      args: [],
    );
  }

  String get registerLastNameLabel {
    return Intl.message(
      'Last Name',
      name: 'registerLastNameLabel',
      desc: '',
      args: [],
    );
  }

  String get registerLastNameHint {
    return Intl.message(
      'Enter last name...',
      name: 'registerLastNameHint',
      desc: '',
      args: [],
    );
  }

  String get registerPhoneLabel {
    return Intl.message(
      'Phone Number',
      name: 'registerPhoneLabel',
      desc: '',
      args: [],
    );
  }

  String get registerPhoneHint {
    return Intl.message(
      'Enter phone number...',
      name: 'registerPhoneHint',
      desc: '',
      args: [],
    );
  }

  String get registerEmailLabel {
    return Intl.message(
      'Email',
      name: 'registerEmailLabel',
      desc: '',
      args: [],
    );
  }

  String get registerEmailHint {
    return Intl.message(
      'example@gmail.com',
      name: 'registerEmailHint',
      desc: '',
      args: [],
    );
  }

 
  String get registerPasswordLabel {
    return Intl.message(
      'Password',
      name: 'registerPasswordLabel',
      desc: '',
      args: [],
    );
  }

 
  String get registerPasswordHint {
    return Intl.message(
      'Enter password...',
      name: 'registerPasswordHint',
      desc: '',
      args: [],
    );
  }

  String get registerPasswordTooShort {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'registerPasswordTooShort',
      desc: '',
      args: [],
    );
  }

  String get registerConfirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'registerConfirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  String get registerConfirmPasswordHint {
    return Intl.message(
      'Re-enter password...',
      name: 'registerConfirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  String get registerPasswordMismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'registerPasswordMismatch',
      desc: '',
      args: [],
    );
  }

  String get registerEmployerNameLabel {
    return Intl.message(
      'Employer name',
      name: 'registerEmployerNameLabel',
      desc: '',
      args: [],
    );
  }

  String get registerEmployerNameHint {
    return Intl.message(
      'Company, organization, restaurant name...',
      name: 'registerEmployerNameHint',
      desc: '',
      args: [],
    );
  }

  String get registerButton {
    return Intl.message('Register', name: 'registerButton', desc: '', args: []);
  }

  
  String get registerHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'registerHaveAccount',
      desc: '',
      args: [],
    );
  }

  String get registerLoginLink {
    return Intl.message('Login', name: 'registerLoginLink', desc: '', args: []);
  }

  String get authErrorWeakPassword {
    return Intl.message(
      'The password provided is too weak',
      name: 'authErrorWeakPassword',
      desc: '',
      args: [],
    );
  }

  String get authErrorEmailInUse {
    return Intl.message(
      'The account already exists for that email',
      name: 'authErrorEmailInUse',
      desc: '',
      args: [],
    );
  }

  String get jobInfoTab {
    return Intl.message('Job Info', name: 'jobInfoTab', desc: '', args: []);
  }

  String get companyInfoTab {
    return Intl.message(
      'Company Info',
      name: 'companyInfoTab',
      desc: '',
      args: [],
    );
  }

  String get applyNow {
    return Intl.message('Apply Now', name: 'applyNow', desc: '', args: []);
  }

  String get jobDetailSalaryLabel {
    return Intl.message(
      'Salary',
      name: 'jobDetailSalaryLabel',
      desc: '',
      args: [],
    );
  }

  String get jobDetailExperienceLabel {
    return Intl.message(
      'Experience',
      name: 'jobDetailExperienceLabel',
      desc: '',
      args: [],
    );
  }

  String get jobDetailLocationLabel {
    return Intl.message(
      'Location',
      name: 'jobDetailLocationLabel',
      desc: '',
      args: [],
    );
  }

  String get jobInfoSectionTitle {
    return Intl.message(
      'Job Information',
      name: 'jobInfoSectionTitle',
      desc: '',
      args: [],
    );
  }
  String get companyInfoSectionTitle {
    return Intl.message(
      'Company Information',
      name: 'companyInfoSectionTitle',
      desc: '',
      args: [],
    );
  }

  String get jobDescriptionTitle {
    return Intl.message(
      'Job Description',
      name: 'jobDescriptionTitle',
      desc: '',
      args: [],
    );
  }

  String get jobDetailJobTitle {
    return Intl.message(
      'Job Title',
      name: 'jobDetailJobTitle',
      desc: '',
      args: [],
    );
  }

  String get jobDetailExperienceYears {
    return Intl.message(
      'Years of Experience',
      name: 'jobDetailExperienceYears',
      desc: '',
      args: [],
    );
  }

  String get jobDetailEducationLevel {
    return Intl.message(
      'Education Level',
      name: 'jobDetailEducationLevel',
      desc: '',
      args: [],
    );
  }

  String get jobDetailDepartment {
    return Intl.message(
      'Department',
      name: 'jobDetailDepartment',
      desc: '',
      args: [],
    );
  }

  String get jobDetailNationality {
    return Intl.message(
      'Nationality',
      name: 'jobDetailNationality',
      desc: '',
      args: [],
    );
  }

  String get jobDetailWorkLocation {
    return Intl.message(
      'Work Location',
      name: 'jobDetailWorkLocation',
      desc: '',
      args: [],
    );
  }

  String get jobDetailCity {
    return Intl.message('City', name: 'jobDetailCity', desc: '', args: []);
  }

  String get jobDetailDeadline {
    return Intl.message(
      'Apply Before',
      name: 'jobDetailDeadline',
      desc: '',
      args: [],
    );
  }

  String get jobDetailCompanySummary {
    return Intl.message(
      'Company Summary',
      name: 'jobDetailCompanySummary',
      desc: '',
      args: [],
    );
  }

  String get jobDetailCompanyNameLabel {
    return Intl.message(
      'Company name',
      name: 'jobDetailCompanyNameLabel',
      desc: '',
      args: [],
    );
  }

  String get jobDescriptionDefault {
    return Intl.message(
      'Present your profile with confidence. Review the requirements, highlight your key achievements, and submit an application tailored to the hiring manager.',
      name: 'jobDescriptionDefault',
      desc: '',
      args: [],
    );
  }

  String get jobCompanySummaryDefault {
    return Intl.message(
      'We invest in continuous learning, transparent leadership, and an inclusive culture so every team member can grow.',
      name: 'jobCompanySummaryDefault',
      desc: '',
      args: [],
    );
  }

  String get savedEmptyMessage {
    return Intl.message(
      'You haven’t saved any jobs yet.',
      name: 'savedEmptyMessage',
      desc: '',
      args: [],
    );
  }

  String get profilePersonalTab {
    return Intl.message(
      'Personal Info',
      name: 'profilePersonalTab',
      desc: '',
      args: [],
    );
  }

  
  String get profileResumeTab {
    return Intl.message(
      'My Resume',
      name: 'profileResumeTab',
      desc: '',
      args: [],
    );
  }

  String get profileNameArabic {
    return Intl.message(
      'Name (Arabic)',
      name: 'profileNameArabic',
      desc: '',
      args: [],
    );
  }

  String get profileNameEnglish {
    return Intl.message(
      'Name (English)',
      name: 'profileNameEnglish',
      desc: '',
      args: [],
    );
  }

  String get profileAddress {
    return Intl.message('Address', name: 'profileAddress', desc: '', args: []);
  }
  String get profileNationality {
    return Intl.message(
      'Nationality',
      name: 'profileNationality',
      desc: '',
      args: [],
    );
  }

  String get profileCity {
    return Intl.message(
      'City / Region',
      name: 'profileCity',
      desc: '',
      args: [],
    );
  }

  String get profilePhone {
    return Intl.message(
      'Phone Number',
      name: 'profilePhone',
      desc: '',
      args: [],
    );
  }

  String get profileEmail {
    return Intl.message('Email', name: 'profileEmail', desc: '', args: []);
  }

  String get profileResumeTitle {
    return Intl.message(
      'Resume',
      name: 'profileResumeTitle',
      desc: '',
      args: [],
    );
  }

  String get editProfileTitle {
    return Intl.message(
      'Personal information',
      name: 'editProfileTitle',
      desc: '',
      args: [],
    );
  }

  String get editProfileFullName {
    return Intl.message(
      'Full name',
      name: 'editProfileFullName',
      desc: '',
      args: [],
    );
  }

  String get editProfilePhone {
    return Intl.message(
      'Phone number',
      name: 'editProfilePhone',
      desc: '',
      args: [],
    );
  }

  String get editProfileEmail {
    return Intl.message(
      'Email address',
      name: 'editProfileEmail',
      desc: '',
      args: [],
    );
  }

  String get editProfileCv {
    return Intl.message('CV link', name: 'editProfileCv', desc: '', args: []);
  }

  /// `Upload CV`
  String get editProfileUpload {
    return Intl.message(
      'Upload CV',
      name: 'editProfileUpload',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get editProfileSave {
    return Intl.message('Save', name: 'editProfileSave', desc: '', args: []);
  }

  /// `Changes saved`
  String get editProfileSuccessTitle {
    return Intl.message(
      'Changes saved',
      name: 'editProfileSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your profile information has been updated.`
  String get editProfileSuccessMessage {
    return Intl.message(
      'Your profile information has been updated.',
      name: 'editProfileSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get commonOk {
    return Intl.message('OK', name: 'commonOk', desc: '', args: []);
  }

  /// `Your CV will appear here when uploaded.`
  String get profileResumePlaceholder {
    return Intl.message(
      'Your CV will appear here when uploaded.',
      name: 'profileResumePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `We couldn’t find your profile data yet. Please complete registration.`
  String get profileNoData {
    return Intl.message(
      'We couldn’t find your profile data yet. Please complete registration.',
      name: 'profileNoData',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get profileNameLabel {
    return Intl.message(
      'Full Name',
      name: 'profileNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get dialogErrorTitle {
    return Intl.message('Error', name: 'dialogErrorTitle', desc: '', args: []);
  }

  /// `No user found for that email`
  String get authErrorUserNotFound {
    return Intl.message(
      'No user found for that email',
      name: 'authErrorUserNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password provided for that user`
  String get authErrorWrongPassword {
    return Intl.message(
      'Wrong password provided for that user',
      name: 'authErrorWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `You have been logged out`
  String get logoutSuccess {
    return Intl.message(
      'You have been logged out',
      name: 'logoutSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get navHome {
    return Intl.message('Home', name: 'navHome', desc: '', args: []);
  }

  /// `Jobs`
  String get navJobs {
    return Intl.message('Jobs', name: 'navJobs', desc: '', args: []);
  }

  /// `Active`
  String get employerJobsStatusActive {
    return Intl.message(
      'Active',
      name: 'employerJobsStatusActive',
      desc: '',
      args: [],
    );
  }

  /// `Archived`
  String get employerJobsStatusArchived {
    return Intl.message(
      'Archived',
      name: 'employerJobsStatusArchived',
      desc: '',
      args: [],
    );
  }

  /// `Deleted`
  String get employerJobsStatusDeleted {
    return Intl.message(
      'Deleted',
      name: 'employerJobsStatusDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Please sign in to view your jobs.`
  String get employerJobsLoginPrompt {
    return Intl.message(
      'Please sign in to view your jobs.',
      name: 'employerJobsLoginPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't load jobs: {error}`
  String employerJobsLoadError(String error) {
    return Intl.message(
      'Couldn\'t load jobs: $error',
      name: 'employerJobsLoadError',
      desc: '',
      args: [error],
    );
  }

  /// `No jobs found.`
  String get employerJobsEmpty {
    return Intl.message(
      'No jobs found.',
      name: 'employerJobsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Search jobs`
  String get employerJobsSearchHint {
    return Intl.message(
      'Search jobs',
      name: 'employerJobsSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Search resumes...`
  String get employerResumesSearchHint {
    return Intl.message(
      'Search resumes...',
      name: 'employerResumesSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Job`
  String get employerJobsDefaultTitle {
    return Intl.message(
      'Job',
      name: 'employerJobsDefaultTitle',
      desc: '',
      args: [],
    );
  }

  /// `Experience: {value}`
  String employerJobsExperienceLabel(String value) {
    return Intl.message(
      'Experience: $value',
      name: 'employerJobsExperienceLabel',
      desc: '',
      args: [value],
    );
  }

  /// `Education level: {value}`
  String employerJobsEducationLabel(String value) {
    return Intl.message(
      'Education level: $value',
      name: 'employerJobsEducationLabel',
      desc: '',
      args: [value],
    );
  }

  /// `Active`
  String get employerJobsActionLabel {
    return Intl.message(
      'Active',
      name: 'employerJobsActionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get navSaved {
    return Intl.message('Saved', name: 'navSaved', desc: '', args: []);
  }

  /// `Profile`
  String get navProfile {
    return Intl.message('Profile', name: 'navProfile', desc: '', args: []);
  }

  /// `{tab} tab coming soon`
  String placeholderTab(Object tab) {
    return Intl.message(
      '$tab tab coming soon',
      name: 'placeholderTab',
      desc: 'Placeholder text for tabs not implemented yet',
      args: [tab],
    );
  }

  /// `posted at: {days} days ago`
  String jobPostedAt(int days) {
    return Intl.message(
      'posted at: $days days ago',
      name: 'jobPostedAt',
      desc: 'Relative posting time label',
      args: [days],
    );
  }

  /// `Dark Mode`
  String get themeDarkModeLabel {
    return Intl.message(
      'Dark Mode',
      name: 'themeDarkModeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Delete account?`
  String get deleteAccountTitle {
    return Intl.message(
      'Delete account?',
      name: 'deleteAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `This will permanently remove your account and data. Continue?`
  String get deleteAccountMessage {
    return Intl.message(
      'This will permanently remove your account and data. Continue?',
      name: 'deleteAccountMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been deleted.`
  String get deleteAccountSuccess {
    return Intl.message(
      'Your account has been deleted.',
      name: 'deleteAccountSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Please log in again before deleting your account.`
  String get deleteAccountReauth {
    return Intl.message(
      'Please log in again before deleting your account.',
      name: 'deleteAccountReauth',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get commonCancel {
    return Intl.message('Cancel', name: 'commonCancel', desc: '', args: []);
  }

  /// `Build your CV`
  String get cvCreateTitle {
    return Intl.message(
      'Build your CV',
      name: 'cvCreateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Personal information`
  String get cvStepPersonalInfo {
    return Intl.message(
      'Personal information',
      name: 'cvStepPersonalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Contact information`
  String get cvStepContact {
    return Intl.message(
      'Contact information',
      name: 'cvStepContact',
      desc: '',
      args: [],
    );
  }

  /// `Personal skills`
  String get cvStepSkills {
    return Intl.message(
      'Personal skills',
      name: 'cvStepSkills',
      desc: '',
      args: [],
    );
  }

  /// `About me`
  String get cvStepSummary {
    return Intl.message('About me', name: 'cvStepSummary', desc: '', args: []);
  }

  /// `Education`
  String get cvStepEducation {
    return Intl.message(
      'Education',
      name: 'cvStepEducation',
      desc: '',
      args: [],
    );
  }

  /// `Training courses`
  String get cvStepCourses {
    return Intl.message(
      'Training courses',
      name: 'cvStepCourses',
      desc: '',
      args: [],
    );
  }

  /// `Work experience`
  String get cvStepExperience {
    return Intl.message(
      'Work experience',
      name: 'cvStepExperience',
      desc: '',
      args: [],
    );
  }

  /// `Job title (Arabic)`
  String get cvFieldJobTitleAr {
    return Intl.message(
      'Job title (Arabic)',
      name: 'cvFieldJobTitleAr',
      desc: '',
      args: [],
    );
  }

  /// `Job title (English)`
  String get cvFieldJobTitleEn {
    return Intl.message(
      'Job title (English)',
      name: 'cvFieldJobTitleEn',
      desc: '',
      args: [],
    );
  }

  /// `Education level`
  String get cvFieldEducationLevel {
    return Intl.message(
      'Education level',
      name: 'cvFieldEducationLevel',
      desc: '',
      args: [],
    );
  }

  /// `Years of experience`
  String get cvFieldYearsExperience {
    return Intl.message(
      'Years of experience',
      name: 'cvFieldYearsExperience',
      desc: '',
      args: [],
    );
  }

  /// `Phone number (1)`
  String get cvFieldPhone1 {
    return Intl.message(
      'Phone number (1)',
      name: 'cvFieldPhone1',
      desc: '',
      args: [],
    );
  }

  /// `Phone number (2)`
  String get cvFieldPhone2 {
    return Intl.message(
      'Phone number (2)',
      name: 'cvFieldPhone2',
      desc: '',
      args: [],
    );
  }

  /// `Phone number (3)`
  String get cvFieldPhone3 {
    return Intl.message(
      'Phone number (3)',
      name: 'cvFieldPhone3',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get cvFieldEmail {
    return Intl.message('Email', name: 'cvFieldEmail', desc: '', args: []);
  }

  /// `Type a skill then press add`
  String get cvFieldSkillPlaceholder {
    return Intl.message(
      'Type a skill then press add',
      name: 'cvFieldSkillPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Objective in Arabic`
  String get cvFieldSummaryAr {
    return Intl.message(
      'Objective in Arabic',
      name: 'cvFieldSummaryAr',
      desc: '',
      args: [],
    );
  }

  /// `Objective in English`
  String get cvFieldSummaryEn {
    return Intl.message(
      'Objective in English',
      name: 'cvFieldSummaryEn',
      desc: '',
      args: [],
    );
  }

  /// `Educational institution`
  String get cvEducationInstitution {
    return Intl.message(
      'Educational institution',
      name: 'cvEducationInstitution',
      desc: '',
      args: [],
    );
  }

  /// `Major in Arabic`
  String get cvEducationMajorAr {
    return Intl.message(
      'Major in Arabic',
      name: 'cvEducationMajorAr',
      desc: '',
      args: [],
    );
  }

  /// `Major in English`
  String get cvEducationMajorEn {
    return Intl.message(
      'Major in English',
      name: 'cvEducationMajorEn',
      desc: '',
      args: [],
    );
  }

  /// `Start date`
  String get cvEducationStartDate {
    return Intl.message(
      'Start date',
      name: 'cvEducationStartDate',
      desc: '',
      args: [],
    );
  }

  /// `End date`
  String get cvEducationEndDate {
    return Intl.message(
      'End date',
      name: 'cvEducationEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Company name (Arabic)`
  String get cvExperienceCompanyAr {
    return Intl.message(
      'Company name (Arabic)',
      name: 'cvExperienceCompanyAr',
      desc: '',
      args: [],
    );
  }

  /// `Company name (English)`
  String get cvExperienceCompanyEn {
    return Intl.message(
      'Company name (English)',
      name: 'cvExperienceCompanyEn',
      desc: '',
      args: [],
    );
  }

  /// `Job title (Arabic)`
  String get cvExperienceRoleAr {
    return Intl.message(
      'Job title (Arabic)',
      name: 'cvExperienceRoleAr',
      desc: '',
      args: [],
    );
  }

  /// `Job title (English)`
  String get cvExperienceRoleEn {
    return Intl.message(
      'Job title (English)',
      name: 'cvExperienceRoleEn',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get cvExperienceDescription {
    return Intl.message(
      'Description',
      name: 'cvExperienceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Start date`
  String get cvExperienceStartDate {
    return Intl.message(
      'Start date',
      name: 'cvExperienceStartDate',
      desc: '',
      args: [],
    );
  }

  /// `End date`
  String get cvExperienceEndDate {
    return Intl.message(
      'End date',
      name: 'cvExperienceEndDate',
      desc: '',
      args: [],
    );
  }

  /// `Course organizer`
  String get cvCourseOrganization {
    return Intl.message(
      'Course organizer',
      name: 'cvCourseOrganization',
      desc: '',
      args: [],
    );
  }

  /// `Course title`
  String get cvCourseTitle {
    return Intl.message(
      'Course title',
      name: 'cvCourseTitle',
      desc: '',
      args: [],
    );
  }

  /// `Course date`
  String get cvCourseDate {
    return Intl.message(
      'Course date',
      name: 'cvCourseDate',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get cvButtonAdd {
    return Intl.message('Add', name: 'cvButtonAdd', desc: '', args: []);
  }

  /// `Save & continue`
  String get cvButtonSaveContinue {
    return Intl.message(
      'Save & continue',
      name: 'cvButtonSaveContinue',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get cvButtonPrevious {
    return Intl.message(
      'Previous',
      name: 'cvButtonPrevious',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get cvButtonFinish {
    return Intl.message('Finish', name: 'cvButtonFinish', desc: '', args: []);
  }

  /// `Create your CV`
  String get cvButtonStart {
    return Intl.message(
      'Create your CV',
      name: 'cvButtonStart',
      desc: '',
      args: [],
    );
  }

  /// `You have not created your CV yet.`
  String get cvEmptyMessage {
    return Intl.message(
      'You have not created your CV yet.',
      name: 'cvEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `Download my CV`
  String get cvDownloadTitle {
    return Intl.message(
      'Download my CV',
      name: 'cvDownloadTitle',
      desc: '',
      args: [],
    );
  }

  /// `Free CV`
  String get cvDownloadFree {
    return Intl.message('Free CV', name: 'cvDownloadFree', desc: '', args: []);
  }

  /// `Premium`
  String get cvDownloadPremium {
    return Intl.message(
      'Premium',
      name: 'cvDownloadPremium',
      desc: '',
      args: [],
    );
  }

  /// `Gold`
  String get cvDownloadGold {
    return Intl.message('Gold', name: 'cvDownloadGold', desc: '', args: []);
  }

  /// `Download`
  String get cvDownloadButton {
    return Intl.message(
      'Download',
      name: 'cvDownloadButton',
      desc: '',
      args: [],
    );
  }

  /// `Download my CV`
  String get cvDownloadCta {
    return Intl.message(
      'Download my CV',
      name: 'cvDownloadCta',
      desc: '',
      args: [],
    );
  }

  /// `Choose how you’d like to export your CV.`
  String get cvDownloadSubtitle {
    return Intl.message(
      'Choose how you’d like to export your CV.',
      name: 'cvDownloadSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `$0`
  String get cvDownloadFreePrice {
    return Intl.message('\$0', name: 'cvDownloadFreePrice', desc: '', args: []);
  }

  /// `$5`
  String get cvDownloadPremiumPrice {
    return Intl.message(
      '\$5',
      name: 'cvDownloadPremiumPrice',
      desc: '',
      args: [],
    );
  }

  /// `$10`
  String get cvDownloadGoldPrice {
    return Intl.message(
      '\$10',
      name: 'cvDownloadGoldPrice',
      desc: '',
      args: [],
    );
  }

  /// `Standard PDF export.`
  String get cvDownloadFreeDesc {
    return Intl.message(
      'Standard PDF export.',
      name: 'cvDownloadFreeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Enhanced formatting and layout.`
  String get cvDownloadPremiumDesc {
    return Intl.message(
      'Enhanced formatting and layout.',
      name: 'cvDownloadPremiumDesc',
      desc: '',
      args: [],
    );
  }

  /// `Premium template with advanced styling.`
  String get cvDownloadGoldDesc {
    return Intl.message(
      'Premium template with advanced styling.',
      name: 'cvDownloadGoldDesc',
      desc: '',
      args: [],
    );
  }

  /// `Coming soon`
  String get cvDownloadComingSoon {
    return Intl.message(
      'Coming soon',
      name: 'cvDownloadComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Download options will be available soon.`
  String get cvDownloadToast {
    return Intl.message(
      'Download options will be available soon.',
      name: 'cvDownloadToast',
      desc: '',
      args: [],
    );
  }

  /// `Main information`
  String get cvSectionMainInfo {
    return Intl.message(
      'Main information',
      name: 'cvSectionMainInfo',
      desc: '',
      args: [],
    );
  }

  /// `Contact information`
  String get cvSectionContact {
    return Intl.message(
      'Contact information',
      name: 'cvSectionContact',
      desc: '',
      args: [],
    );
  }

  /// `Phone numbers`
  String get cvSectionContactPhones {
    return Intl.message(
      'Phone numbers',
      name: 'cvSectionContactPhones',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get cvSectionContactEmail {
    return Intl.message(
      'Email address',
      name: 'cvSectionContactEmail',
      desc: '',
      args: [],
    );
  }

  /// `Personal skills`
  String get cvSectionSkills {
    return Intl.message(
      'Personal skills',
      name: 'cvSectionSkills',
      desc: '',
      args: [],
    );
  }

  /// `About me`
  String get cvSectionSummary {
    return Intl.message(
      'About me',
      name: 'cvSectionSummary',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get cvSectionEducation {
    return Intl.message(
      'Education',
      name: 'cvSectionEducation',
      desc: '',
      args: [],
    );
  }

  /// `Training courses`
  String get cvSectionCourses {
    return Intl.message(
      'Training courses',
      name: 'cvSectionCourses',
      desc: '',
      args: [],
    );
  }

  /// `Work experience`
  String get cvSectionExperience {
    return Intl.message(
      'Work experience',
      name: 'cvSectionExperience',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get cvNoData {
    return Intl.message('No data', name: 'cvNoData', desc: '', args: []);
  }

  /// `Add skill`
  String get cvAddSkill {
    return Intl.message('Add skill', name: 'cvAddSkill', desc: '', args: []);
  }

  /// `No skills added yet.`
  String get cvSkillsEmpty {
    return Intl.message(
      'No skills added yet.',
      name: 'cvSkillsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `No summary provided.`
  String get cvSummaryEmpty {
    return Intl.message(
      'No summary provided.',
      name: 'cvSummaryEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Start building your CV`
  String get cvCreateCta {
    return Intl.message(
      'Start building your CV',
      name: 'cvCreateCta',
      desc: '',
      args: [],
    );
  }

  /// `Edit my CV`
  String get cvEditButton {
    return Intl.message('Edit my CV', name: 'cvEditButton', desc: '', args: []);
  }

  /// `Premium`
  String get employerPremiumHeaderLabel {
    return Intl.message(
      'Premium',
      name: 'employerPremiumHeaderLabel',
      desc: '',
      args: [],
    );
  }

  /// `Work`
  String get employerPremiumOverviewTitle {
    return Intl.message(
      'Work',
      name: 'employerPremiumOverviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Flexible posting plans tailored to your hiring needs\nImproved visibility through featured ads\nCost-effective hiring with scalable options.`
  String get employerPremiumOverviewBody {
    return Intl.message(
      'Flexible posting plans tailored to your hiring needs\nImproved visibility through featured ads\nCost-effective hiring with scalable options.',
      name: 'employerPremiumOverviewBody',
      desc: '',
      args: [],
    );
  }

  /// `Choose subscription duration`
  String get employerPremiumChooseDuration {
    return Intl.message(
      'Choose subscription duration',
      name: 'employerPremiumChooseDuration',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe now ({price}\$)`
  String employerPremiumSubscribeNow(num price) {
    return Intl.message(
      'Subscribe now ($price\\\$)',
      name: 'employerPremiumSubscribeNow',
      desc: '',
      args: [price],
    );
  }

  /// `Most popular 🔥`
  String get employerPremiumPopularBadge {
    return Intl.message(
      'Most popular 🔥',
      name: 'employerPremiumPopularBadge',
      desc: '',
      args: [],
    );
  }

  /// `Duration 1 week`
  String get employerPlanLabelWeek {
    return Intl.message(
      'Duration 1 week',
      name: 'employerPlanLabelWeek',
      desc: '',
      args: [],
    );
  }

  /// `Duration 1 month`
  String get employerPlanLabelMonth {
    return Intl.message(
      'Duration 1 month',
      name: 'employerPlanLabelMonth',
      desc: '',
      args: [],
    );
  }

  /// `Duration 3 months`
  String get employerPlanLabelThreeMonths {
    return Intl.message(
      'Duration 3 months',
      name: 'employerPlanLabelThreeMonths',
      desc: '',
      args: [],
    );
  }

  /// `Duration 6 months`
  String get employerPlanLabelSixMonths {
    return Intl.message(
      'Duration 6 months',
      name: 'employerPlanLabelSixMonths',
      desc: '',
      args: [],
    );
  }

  /// `Duration 1 year`
  String get employerPlanLabelYear {
    return Intl.message(
      'Duration 1 year',
      name: 'employerPlanLabelYear',
      desc: '',
      args: [],
    );
  }

  /// `{count} job posts`
  String employerPlanBenefitJobPosts(num count) {
    return Intl.message(
      '$count job posts',
      name: 'employerPlanBenefitJobPosts',
      desc: '',
      args: [count],
    );
  }

  /// `Listing visible for {days} days`
  String employerPlanBenefitVisibilityDays(num days) {
    return Intl.message(
      'Listing visible for $days days',
      name: 'employerPlanBenefitVisibilityDays',
      desc: '',
      args: [days],
    );
  }

  /// `{count} resume views`
  String employerPlanBenefitResumeViews(num count) {
    return Intl.message(
      '$count resume views',
      name: 'employerPlanBenefitResumeViews',
      desc: '',
      args: [count],
    );
  }

  /// `{count} featured boosts`
  String employerPlanBenefitFeaturedAds(num count) {
    return Intl.message(
      '$count featured boosts',
      name: 'employerPlanBenefitFeaturedAds',
      desc: '',
      args: [count],
    );
  }

  /// `{count} ad edits`
  String employerPlanBenefitEdits(num count) {
    return Intl.message(
      '$count ad edits',
      name: 'employerPlanBenefitEdits',
      desc: '',
      args: [count],
    );
  }

  /// `Unlimited ad edits`
  String get employerPlanBenefitEditsUnlimited {
    return Intl.message(
      'Unlimited ad edits',
      name: 'employerPlanBenefitEditsUnlimited',
      desc: '',
      args: [],
    );
  }

  /// `Company Account`
  String get employerAccountDefaultCompanyName {
    return Intl.message(
      'Company Account',
      name: 'employerAccountDefaultCompanyName',
      desc: '',
      args: [],
    );
  }

  /// `Please sign in as an employer to view this page.`
  String get employerAccountLoginRequired {
    return Intl.message(
      'Please sign in as an employer to view this page.',
      name: 'employerAccountLoginRequired',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while loading data: {error}`
  String employerAccountLoadError(String error) {
    return Intl.message(
      'An error occurred while loading data: $error',
      name: 'employerAccountLoadError',
      desc: '',
      args: [error],
    );
  }

  /// `Account`
  String get employerAccountTitle {
    return Intl.message(
      'Account',
      name: 'employerAccountTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select your company industry`
  String get employerAccountIndustryPlaceholder {
    return Intl.message(
      'Select your company industry',
      name: 'employerAccountIndustryPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Account info`
  String get employerAccountTabInfo {
    return Intl.message(
      'Account info',
      name: 'employerAccountTabInfo',
      desc: '',
      args: [],
    );
  }

  /// `Company bio`
  String get employerAccountTabAbout {
    return Intl.message(
      'Company bio',
      name: 'employerAccountTabAbout',
      desc: '',
      args: [],
    );
  }

  /// `Company name`
  String get employerAccountFieldCompanyName {
    return Intl.message(
      'Company name',
      name: 'employerAccountFieldCompanyName',
      desc: '',
      args: [],
    );
  }

  /// `Industry`
  String get employerAccountFieldIndustry {
    return Intl.message(
      'Industry',
      name: 'employerAccountFieldIndustry',
      desc: '',
      args: [],
    );
  }

  /// `Company website`
  String get employerAccountFieldWebsite {
    return Intl.message(
      'Company website',
      name: 'employerAccountFieldWebsite',
      desc: '',
      args: [],
    );
  }

  /// `Company phone 1`
  String get employerAccountFieldPhone1 {
    return Intl.message(
      'Company phone 1',
      name: 'employerAccountFieldPhone1',
      desc: '',
      args: [],
    );
  }

  /// `Company phone 2`
  String get employerAccountFieldPhone2 {
    return Intl.message(
      'Company phone 2',
      name: 'employerAccountFieldPhone2',
      desc: '',
      args: [],
    );
  }

  /// `Company email`
  String get employerAccountFieldEmail {
    return Intl.message(
      'Company email',
      name: 'employerAccountFieldEmail',
      desc: '',
      args: [],
    );
  }

  /// `Company information`
  String get employerAccountSectionInfoTitle {
    return Intl.message(
      'Company information',
      name: 'employerAccountSectionInfoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Contact details`
  String get employerAccountSectionContactTitle {
    return Intl.message(
      'Contact details',
      name: 'employerAccountSectionContactTitle',
      desc: '',
      args: [],
    );
  }

  /// `Company bio (Arabic)`
  String get employerAccountAboutArabic {
    return Intl.message(
      'Company bio (Arabic)',
      name: 'employerAccountAboutArabic',
      desc: '',
      args: [],
    );
  }

  /// `Company bio (English)`
  String get employerAccountAboutEnglish {
    return Intl.message(
      'Company bio (English)',
      name: 'employerAccountAboutEnglish',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get employerNavAccount {
    return Intl.message(
      'Account',
      name: 'employerNavAccount',
      desc: '',
      args: [],
    );
  }

  /// `Jobs`
  String get employerNavJobs {
    return Intl.message('Jobs', name: 'employerNavJobs', desc: '', args: []);
  }

  /// `Resumes`
  String get employerNavResumes {
    return Intl.message(
      'Resumes',
      name: 'employerNavResumes',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get employerNavHome {
    return Intl.message('Home', name: 'employerNavHome', desc: '', args: []);
  }

  /// `Company information saved successfully.`
  String get employerEditInfoSuccess {
    return Intl.message(
      'Company information saved successfully.',
      name: 'employerEditInfoSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save: {error}`
  String employerEditInfoFailure(String error) {
    return Intl.message(
      'Failed to save: $error',
      name: 'employerEditInfoFailure',
      desc: '',
      args: [error],
    );
  }

  /// `Company information`
  String get employerEditInfoHeader {
    return Intl.message(
      'Company information',
      name: 'employerEditInfoHeader',
      desc: '',
      args: [],
    );
  }

  /// `Company name (Arabic)`
  String get employerEditInfoLabelCompanyName {
    return Intl.message(
      'Company name (Arabic)',
      name: 'employerEditInfoLabelCompanyName',
      desc: '',
      args: [],
    );
  }

  /// `Industry (Arabic)`
  String get employerEditInfoLabelIndustry {
    return Intl.message(
      'Industry (Arabic)',
      name: 'employerEditInfoLabelIndustry',
      desc: '',
      args: [],
    );
  }

  /// `Advertiser role`
  String get employerEditInfoLabelAdvertiserRole {
    return Intl.message(
      'Advertiser role',
      name: 'employerEditInfoLabelAdvertiserRole',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get employerEditInfoLabelAddress {
    return Intl.message(
      'Address',
      name: 'employerEditInfoLabelAddress',
      desc: '',
      args: [],
    );
  }

  /// `Company website`
  String get employerEditInfoLabelWebsite {
    return Intl.message(
      'Company website',
      name: 'employerEditInfoLabelWebsite',
      desc: '',
      args: [],
    );
  }

  /// `Contact details`
  String get employerEditInfoSectionPhones {
    return Intl.message(
      'Contact details',
      name: 'employerEditInfoSectionPhones',
      desc: '',
      args: [],
    );
  }

  /// `945236782`
  String get employerEditInfoPhoneHint {
    return Intl.message(
      '945236782',
      name: 'employerEditInfoPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Secondary phone (optional)`
  String get employerEditInfoLabelPhoneSecondary {
    return Intl.message(
      'Secondary phone (optional)',
      name: 'employerEditInfoLabelPhoneSecondary',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get employerEditInfoLabelEmail {
    return Intl.message(
      'Email address',
      name: 'employerEditInfoLabelEmail',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get employerEditInfoSaveButton {
    return Intl.message(
      'Save',
      name: 'employerEditInfoSaveButton',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get employerEditInfoValidationRequired {
    return Intl.message(
      'This field is required',
      name: 'employerEditInfoValidationRequired',
      desc: '',
      args: [],
    );
  }

  /// `Business owner`
  String get employerEditInfoRoleOwner {
    return Intl.message(
      'Business owner',
      name: 'employerEditInfoRoleOwner',
      desc: '',
      args: [],
    );
  }

  /// `Recruitment agency`
  String get employerEditInfoRoleAgency {
    return Intl.message(
      'Recruitment agency',
      name: 'employerEditInfoRoleAgency',
      desc: '',
      args: [],
    );
  }

  /// `HR representative`
  String get employerEditInfoRoleHR {
    return Intl.message(
      'HR representative',
      name: 'employerEditInfoRoleHR',
      desc: '',
      args: [],
    );
  }

  /// `Select advertiser role`
  String get employerEditInfoSelectRoleTitle {
    return Intl.message(
      'Select advertiser role',
      name: 'employerEditInfoSelectRoleTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tripoli`
  String get employerEditInfoAddressTripoli {
    return Intl.message(
      'Tripoli',
      name: 'employerEditInfoAddressTripoli',
      desc: '',
      args: [],
    );
  }

  /// `Benghazi`
  String get employerEditInfoAddressBenghazi {
    return Intl.message(
      'Benghazi',
      name: 'employerEditInfoAddressBenghazi',
      desc: '',
      args: [],
    );
  }

  /// `Misrata`
  String get employerEditInfoAddressMisrata {
    return Intl.message(
      'Misrata',
      name: 'employerEditInfoAddressMisrata',
      desc: '',
      args: [],
    );
  }

  /// `Sabha`
  String get employerEditInfoAddressSabha {
    return Intl.message(
      'Sabha',
      name: 'employerEditInfoAddressSabha',
      desc: '',
      args: [],
    );
  }

  /// `Derna`
  String get employerEditInfoAddressDerna {
    return Intl.message(
      'Derna',
      name: 'employerEditInfoAddressDerna',
      desc: '',
      args: [],
    );
  }

  /// `Gharyan`
  String get employerEditInfoAddressGharyan {
    return Intl.message(
      'Gharyan',
      name: 'employerEditInfoAddressGharyan',
      desc: '',
      args: [],
    );
  }

  /// `Select city`
  String get employerEditInfoSelectAddressTitle {
    return Intl.message(
      'Select city',
      name: 'employerEditInfoSelectAddressTitle',
      desc: '',
      args: [],
    );
  }

  /// `Primary phone`
  String get employerEditInfoLabelPhonePrimary {
    return Intl.message(
      'Primary phone',
      name: 'employerEditInfoLabelPhonePrimary',
      desc: '',
      args: [],
    );
  }

  /// `Company bio updated successfully.`
  String get employerEditAboutSuccess {
    return Intl.message(
      'Company bio updated successfully.',
      name: 'employerEditAboutSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save bio: {error}`
  String employerEditAboutFailure(String error) {
    return Intl.message(
      'Failed to save bio: $error',
      name: 'employerEditAboutFailure',
      desc: '',
      args: [error],
    );
  }

  /// `Account created`
  String get registerSuccessTitle {
    return Intl.message(
      'Account created',
      name: 'registerSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `You can now log in`
  String get registerSuccessDesc {
    return Intl.message(
      'You can now log in',
      name: 'registerSuccessDesc',
      desc: '',
      args: [],
    );
  }

  /// `Company bio`
  String get employerEditAboutHeader {
    return Intl.message(
      'Company bio',
      name: 'employerEditAboutHeader',
      desc: '',
      args: [],
    );
  }

  /// `Company bio (Arabic)`
  String get employerEditAboutLabelArabic {
    return Intl.message(
      'Company bio (Arabic)',
      name: 'employerEditAboutLabelArabic',
      desc: '',
      args: [],
    );
  }

  /// `Company bio (English)`
  String get employerEditAboutLabelEnglish {
    return Intl.message(
      'Company bio (English)',
      name: 'employerEditAboutLabelEnglish',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get employerEditAboutSaveButton {
    return Intl.message(
      'Save',
      name: 'employerEditAboutSaveButton',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get employerEditAboutValidationRequired {
    return Intl.message(
      'This field is required',
      name: 'employerEditAboutValidationRequired',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  @override
  bool isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
