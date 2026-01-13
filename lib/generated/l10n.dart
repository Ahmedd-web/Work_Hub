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

  /// `Mhnty`
  String get appTitle {
    return Intl.message('Mhnty', name: 'appTitle', desc: '', args: []);
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

  /// `Delete Account`
  String get menuDeleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'menuDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Your current membership`
  String get menuMembershipTitle {
    return Intl.message(
      'Your current membership',
      name: 'menuMembershipTitle',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get commonBack {
    return Intl.message('Back', name: 'commonBack', desc: '', args: []);
  }

  /// `Next`
  String get commonNext {
    return Intl.message('Next', name: 'commonNext', desc: '', args: []);
  }

  /// `Edit job`
  String get employerPostJobEditTitle {
    return Intl.message(
      'Edit job',
      name: 'employerPostJobEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save and publish`
  String get employerPostJobSubmit {
    return Intl.message(
      'Save and publish',
      name: 'employerPostJobSubmit',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to view notifications`
  String get applicantNotifsLogin {
    return Intl.message(
      'Sign in to view notifications',
      name: 'applicantNotifsLogin',
      desc: '',
      args: [],
    );
  }

  /// `Error loading notifications`
  String get applicantNotifsLoadError {
    return Intl.message(
      'Error loading notifications',
      name: 'applicantNotifsLoadError',
      desc: '',
      args: [],
    );
  }

  /// `No notifications`
  String get applicantNotifsEmpty {
    return Intl.message(
      'No notifications',
      name: 'applicantNotifsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Your application was accepted`
  String get applicantNotifsAcceptedTitle {
    return Intl.message(
      'Your application was accepted',
      name: 'applicantNotifsAcceptedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your application was rejected`
  String get applicantNotifsRejectedTitle {
    return Intl.message(
      'Your application was rejected',
      name: 'applicantNotifsRejectedTitle',
      desc: '',
      args: [],
    );
  }

  /// `You were accepted for the job {jobTitle}. Please contact the company.`
  String applicantNotifsAcceptedBody(Object jobTitle) {
    return Intl.message(
      'You were accepted for the job $jobTitle. Please contact the company.',
      name: 'applicantNotifsAcceptedBody',
      desc: '',
      args: [jobTitle],
    );
  }

  /// `Your application for {jobTitle} was declined.`
  String applicantNotifsRejectedBody(Object jobTitle) {
    return Intl.message(
      'Your application for $jobTitle was declined.',
      name: 'applicantNotifsRejectedBody',
      desc: '',
      args: [jobTitle],
    );
  }

  /// `Job info`
  String get employerPostJobStepInfo {
    return Intl.message(
      'Job info',
      name: 'employerPostJobStepInfo',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get employerPostJobStepLocation {
    return Intl.message(
      'Location',
      name: 'employerPostJobStepLocation',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get employerPostJobStepDescription {
    return Intl.message(
      'Description',
      name: 'employerPostJobStepDescription',
      desc: '',
      args: [],
    );
  }

  /// `Application`
  String get employerPostJobStepApply {
    return Intl.message(
      'Application',
      name: 'employerPostJobStepApply',
      desc: '',
      args: [],
    );
  }

  /// `Name in Arabic`
  String get applyNameArLabel {
    return Intl.message(
      'Name in Arabic',
      name: 'applyNameArLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name in Arabic`
  String get applyNameArHint {
    return Intl.message(
      'Enter your name in Arabic',
      name: 'applyNameArHint',
      desc: '',
      args: [],
    );
  }

  /// `Name in English`
  String get applyNameEnLabel {
    return Intl.message(
      'Name in English',
      name: 'applyNameEnLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name in English`
  String get applyNameEnHint {
    return Intl.message(
      'Enter your name in English',
      name: 'applyNameEnHint',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get applyPhoneLabel {
    return Intl.message(
      'Phone number',
      name: 'applyPhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get applyPhoneHint {
    return Intl.message(
      'Enter your phone number',
      name: 'applyPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Resume (PDF)`
  String get applyCvLabel {
    return Intl.message(
      'Resume (PDF)',
      name: 'applyCvLabel',
      desc: '',
      args: [],
    );
  }

  /// `Upload resume file`
  String get applyCvButton {
    return Intl.message(
      'Upload resume file',
      name: 'applyCvButton',
      desc: '',
      args: [],
    );
  }

  /// `Please attach a PDF resume`
  String get applyCvRequired {
    return Intl.message(
      'Please attach a PDF resume',
      name: 'applyCvRequired',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get menuMembershipStatusFree {
    return Intl.message(
      'Free',
      name: 'menuMembershipStatusFree',
      desc: '',
      args: [],
    );
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

  /// `Quality`
  String get jobDeptQuality {
    return Intl.message('Quality', name: 'jobDeptQuality', desc: '', args: []);
  }

  /// `Administration`
  String get jobDeptAdministration {
    return Intl.message(
      'Administration',
      name: 'jobDeptAdministration',
      desc: '',
      args: [],
    );
  }

  /// `Finance`
  String get jobDeptFinance {
    return Intl.message('Finance', name: 'jobDeptFinance', desc: '', args: []);
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

  /// `Last 24 hours`
  String get filterLast24h {
    return Intl.message(
      'Last 24 hours',
      name: 'filterLast24h',
      desc: '',
      args: [],
    );
  }

  /// `Past week`
  String get filterLast7d {
    return Intl.message('Past week', name: 'filterLast7d', desc: '', args: []);
  }

  /// `Past month`
  String get filterLast30d {
    return Intl.message(
      'Past month',
      name: 'filterLast30d',
      desc: '',
      args: [],
    );
  }

  /// `All categories`
  String get filterAllCategories {
    return Intl.message(
      'All categories',
      name: 'filterAllCategories',
      desc: '',
      args: [],
    );
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

  /// `Tripoli`
  String get jobLocationJordan {
    return Intl.message(
      'Tripoli',
      name: 'jobLocationJordan',
      desc: '',
      args: [],
    );
  }

  /// `Benghazi`
  String get jobLocationSaudi {
    return Intl.message(
      'Benghazi',
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

  /// `Welcome to Nuqta Wasl`
  String get welcomeTitle {
    return Intl.message(
      'Welcome to Nuqta Wasl',
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

  /// `Invalid email address`
  String get loginEmailInvalid {
    return Intl.message(
      'Invalid email address',
      name: 'loginEmailInvalid',
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

  /// `Personal Info`
  String get profilePersonalTab {
    return Intl.message(
      'Personal Info',
      name: 'profilePersonalTab',
      desc: '',
      args: [],
    );
  }

  /// `My Resume`
  String get profileResumeTab {
    return Intl.message(
      'My Resume',
      name: 'profileResumeTab',
      desc: '',
      args: [],
    );
  }

  /// `Name (Arabic)`
  String get profileNameArabic {
    return Intl.message(
      'Name (Arabic)',
      name: 'profileNameArabic',
      desc: '',
      args: [],
    );
  }

  /// `Name (English)`
  String get profileNameEnglish {
    return Intl.message(
      'Name (English)',
      name: 'profileNameEnglish',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get profileAddress {
    return Intl.message('Address', name: 'profileAddress', desc: '', args: []);
  }

  /// `Nationality`
  String get profileNationality {
    return Intl.message(
      'Nationality',
      name: 'profileNationality',
      desc: '',
      args: [],
    );
  }

  /// `City / Region`
  String get profileCity {
    return Intl.message(
      'City / Region',
      name: 'profileCity',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get profilePhone {
    return Intl.message(
      'Phone Number',
      name: 'profilePhone',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get profileEmail {
    return Intl.message('Email', name: 'profileEmail', desc: '', args: []);
  }

  /// `Resume`
  String get profileResumeTitle {
    return Intl.message(
      'Resume',
      name: 'profileResumeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Personal information`
  String get editProfileTitle {
    return Intl.message(
      'Personal information',
      name: 'editProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get editProfileFullName {
    return Intl.message(
      'Full name',
      name: 'editProfileFullName',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get editProfilePhone {
    return Intl.message(
      'Phone number',
      name: 'editProfilePhone',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get editProfileEmail {
    return Intl.message(
      'Email address',
      name: 'editProfileEmail',
      desc: '',
      args: [],
    );
  }

  /// `CV link`
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

  /// `Your CV has been saved successfully.`
  String get cvSavedToast {
    return Intl.message(
      'Your CV has been saved successfully.',
      name: 'cvSavedToast',
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

  /// `Explore CVs`
  String get employerResumesTitle {
    return Intl.message(
      'Explore CVs',
      name: 'employerResumesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Filter resumes by time and specialty to pick the best fit.`
  String get employerResumesSubtitle {
    return Intl.message(
      'Filter resumes by time and specialty to pick the best fit.',
      name: 'employerResumesSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get employerResumesTimeLabel {
    return Intl.message(
      'Time',
      name: 'employerResumesTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get employerResumesCategoryLabel {
    return Intl.message(
      'Category',
      name: 'employerResumesCategoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Last 24h`
  String get employerResumesTime24h {
    return Intl.message(
      'Last 24h',
      name: 'employerResumesTime24h',
      desc: '',
      args: [],
    );
  }

  /// `Last 7 days`
  String get employerResumesTime7d {
    return Intl.message(
      'Last 7 days',
      name: 'employerResumesTime7d',
      desc: '',
      args: [],
    );
  }

  /// `Last 30 days`
  String get employerResumesTime30d {
    return Intl.message(
      'Last 30 days',
      name: 'employerResumesTime30d',
      desc: '',
      args: [],
    );
  }

  /// `Anytime`
  String get employerResumesTimeAny {
    return Intl.message(
      'Anytime',
      name: 'employerResumesTimeAny',
      desc: '',
      args: [],
    );
  }

  /// `All categories`
  String get employerResumesCatAll {
    return Intl.message(
      'All categories',
      name: 'employerResumesCatAll',
      desc: '',
      args: [],
    );
  }

  /// `Tech`
  String get employerResumesCatTech {
    return Intl.message(
      'Tech',
      name: 'employerResumesCatTech',
      desc: '',
      args: [],
    );
  }

  /// `Marketing`
  String get employerResumesCatMarketing {
    return Intl.message(
      'Marketing',
      name: 'employerResumesCatMarketing',
      desc: '',
      args: [],
    );
  }

  /// `Administration`
  String get employerResumesCatAdmin {
    return Intl.message(
      'Administration',
      name: 'employerResumesCatAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Engineering`
  String get employerResumesCatEngineering {
    return Intl.message(
      'Engineering',
      name: 'employerResumesCatEngineering',
      desc: '',
      args: [],
    );
  }

  /// `Latest resumes`
  String get employerDashboardLatestResumes {
    return Intl.message(
      'Latest resumes',
      name: 'employerDashboardLatestResumes',
      desc: '',
      args: [],
    );
  }

  /// `See more`
  String get employerDashboardSeeMore {
    return Intl.message(
      'See more',
      name: 'employerDashboardSeeMore',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get employerDashboardNoData {
    return Intl.message(
      'No data',
      name: 'employerDashboardNoData',
      desc: '',
      args: [],
    );
  }

  /// `Post your job for free`
  String get employerPostJobCta {
    return Intl.message(
      'Post your job for free',
      name: 'employerPostJobCta',
      desc: '',
      args: [],
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

  /// `Warning`
  String get dialogWarningTitle {
    return Intl.message(
      'Warning',
      name: 'dialogWarningTitle',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get dialogSuccessTitle {
    return Intl.message(
      'Success',
      name: 'dialogSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get dialogErrorTitle {
    return Intl.message('Error', name: 'dialogErrorTitle', desc: '', args: []);
  }

  /// `OK`
  String get dialogOk {
    return Intl.message('OK', name: 'dialogOk', desc: '', args: []);
  }

  /// `Close`
  String get dialogClose {
    return Intl.message('Close', name: 'dialogClose', desc: '', args: []);
  }

  /// `Please sign in to continue publishing`
  String get dialogLoginRequiredDesc {
    return Intl.message(
      'Please sign in to continue publishing',
      name: 'dialogLoginRequiredDesc',
      desc: '',
      args: [],
    );
  }

  /// `Job updated successfully`
  String get jobPostUpdateSuccess {
    return Intl.message(
      'Job updated successfully',
      name: 'jobPostUpdateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Job published successfully`
  String get jobPostPublishSuccess {
    return Intl.message(
      'Job published successfully',
      name: 'jobPostPublishSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Error saving data: {error}`
  String jobPostSaveError(Object error) {
    return Intl.message(
      'Error saving data: $error',
      name: 'jobPostSaveError',
      desc: '',
      args: [error],
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

  /// `Employer Login`
  String get employerCompanyLoginTitle {
    return Intl.message(
      'Employer Login',
      name: 'employerCompanyLoginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifTitle {
    return Intl.message(
      'Notifications',
      name: 'notifTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please sign in to view notifications.`
  String get notifLoginRequired {
    return Intl.message(
      'Please sign in to view notifications.',
      name: 'notifLoginRequired',
      desc: '',
      args: [],
    );
  }

  /// `Error: {error}`
  String notifError(String error) {
    return Intl.message(
      'Error: $error',
      name: 'notifError',
      desc: '',
      args: [error],
    );
  }

  /// `No notifications yet`
  String get notifEmpty {
    return Intl.message(
      'No notifications yet',
      name: 'notifEmpty',
      desc: '',
      args: [],
    );
  }

  /// `New application`
  String get notifNewApplication {
    return Intl.message(
      'New application',
      name: 'notifNewApplication',
      desc: '',
      args: [],
    );
  }

  /// `Untitled job`
  String get notifUntitledJob {
    return Intl.message(
      'Untitled job',
      name: 'notifUntitledJob',
      desc: '',
      args: [],
    );
  }

  /// `Application not found`
  String get notifApplicantNotFound {
    return Intl.message(
      'Application not found',
      name: 'notifApplicantNotFound',
      desc: '',
      args: [],
    );
  }

  /// `No saved resume for this applicant.`
  String get notifCvMissing {
    return Intl.message(
      'No saved resume for this applicant.',
      name: 'notifCvMissing',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get notifAccept {
    return Intl.message('Accept', name: 'notifAccept', desc: '', args: []);
  }

  /// `Reject`
  String get notifReject {
    return Intl.message('Reject', name: 'notifReject', desc: '', args: []);
  }

  /// `Application accepted successfully`
  String get notifSuccessAccept {
    return Intl.message(
      'Application accepted successfully',
      name: 'notifSuccessAccept',
      desc: '',
      args: [],
    );
  }

  /// `Application rejected successfully`
  String get notifSuccessReject {
    return Intl.message(
      'Application rejected successfully',
      name: 'notifSuccessReject',
      desc: '',
      args: [],
    );
  }

  /// `Copy link`
  String get notifCopyCv {
    return Intl.message('Copy link', name: 'notifCopyCv', desc: '', args: []);
  }

  /// `Open file`
  String get notifOpenCv {
    return Intl.message('Open file', name: 'notifOpenCv', desc: '', args: []);
  }

  /// `Phone`
  String get notifPhone {
    return Intl.message('Phone', name: 'notifPhone', desc: '', args: []);
  }

  /// `Email`
  String get notifEmail {
    return Intl.message('Email', name: 'notifEmail', desc: '', args: []);
  }

  /// `Job title (Arabic)`
  String get postJobTitleArLabel {
    return Intl.message(
      'Job title (Arabic)',
      name: 'postJobTitleArLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter the Arabic job title`
  String get postJobTitleArHint {
    return Intl.message(
      'Enter the Arabic job title',
      name: 'postJobTitleArHint',
      desc: '',
      args: [],
    );
  }

  /// `Job title (English)`
  String get postJobTitleEnLabel {
    return Intl.message(
      'Job title (English)',
      name: 'postJobTitleEnLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter the English job title`
  String get postJobTitleEnHint {
    return Intl.message(
      'Enter the English job title',
      name: 'postJobTitleEnHint',
      desc: '',
      args: [],
    );
  }

  /// `Education level`
  String get postJobEducationLabel {
    return Intl.message(
      'Education level',
      name: 'postJobEducationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Department`
  String get postJobDepartmentLabel {
    return Intl.message(
      'Department',
      name: 'postJobDepartmentLabel',
      desc: '',
      args: [],
    );
  }

  /// `Years of experience`
  String get postJobExperienceLabel {
    return Intl.message(
      'Years of experience',
      name: 'postJobExperienceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter years of experience`
  String get postJobExperienceHint {
    return Intl.message(
      'Enter years of experience',
      name: 'postJobExperienceHint',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get postJobCityLabel {
    return Intl.message('City', name: 'postJobCityLabel', desc: '', args: []);
  }

  /// `Company location`
  String get postJobCompanyLocationLabel {
    return Intl.message(
      'Company location',
      name: 'postJobCompanyLocationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter company location`
  String get postJobCompanyLocationHint {
    return Intl.message(
      'Enter company location',
      name: 'postJobCompanyLocationHint',
      desc: '',
      args: [],
    );
  }

  /// `Listed salary`
  String get postJobSalaryTitle {
    return Intl.message(
      'Listed salary',
      name: 'postJobSalaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get postJobSalaryYes {
    return Intl.message('Yes', name: 'postJobSalaryYes', desc: '', args: []);
  }

  /// `Not specified`
  String get postJobSalaryNo {
    return Intl.message(
      'Not specified',
      name: 'postJobSalaryNo',
      desc: '',
      args: [],
    );
  }

  /// `Salary from`
  String get postJobSalaryFrom {
    return Intl.message(
      'Salary from',
      name: 'postJobSalaryFrom',
      desc: '',
      args: [],
    );
  }

  /// `Salary to`
  String get postJobSalaryTo {
    return Intl.message(
      'Salary to',
      name: 'postJobSalaryTo',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get postJobSalaryHintFrom {
    return Intl.message(
      'From',
      name: 'postJobSalaryHintFrom',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get postJobSalaryHintTo {
    return Intl.message('To', name: 'postJobSalaryHintTo', desc: '', args: []);
  }

  /// `Currency`
  String get postJobCurrency {
    return Intl.message(
      'Currency',
      name: 'postJobCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Description language`
  String get postJobDescriptionLanguage {
    return Intl.message(
      'Description language',
      name: 'postJobDescriptionLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Job description`
  String get postJobDescriptionLabel {
    return Intl.message(
      'Job description',
      name: 'postJobDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Write the job objective`
  String get postJobDescriptionHint {
    return Intl.message(
      'Write the job objective',
      name: 'postJobDescriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Personal skills`
  String get postJobSkillsTitle {
    return Intl.message(
      'Personal skills',
      name: 'postJobSkillsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select a skill`
  String get postJobSkillSelect {
    return Intl.message(
      'Select a skill',
      name: 'postJobSkillSelect',
      desc: '',
      args: [],
    );
  }

  /// `Add a custom skill`
  String get postJobSkillCustomLabel {
    return Intl.message(
      'Add a custom skill',
      name: 'postJobSkillCustomLabel',
      desc: '',
      args: [],
    );
  }

  /// `Type the skill then tap add`
  String get postJobSkillCustomHint {
    return Intl.message(
      'Type the skill then tap add',
      name: 'postJobSkillCustomHint',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get postJobAdd {
    return Intl.message('Add', name: 'postJobAdd', desc: '', args: []);
  }

  /// `Application deadline`
  String get postJobDeadlineLabel {
    return Intl.message(
      'Application deadline',
      name: 'postJobDeadlineLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pick the application end date`
  String get postJobDeadlineHint {
    return Intl.message(
      'Pick the application end date',
      name: 'postJobDeadlineHint',
      desc: '',
      args: [],
    );
  }

  /// `Ad image`
  String get postJobImageLabel {
    return Intl.message(
      'Ad image',
      name: 'postJobImageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Application methods`
  String get postJobApplyMethods {
    return Intl.message(
      'Application methods',
      name: 'postJobApplyMethods',
      desc: '',
      args: [],
    );
  }

  /// `Apply via email`
  String get postJobApplyEmail {
    return Intl.message(
      'Apply via email',
      name: 'postJobApplyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Apply via phone`
  String get postJobApplyPhone {
    return Intl.message(
      'Apply via phone',
      name: 'postJobApplyPhone',
      desc: '',
      args: [],
    );
  }

  /// `Apply with CV upload`
  String get postJobApplyCv {
    return Intl.message(
      'Apply with CV upload',
      name: 'postJobApplyCv',
      desc: '',
      args: [],
    );
  }

  /// `Highlight the job posting?`
  String get postJobHighlight {
    return Intl.message(
      'Highlight the job posting?',
      name: 'postJobHighlight',
      desc: '',
      args: [],
    );
  }

  /// `Show company info?`
  String get postJobShowCompany {
    return Intl.message(
      'Show company info?',
      name: 'postJobShowCompany',
      desc: '',
      args: [],
    );
  }

  /// `Enter the Arabic title`
  String get postJobErrorTitleRequired {
    return Intl.message(
      'Enter the Arabic title',
      name: 'postJobErrorTitleRequired',
      desc: '',
      args: [],
    );
  }

  /// `Select education level`
  String get postJobErrorEducation {
    return Intl.message(
      'Select education level',
      name: 'postJobErrorEducation',
      desc: '',
      args: [],
    );
  }

  /// `Select department`
  String get postJobErrorDepartment {
    return Intl.message(
      'Select department',
      name: 'postJobErrorDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Enter years of experience`
  String get postJobErrorExperience {
    return Intl.message(
      'Enter years of experience',
      name: 'postJobErrorExperience',
      desc: '',
      args: [],
    );
  }

  /// `Select city`
  String get postJobErrorCity {
    return Intl.message(
      'Select city',
      name: 'postJobErrorCity',
      desc: '',
      args: [],
    );
  }

  /// `Enter company location`
  String get postJobErrorCompanyLocation {
    return Intl.message(
      'Enter company location',
      name: 'postJobErrorCompanyLocation',
      desc: '',
      args: [],
    );
  }

  /// `Enter salary range`
  String get postJobErrorSalaryRange {
    return Intl.message(
      'Enter salary range',
      name: 'postJobErrorSalaryRange',
      desc: '',
      args: [],
    );
  }

  /// `Select currency`
  String get postJobErrorCurrency {
    return Intl.message(
      'Select currency',
      name: 'postJobErrorCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Select description language`
  String get postJobErrorDescriptionLang {
    return Intl.message(
      'Select description language',
      name: 'postJobErrorDescriptionLang',
      desc: '',
      args: [],
    );
  }

  /// `Enter job description`
  String get postJobErrorDescription {
    return Intl.message(
      'Enter job description',
      name: 'postJobErrorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Enter application deadline`
  String get postJobErrorDeadline {
    return Intl.message(
      'Enter application deadline',
      name: 'postJobErrorDeadline',
      desc: '',
      args: [],
    );
  }

  /// `Advertising services`
  String get servicesHeaderTitle {
    return Intl.message(
      'Advertising services',
      name: 'servicesHeaderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Promote your jobs with flexible plans tailored to your needs.`
  String get servicesHeaderSubtitle {
    return Intl.message(
      'Promote your jobs with flexible plans tailored to your needs.',
      name: 'servicesHeaderSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Ad services`
  String get servicesSectionTitle {
    return Intl.message(
      'Ad services',
      name: 'servicesSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Packages`
  String get servicesPackagesTitle {
    return Intl.message(
      'Packages',
      name: 'servicesPackagesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose this plan`
  String get servicesChoosePlan {
    return Intl.message(
      'Choose this plan',
      name: 'servicesChoosePlan',
      desc: '',
      args: [],
    );
  }

  /// `Fast posting`
  String get servicesInfo1Title {
    return Intl.message(
      'Fast posting',
      name: 'servicesInfo1Title',
      desc: '',
      args: [],
    );
  }

  /// `Reach candidates quickly with highlighted ads.`
  String get servicesInfo1Desc {
    return Intl.message(
      'Reach candidates quickly with highlighted ads.',
      name: 'servicesInfo1Desc',
      desc: '',
      args: [],
    );
  }

  /// `Wider reach`
  String get servicesInfo2Title {
    return Intl.message(
      'Wider reach',
      name: 'servicesInfo2Title',
      desc: '',
      args: [],
    );
  }

  /// `Boost visibility across categories and filters.`
  String get servicesInfo2Desc {
    return Intl.message(
      'Boost visibility across categories and filters.',
      name: 'servicesInfo2Desc',
      desc: '',
      args: [],
    );
  }

  /// `Brand presence`
  String get servicesInfo3Title {
    return Intl.message(
      'Brand presence',
      name: 'servicesInfo3Title',
      desc: '',
      args: [],
    );
  }

  /// `Showcase your company with richer visuals.`
  String get servicesInfo3Desc {
    return Intl.message(
      'Showcase your company with richer visuals.',
      name: 'servicesInfo3Desc',
      desc: '',
      args: [],
    );
  }

  /// `Plan 50 Dinar`
  String get servicesPkg50Title {
    return Intl.message(
      'Plan 50 Dinar',
      name: 'servicesPkg50Title',
      desc: '',
      args: [],
    );
  }

  /// `50 Dinar`
  String get servicesPkg50Price {
    return Intl.message(
      '50 Dinar',
      name: 'servicesPkg50Price',
      desc: '',
      args: [],
    );
  }

  /// `Listing visible for 7 days`
  String get servicesPerkVis7 {
    return Intl.message(
      'Listing visible for 7 days',
      name: 'servicesPerkVis7',
      desc: '',
      args: [],
    );
  }

  /// `20 resume views`
  String get servicesPerkResume20 {
    return Intl.message(
      '20 resume views',
      name: 'servicesPerkResume20',
      desc: '',
      args: [],
    );
  }

  /// `1 ad edit`
  String get servicesPerkEdits1 {
    return Intl.message(
      '1 ad edit',
      name: 'servicesPerkEdits1',
      desc: '',
      args: [],
    );
  }

  /// `Plan 100 Dinar`
  String get servicesPkg100Title {
    return Intl.message(
      'Plan 100 Dinar',
      name: 'servicesPkg100Title',
      desc: '',
      args: [],
    );
  }

  /// `100 Dinar`
  String get servicesPkg100Price {
    return Intl.message(
      '100 Dinar',
      name: 'servicesPkg100Price',
      desc: '',
      args: [],
    );
  }

  /// `3 job posts for 14 days`
  String get servicesPerkPosts3 {
    return Intl.message(
      '3 job posts for 14 days',
      name: 'servicesPerkPosts3',
      desc: '',
      args: [],
    );
  }

  /// `Featured + priority listing`
  String get servicesPerkFeatured3 {
    return Intl.message(
      'Featured + priority listing',
      name: 'servicesPerkFeatured3',
      desc: '',
      args: [],
    );
  }

  /// `25 resume views`
  String get servicesPerkResume25 {
    return Intl.message(
      '25 resume views',
      name: 'servicesPerkResume25',
      desc: '',
      args: [],
    );
  }

  /// `Plan 150 Dinar`
  String get servicesPkg150Title {
    return Intl.message(
      'Plan 150 Dinar',
      name: 'servicesPkg150Title',
      desc: '',
      args: [],
    );
  }

  /// `150 Dinar`
  String get servicesPkg150Price {
    return Intl.message(
      '150 Dinar',
      name: 'servicesPkg150Price',
      desc: '',
      args: [],
    );
  }

  /// `5 job posts for 21 days`
  String get servicesPerkPosts5 {
    return Intl.message(
      '5 job posts for 21 days',
      name: 'servicesPerkPosts5',
      desc: '',
      args: [],
    );
  }

  /// `Boosted placement`
  String get servicesPerkBoosted {
    return Intl.message(
      'Boosted placement',
      name: 'servicesPerkBoosted',
      desc: '',
      args: [],
    );
  }

  /// `Priority support`
  String get servicesPerkSupport {
    return Intl.message(
      'Priority support',
      name: 'servicesPerkSupport',
      desc: '',
      args: [],
    );
  }

  /// `Plan 200 Dinar`
  String get servicesPkg200Title {
    return Intl.message(
      'Plan 200 Dinar',
      name: 'servicesPkg200Title',
      desc: '',
      args: [],
    );
  }

  /// `200 Dinar`
  String get servicesPkg200Price {
    return Intl.message(
      '200 Dinar',
      name: 'servicesPkg200Price',
      desc: '',
      args: [],
    );
  }

  /// `8 job posts per month`
  String get servicesPerkPosts8 {
    return Intl.message(
      '8 job posts per month',
      name: 'servicesPerkPosts8',
      desc: '',
      args: [],
    );
  }

  /// `Featured + boosted ads`
  String get servicesPerkFeaturedBoost {
    return Intl.message(
      'Featured + boosted ads',
      name: 'servicesPerkFeaturedBoost',
      desc: '',
      args: [],
    );
  }

  /// `Extra resume views`
  String get servicesPerkResumeViews {
    return Intl.message(
      'Extra resume views',
      name: 'servicesPerkResumeViews',
      desc: '',
      args: [],
    );
  }

  /// `Plan 250 Dinar`
  String get servicesPkg250Title {
    return Intl.message(
      'Plan 250 Dinar',
      name: 'servicesPkg250Title',
      desc: '',
      args: [],
    );
  }

  /// `250 Dinar`
  String get servicesPkg250Price {
    return Intl.message(
      '250 Dinar',
      name: 'servicesPkg250Price',
      desc: '',
      args: [],
    );
  }

  /// `12 job posts per month`
  String get servicesPerkPosts12 {
    return Intl.message(
      '12 job posts per month',
      name: 'servicesPerkPosts12',
      desc: '',
      args: [],
    );
  }

  /// `Dedicated account manager`
  String get servicesPerkDedicatedMgr {
    return Intl.message(
      'Dedicated account manager',
      name: 'servicesPerkDedicatedMgr',
      desc: '',
      args: [],
    );
  }

  /// `VIP placement`
  String get servicesPerkVip {
    return Intl.message(
      'VIP placement',
      name: 'servicesPerkVip',
      desc: '',
      args: [],
    );
  }

  /// `About Mhnty`
  String get aboutHeaderTitle {
    return Intl.message(
      'About Mhnty',
      name: 'aboutHeaderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Connecting employers and job seekers with a clear, modern hiring experience.`
  String get aboutHeaderSubtitle {
    return Intl.message(
      'Connecting employers and job seekers with a clear, modern hiring experience.',
      name: 'aboutHeaderSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Who we are`
  String get aboutWhoTitle {
    return Intl.message(
      'Who we are',
      name: 'aboutWhoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Our mission`
  String get aboutMissionTitle {
    return Intl.message(
      'Our mission',
      name: 'aboutMissionTitle',
      desc: '',
      args: [],
    );
  }

  /// `We connect employers with top talent and help job seekers reach the right opportunity quickly and confidently.`
  String get aboutMissionDesc {
    return Intl.message(
      'We connect employers with top talent and help job seekers reach the right opportunity quickly and confidently.',
      name: 'aboutMissionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Our vision`
  String get aboutVisionTitle {
    return Intl.message(
      'Our vision',
      name: 'aboutVisionTitle',
      desc: '',
      args: [],
    );
  }

  /// `A modern Arabic hiring platform that supports smart recruitment and provides a smooth experience for companies and candidates.`
  String get aboutVisionDesc {
    return Intl.message(
      'A modern Arabic hiring platform that supports smart recruitment and provides a smooth experience for companies and candidates.',
      name: 'aboutVisionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Our values`
  String get aboutValuesTitle {
    return Intl.message(
      'Our values',
      name: 'aboutValuesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Transparency, speed, and quality. We care about user experience and keep posting and applying simple and clear.`
  String get aboutValuesDesc {
    return Intl.message(
      'Transparency, speed, and quality. We care about user experience and keep posting and applying simple and clear.',
      name: 'aboutValuesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Why Mhnty?`
  String get aboutWhyTitle {
    return Intl.message(
      'Why Mhnty?',
      name: 'aboutWhyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Accurate job postings`
  String get aboutWhyPoint1 {
    return Intl.message(
      'Accurate job postings',
      name: 'aboutWhyPoint1',
      desc: '',
      args: [],
    );
  }

  /// `Easy Arabic interface`
  String get aboutWhyPoint2 {
    return Intl.message(
      'Easy Arabic interface',
      name: 'aboutWhyPoint2',
      desc: '',
      args: [],
    );
  }

  /// `Fast, clear support`
  String get aboutWhyPoint3 {
    return Intl.message(
      'Fast, clear support',
      name: 'aboutWhyPoint3',
      desc: '',
      args: [],
    );
  }

  /// `Flexible posting options`
  String get aboutWhyPoint4 {
    return Intl.message(
      'Flexible posting options',
      name: 'aboutWhyPoint4',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contactHeaderTitle {
    return Intl.message(
      'Contact us',
      name: 'contactHeaderTitle',
      desc: '',
      args: [],
    );
  }

  /// `We are here to support your hiring journey.`
  String get contactHeaderSubtitle {
    return Intl.message(
      'We are here to support your hiring journey.',
      name: 'contactHeaderSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Contact details`
  String get contactSectionContact {
    return Intl.message(
      'Contact details',
      name: 'contactSectionContact',
      desc: '',
      args: [],
    );
  }

  /// `Support email`
  String get contactEmailTitle {
    return Intl.message(
      'Support email',
      name: 'contactEmailTitle',
      desc: '',
      args: [],
    );
  }

  /// `support@mhnty.com`
  String get contactEmailValue {
    return Intl.message(
      'support@mhnty.com',
      name: 'contactEmailValue',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get contactPhoneTitle {
    return Intl.message('Phone', name: 'contactPhoneTitle', desc: '', args: []);
  }

  /// `+218 91 234 5678`
  String get contactPhoneValue {
    return Intl.message(
      '+218 91 234 5678',
      name: 'contactPhoneValue',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get contactAddressTitle {
    return Intl.message(
      'Address',
      name: 'contactAddressTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tripoli, Libya`
  String get contactAddressValue {
    return Intl.message(
      'Tripoli, Libya',
      name: 'contactAddressValue',
      desc: '',
      args: [],
    );
  }

  /// `Contact form`
  String get contactFormTitle {
    return Intl.message(
      'Contact form',
      name: 'contactFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get contactNameLabel {
    return Intl.message('Name', name: 'contactNameLabel', desc: '', args: []);
  }

  /// `Enter your name`
  String get contactNameHint {
    return Intl.message(
      'Enter your name',
      name: 'contactNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get contactEmailLabel {
    return Intl.message('Email', name: 'contactEmailLabel', desc: '', args: []);
  }

  /// `example@email.com`
  String get contactEmailHint {
    return Intl.message(
      'example@email.com',
      name: 'contactEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get contactSubjectLabel {
    return Intl.message(
      'Subject',
      name: 'contactSubjectLabel',
      desc: '',
      args: [],
    );
  }

  /// `What is your inquiry?`
  String get contactSubjectHint {
    return Intl.message(
      'What is your inquiry?',
      name: 'contactSubjectHint',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get contactMessageLabel {
    return Intl.message(
      'Message',
      name: 'contactMessageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Write your message here...`
  String get contactMessageHint {
    return Intl.message(
      'Write your message here...',
      name: 'contactMessageHint',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get contactSendButton {
    return Intl.message('Send', name: 'contactSendButton', desc: '', args: []);
  }

  /// `Working hours`
  String get contactScheduleTitle {
    return Intl.message(
      'Working hours',
      name: 'contactScheduleTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sunday - Thursday`
  String get contactWorkdaysTitle {
    return Intl.message(
      'Sunday - Thursday',
      name: 'contactWorkdaysTitle',
      desc: '',
      args: [],
    );
  }

  /// `9:00 AM - 6:00 PM`
  String get contactWorkdaysTime {
    return Intl.message(
      '9:00 AM - 6:00 PM',
      name: 'contactWorkdaysTime',
      desc: '',
      args: [],
    );
  }

  /// `Friday - Saturday`
  String get contactWeekendTitle {
    return Intl.message(
      'Friday - Saturday',
      name: 'contactWeekendTitle',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get contactWeekendTime {
    return Intl.message(
      'Closed',
      name: 'contactWeekendTime',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyHeaderTitle {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyHeaderTitle',
      desc: '',
      args: [],
    );
  }

  /// `We explain how we keep your data safe inside Mhnty.`
  String get privacyHeaderSubtitle {
    return Intl.message(
      'We explain how we keep your data safe inside Mhnty.',
      name: 'privacyHeaderSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyIntroTitle {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyIntroTitle',
      desc: '',
      args: [],
    );
  }

  /// `Data protection`
  String get privacyDataTitle {
    return Intl.message(
      'Data protection',
      name: 'privacyDataTitle',
      desc: '',
      args: [],
    );
  }

  /// `We protect your personal information and only ask for what we need to serve you.`
  String get privacyDataDesc {
    return Intl.message(
      'We protect your personal information and only ask for what we need to serve you.',
      name: 'privacyDataDesc',
      desc: '',
      args: [],
    );
  }

  /// `Verification & security`
  String get privacySecurityTitle {
    return Intl.message(
      'Verification & security',
      name: 'privacySecurityTitle',
      desc: '',
      args: [],
    );
  }

  /// `We verify accounts and use secure channels to protect your data during transfer and storage.`
  String get privacySecurityDesc {
    return Intl.message(
      'We verify accounts and use secure channels to protect your data during transfer and storage.',
      name: 'privacySecurityDesc',
      desc: '',
      args: [],
    );
  }

  /// `Data retention`
  String get privacyRetentionTitle {
    return Intl.message(
      'Data retention',
      name: 'privacyRetentionTitle',
      desc: '',
      args: [],
    );
  }

  /// `We keep data only as long as needed for hiring and comply with requests to delete it.`
  String get privacyRetentionDesc {
    return Intl.message(
      'We keep data only as long as needed for hiring and comply with requests to delete it.',
      name: 'privacyRetentionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Principles`
  String get privacyPrinciplesTitle {
    return Intl.message(
      'Principles',
      name: 'privacyPrinciplesTitle',
      desc: '',
      args: [],
    );
  }

  /// `We never sell your data`
  String get privacyPrinciple1 {
    return Intl.message(
      'We never sell your data',
      name: 'privacyPrinciple1',
      desc: '',
      args: [],
    );
  }

  /// `You can request deletion`
  String get privacyPrinciple2 {
    return Intl.message(
      'You can request deletion',
      name: 'privacyPrinciple2',
      desc: '',
      args: [],
    );
  }

  /// `We respect message privacy`
  String get privacyPrinciple3 {
    return Intl.message(
      'We respect message privacy',
      name: 'privacyPrinciple3',
      desc: '',
      args: [],
    );
  }

  /// `Transparent permissions`
  String get privacyPrinciple4 {
    return Intl.message(
      'Transparent permissions',
      name: 'privacyPrinciple4',
      desc: '',
      args: [],
    );
  }

  /// `How we use data`
  String get privacyUseTitle {
    return Intl.message(
      'How we use data',
      name: 'privacyUseTitle',
      desc: '',
      args: [],
    );
  }

  /// `Improve matching between jobs and applicants.`
  String get privacyUseItem1 {
    return Intl.message(
      'Improve matching between jobs and applicants.',
      name: 'privacyUseItem1',
      desc: '',
      args: [],
    );
  }

  /// `Send important updates about applications.`
  String get privacyUseItem2 {
    return Intl.message(
      'Send important updates about applications.',
      name: 'privacyUseItem2',
      desc: '',
      args: [],
    );
  }

  /// `Detect abuse and keep the platform safe.`
  String get privacyUseItem3 {
    return Intl.message(
      'Detect abuse and keep the platform safe.',
      name: 'privacyUseItem3',
      desc: '',
      args: [],
    );
  }

  /// `What we don’t do`
  String get privacyNotTitle {
    return Intl.message(
      'What we don’t do',
      name: 'privacyNotTitle',
      desc: '',
      args: [],
    );
  }

  /// `No hidden sharing with third parties.`
  String get privacyNotItem1 {
    return Intl.message(
      'No hidden sharing with third parties.',
      name: 'privacyNotItem1',
      desc: '',
      args: [],
    );
  }

  /// `No marketing spam without consent.`
  String get privacyNotItem2 {
    return Intl.message(
      'No marketing spam without consent.',
      name: 'privacyNotItem2',
      desc: '',
      args: [],
    );
  }

  /// `No access to private files without permission.`
  String get privacyNotItem3 {
    return Intl.message(
      'No access to private files without permission.',
      name: 'privacyNotItem3',
      desc: '',
      args: [],
    );
  }

  /// `Need help?`
  String get privacyActionTitle {
    return Intl.message(
      'Need help?',
      name: 'privacyActionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Contact us via the support form or email. We respond as soon as possible.`
  String get privacyActionDesc {
    return Intl.message(
      'Contact us via the support form or email. We respond as soon as possible.',
      name: 'privacyActionDesc',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get privacyActionButton {
    return Intl.message(
      'Close',
      name: 'privacyActionButton',
      desc: '',
      args: [],
    );
  }

  /// `Enter your company credentials to access the dashboard.`
  String get employerLoginIntro {
    return Intl.message(
      'Enter your company credentials to access the dashboard.',
      name: 'employerLoginIntro',
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
