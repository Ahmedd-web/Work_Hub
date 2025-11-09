// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

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

  /// `Wzfni`
  String get appTitle {
    return Intl.message('Wzfni', name: 'appTitle', desc: '', args: []);
  }

  /// `Looking for a job..`
  String get searchHint {
    return Intl.message(
      'Looking for a job..',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get menuAbout {
    return Intl.message('About Us', name: 'menuAbout', desc: '', args: []);
  }

  /// `Services Ads`
  String get menuServicesAds {
    return Intl.message(
      'Services Ads',
      name: 'menuServicesAds',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get menuContact {
    return Intl.message('Contact Us', name: 'menuContact', desc: '', args: []);
  }

  /// `Privacy Policy and Terms of Use`
  String get menuPrivacy {
    return Intl.message(
      'Privacy Policy and Terms of Use',
      name: 'menuPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get menuLogin {
    return Intl.message('Login', name: 'menuLogin', desc: '', args: []);
  }

  /// `Logout`
  String get menuLogout {
    return Intl.message('Logout', name: 'menuLogout', desc: '', args: []);
  }

  /// `Create your resume`
  String get actionCreateResume {
    return Intl.message(
      'Create your resume',
      name: 'actionCreateResume',
      desc: '',
      args: [],
    );
  }

  /// `Post a job for free`
  String get actionPostJob {
    return Intl.message(
      'Post a job for free',
      name: 'actionPostJob',
      desc: '',
      args: [],
    );
  }

  /// `Job Categories`
  String get sectionJobCategories {
    return Intl.message(
      'Job Categories',
      name: 'sectionJobCategories',
      desc: '',
      args: [],
    );
  }

  /// `See more`
  String get actionSeeMore {
    return Intl.message('See more', name: 'actionSeeMore', desc: '', args: []);
  }

  /// `Featured Offers`
  String get sectionFeaturedOffers {
    return Intl.message(
      'Featured Offers',
      name: 'sectionFeaturedOffers',
      desc: '',
      args: [],
    );
  }

  /// `Your Dream Job`
  String get bannerDreamTitle {
    return Intl.message(
      'Your Dream Job',
      name: 'bannerDreamTitle',
      desc: '',
      args: [],
    );
  }

  /// `Explore curated openings tailored to your skills.`
  String get bannerDreamSubtitle {
    return Intl.message(
      'Explore curated openings tailored to your skills.',
      name: 'bannerDreamSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Apply now`
  String get bannerDreamBadge {
    return Intl.message(
      'Apply now',
      name: 'bannerDreamBadge',
      desc: '',
      args: [],
    );
  }

  /// `Top Companies`
  String get bannerTopCompaniesTitle {
    return Intl.message(
      'Top Companies',
      name: 'bannerTopCompaniesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Connect with leading teams hiring this week.`
  String get bannerTopCompaniesSubtitle {
    return Intl.message(
      'Connect with leading teams hiring this week.',
      name: 'bannerTopCompaniesSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `View companies`
  String get bannerTopCompaniesBadge {
    return Intl.message(
      'View companies',
      name: 'bannerTopCompaniesBadge',
      desc: '',
      args: [],
    );
  }

  /// `Remote Friendly`
  String get bannerRemoteTitle {
    return Intl.message(
      'Remote Friendly',
      name: 'bannerRemoteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Discover remote roles across multiple industries.`
  String get bannerRemoteSubtitle {
    return Intl.message(
      'Discover remote roles across multiple industries.',
      name: 'bannerRemoteSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `See all roles`
  String get bannerRemoteBadge {
    return Intl.message(
      'See all roles',
      name: 'bannerRemoteBadge',
      desc: '',
      args: [],
    );
  }

  /// `International Organizations`
  String get categoryInternationalOrganizations {
    return Intl.message(
      'International Organizations',
      name: 'categoryInternationalOrganizations',
      desc: '',
      args: [],
    );
  }

  /// `Sales`
  String get categorySales {
    return Intl.message('Sales', name: 'categorySales', desc: '', args: []);
  }

  /// `Administration & Secretary`
  String get categoryAdministration {
    return Intl.message(
      'Administration & Secretary',
      name: 'categoryAdministration',
      desc: '',
      args: [],
    );
  }

  /// `Engineering`
  String get categoryEngineering {
    return Intl.message(
      'Engineering',
      name: 'categoryEngineering',
      desc: '',
      args: [],
    );
  }

  /// `Designer`
  String get categoryDesigner {
    return Intl.message(
      'Designer',
      name: 'categoryDesigner',
      desc: '',
      args: [],
    );
  }

  /// `Programming`
  String get categoryProgramming {
    return Intl.message(
      'Programming',
      name: 'categoryProgramming',
      desc: '',
      args: [],
    );
  }

  /// `Marketing`
  String get categoryMarketing {
    return Intl.message(
      'Marketing',
      name: 'categoryMarketing',
      desc: '',
      args: [],
    );
  }

  /// `Customer Support`
  String get categoryCustomerSupport {
    return Intl.message(
      'Customer Support',
      name: 'categoryCustomerSupport',
      desc: '',
      args: [],
    );
  }

  /// `Boosted Listing`
  String get offerBoostedTitle {
    return Intl.message(
      'Boosted Listing',
      name: 'offerBoostedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Appear at the top of every search for 7 days.`
  String get offerBoostedSubtitle {
    return Intl.message(
      'Appear at the top of every search for 7 days.',
      name: 'offerBoostedSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Premium`
  String get offerBoostedBadge {
    return Intl.message(
      'Premium',
      name: 'offerBoostedBadge',
      desc: '',
      args: [],
    );
  }

  /// `Urgent Hire`
  String get offerUrgentTitle {
    return Intl.message(
      'Urgent Hire',
      name: 'offerUrgentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Highlight your role with an urgent badge and alert.`
  String get offerUrgentSubtitle {
    return Intl.message(
      'Highlight your role with an urgent badge and alert.',
      name: 'offerUrgentSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Sponsored`
  String get offerUrgentBadge {
    return Intl.message(
      'Sponsored',
      name: 'offerUrgentBadge',
      desc: '',
      args: [],
    );
  }

  /// `Talent Spotlight`
  String get offerSpotlightTitle {
    return Intl.message(
      'Talent Spotlight',
      name: 'offerSpotlightTitle',
      desc: '',
      args: [],
    );
  }

  /// `Showcase your profile to companies looking now.`
  String get offerSpotlightSubtitle {
    return Intl.message(
      'Showcase your profile to companies looking now.',
      name: 'offerSpotlightSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get offerSpotlightBadge {
    return Intl.message(
      'Popular',
      name: 'offerSpotlightBadge',
      desc: '',
      args: [],
    );
  }

  /// `Any time`
  String get filterAnyTime {
    return Intl.message('Any time', name: 'filterAnyTime', desc: '', args: []);
  }

  /// `Category`
  String get filterCategory {
    return Intl.message('Category', name: 'filterCategory', desc: '', args: []);
  }

  /// `Choose country`
  String get filterChooseCountry {
    return Intl.message(
      'Choose country',
      name: 'filterChooseCountry',
      desc: '',
      args: [],
    );
  }

  /// `Confidential`
  String get jobCompanyConfidential {
    return Intl.message(
      'Confidential',
      name: 'jobCompanyConfidential',
      desc: '',
      args: [],
    );
  }

  /// `Jordan`
  String get jobLocationJordan {
    return Intl.message(
      'Jordan',
      name: 'jobLocationJordan',
      desc: '',
      args: [],
    );
  }

  /// `Saudi Arabia`
  String get jobLocationSaudi {
    return Intl.message(
      'Saudi Arabia',
      name: 'jobLocationSaudi',
      desc: '',
      args: [],
    );
  }

  /// `Featured post`
  String get jobFeaturedBadge {
    return Intl.message(
      'Featured post',
      name: 'jobFeaturedBadge',
      desc: '',
      args: [],
    );
  }

  /// `Quality Supervisor`
  String get jobTitleQualitySupervisor {
    return Intl.message(
      'Quality Supervisor',
      name: 'jobTitleQualitySupervisor',
      desc: '',
      args: [],
    );
  }

  /// `Admin Officer`
  String get jobTitleAdminOfficer {
    return Intl.message(
      'Admin Officer',
      name: 'jobTitleAdminOfficer',
      desc: '',
      args: [],
    );
  }

  /// `Internal Auditor`
  String get jobTitleInternalAuditor {
    return Intl.message(
      'Internal Auditor',
      name: 'jobTitleInternalAuditor',
      desc: '',
      args: [],
    );
  }

  /// `Finance Specialist`
  String get jobTitleFinanceSpecialist {
    return Intl.message(
      'Finance Specialist',
      name: 'jobTitleFinanceSpecialist',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get languageEnglish {
    return Intl.message('English', name: 'languageEnglish', desc: '', args: []);
  }

  /// `Arabic`
  String get languageArabic {
    return Intl.message('Arabic', name: 'languageArabic', desc: '', args: []);
  }

  /// `Loading...`
  String get appLoading {
    return Intl.message('Loading...', name: 'appLoading', desc: '', args: []);
  }

  /// `Welcome to Wzfni`
  String get welcomeTitle {
    return Intl.message(
      'Welcome to Wzfni',
      name: 'welcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your gateway to seamless work management.`
  String get welcomeSubtitle {
    return Intl.message(
      'Your gateway to seamless work management.',
      name: 'welcomeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `I am job Seeker`
  String get welcomeJobSeeker {
    return Intl.message(
      'I am job Seeker',
      name: 'welcomeJobSeeker',
      desc: '',
      args: [],
    );
  }

  /// `I am an Employer`
  String get welcomeEmployer {
    return Intl.message(
      'I am an Employer',
      name: 'welcomeEmployer',
      desc: '',
      args: [],
    );
  }

  /// `Or you can browse as a guest`
  String get welcomeBrowseAsGuest {
    return Intl.message(
      'Or you can browse as a guest',
      name: 'welcomeBrowseAsGuest',
      desc: '',
      args: [],
    );
  }

  /// `Continue as Guest`
  String get welcomeContinueGuest {
    return Intl.message(
      'Continue as Guest',
      name: 'welcomeContinueGuest',
      desc: '',
      args: [],
    );
  }

  /// `Do you already have an account?`
  String get welcomeHaveAccount {
    return Intl.message(
      'Do you already have an account?',
      name: 'welcomeHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get welcomeLogin {
    return Intl.message('Login', name: 'welcomeLogin', desc: '', args: []);
  }

  /// `Welcome Back!`
  String get loginTitle {
    return Intl.message(
      'Welcome Back!',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get loginEmail {
    return Intl.message('Email', name: 'loginEmail', desc: '', args: []);
  }

  /// `Enter your email...`
  String get loginEmailHint {
    return Intl.message(
      'Enter your email...',
      name: 'loginEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get loginEmailRequired {
    return Intl.message(
      'Required',
      name: 'loginEmailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginPassword {
    return Intl.message('Password', name: 'loginPassword', desc: '', args: []);
  }

  /// `Enter your password...`
  String get loginPasswordHint {
    return Intl.message(
      'Enter your password...',
      name: 'loginPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get loginPasswordRequired {
    return Intl.message(
      'Password is required',
      name: 'loginPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get loginPasswordTooShort {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'loginPasswordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message('Login', name: 'loginButton', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get loginNoAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'loginNoAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get loginRegister {
    return Intl.message('Register', name: 'loginRegister', desc: '', args: []);
  }

  /// `Create Account`
  String get registerTitle {
    return Intl.message(
      'Create Account',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Register Employer`
  String get registerTabEmployer {
    return Intl.message(
      'Register Employer',
      name: 'registerTabEmployer',
      desc: '',
      args: [],
    );
  }

  /// `Register Job Seeker`
  String get registerTabJobSeeker {
    return Intl.message(
      'Register Job Seeker',
      name: 'registerTabJobSeeker',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get fieldRequired {
    return Intl.message('Required', name: 'fieldRequired', desc: '', args: []);
  }

  /// `First Name`
  String get registerFirstNameLabel {
    return Intl.message(
      'First Name',
      name: 'registerFirstNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter first name...`
  String get registerFirstNameHint {
    return Intl.message(
      'Enter first name...',
      name: 'registerFirstNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get registerLastNameLabel {
    return Intl.message(
      'Last Name',
      name: 'registerLastNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter last name...`
  String get registerLastNameHint {
    return Intl.message(
      'Enter last name...',
      name: 'registerLastNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get registerPhoneLabel {
    return Intl.message(
      'Phone Number',
      name: 'registerPhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number...`
  String get registerPhoneHint {
    return Intl.message(
      'Enter phone number...',
      name: 'registerPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get registerEmailLabel {
    return Intl.message(
      'Email',
      name: 'registerEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `example@gmail.com`
  String get registerEmailHint {
    return Intl.message(
      'example@gmail.com',
      name: 'registerEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get registerPasswordLabel {
    return Intl.message(
      'Password',
      name: 'registerPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter password...`
  String get registerPasswordHint {
    return Intl.message(
      'Enter password...',
      name: 'registerPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get registerPasswordTooShort {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'registerPasswordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get registerConfirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'registerConfirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter password...`
  String get registerConfirmPasswordHint {
    return Intl.message(
      'Re-enter password...',
      name: 'registerConfirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get registerPasswordMismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'registerPasswordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Employer name`
  String get registerEmployerNameLabel {
    return Intl.message(
      'Employer name',
      name: 'registerEmployerNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Company, organization, restaurant name...`
  String get registerEmployerNameHint {
    return Intl.message(
      'Company, organization, restaurant name...',
      name: 'registerEmployerNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerButton {
    return Intl.message('Register', name: 'registerButton', desc: '', args: []);
  }

  /// `Already have an account?`
  String get registerHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'registerHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get registerLoginLink {
    return Intl.message('Login', name: 'registerLoginLink', desc: '', args: []);
  }

  /// `The password provided is too weak`
  String get authErrorWeakPassword {
    return Intl.message(
      'The password provided is too weak',
      name: 'authErrorWeakPassword',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email`
  String get authErrorEmailInUse {
    return Intl.message(
      'The account already exists for that email',
      name: 'authErrorEmailInUse',
      desc: '',
      args: [],
    );
  }

  /// `Job Info`
  String get jobInfoTab {
    return Intl.message('Job Info', name: 'jobInfoTab', desc: '', args: []);
  }

  /// `Company Info`
  String get companyInfoTab {
    return Intl.message(
      'Company Info',
      name: 'companyInfoTab',
      desc: '',
      args: [],
    );
  }

  /// `Apply Now`
  String get applyNow {
    return Intl.message('Apply Now', name: 'applyNow', desc: '', args: []);
  }

  /// `Salary`
  String get jobDetailSalaryLabel {
    return Intl.message(
      'Salary',
      name: 'jobDetailSalaryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Experience`
  String get jobDetailExperienceLabel {
    return Intl.message(
      'Experience',
      name: 'jobDetailExperienceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get jobDetailLocationLabel {
    return Intl.message(
      'Location',
      name: 'jobDetailLocationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Job Information`
  String get jobInfoSectionTitle {
    return Intl.message(
      'Job Information',
      name: 'jobInfoSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Company Information`
  String get companyInfoSectionTitle {
    return Intl.message(
      'Company Information',
      name: 'companyInfoSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Job Description`
  String get jobDescriptionTitle {
    return Intl.message(
      'Job Description',
      name: 'jobDescriptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Job Title`
  String get jobDetailJobTitle {
    return Intl.message(
      'Job Title',
      name: 'jobDetailJobTitle',
      desc: '',
      args: [],
    );
  }

  /// `Years of Experience`
  String get jobDetailExperienceYears {
    return Intl.message(
      'Years of Experience',
      name: 'jobDetailExperienceYears',
      desc: '',
      args: [],
    );
  }

  /// `Education Level`
  String get jobDetailEducationLevel {
    return Intl.message(
      'Education Level',
      name: 'jobDetailEducationLevel',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get jobDetailDepartment {
    return Intl.message(
      'Department',
      name: 'jobDetailDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get jobDetailNationality {
    return Intl.message(
      'Nationality',
      name: 'jobDetailNationality',
      desc: '',
      args: [],
    );
  }

  /// `Work Location`
  String get jobDetailWorkLocation {
    return Intl.message(
      'Work Location',
      name: 'jobDetailWorkLocation',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get jobDetailCity {
    return Intl.message('City', name: 'jobDetailCity', desc: '', args: []);
  }

  /// `Apply Before`
  String get jobDetailDeadline {
    return Intl.message(
      'Apply Before',
      name: 'jobDetailDeadline',
      desc: '',
      args: [],
    );
  }

  /// `Company Summary`
  String get jobDetailCompanySummary {
    return Intl.message(
      'Company Summary',
      name: 'jobDetailCompanySummary',
      desc: '',
      args: [],
    );
  }

  /// `Company name`
  String get jobDetailCompanyNameLabel {
    return Intl.message(
      'Company name',
      name: 'jobDetailCompanyNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Present your profile with confidence. Review the requirements, highlight your key achievements, and submit an application tailored to the hiring manager.`
  String get jobDescriptionDefault {
    return Intl.message(
      'Present your profile with confidence. Review the requirements, highlight your key achievements, and submit an application tailored to the hiring manager.',
      name: 'jobDescriptionDefault',
      desc: '',
      args: [],
    );
  }

  /// `We invest in continuous learning, transparent leadership, and an inclusive culture so every team member can grow.`
  String get jobCompanySummaryDefault {
    return Intl.message(
      'We invest in continuous learning, transparent leadership, and an inclusive culture so every team member can grow.',
      name: 'jobCompanySummaryDefault',
      desc: '',
      args: [],
    );
  }

  /// `You haven’t saved any jobs yet.`
  String get savedEmptyMessage {
    return Intl.message(
      'You haven’t saved any jobs yet.',
      name: 'savedEmptyMessage',
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
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
