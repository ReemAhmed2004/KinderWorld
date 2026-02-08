import 'package:flutter/material.dart';
import 'l10n/app_localizations_en.dart';
import 'l10n/app_localizations_ar.dart';

abstract class AppLocalizations {
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Common
  String get appTitle;
  String get welcome;
  String get next;
  String get back;
  String get continueText;
  String get skip;
  String get done;
  String get cancel;
  String get save;
  String get delete;
  String get edit;
  String get loading;
  String get error;
  String get connectionError;
  String get success;
  String get retry;
  String get noInternet;
  String get offlineMode;

  // Authentication
  String get login;
  String get register;
  String get email;
  String get parentEmail;
  String get password;
  String get confirmPassword;
  String get forgotPassword;
  String get parentLogin;
  String get childLogin;
  String get childId;
  String get picturePassword;
  String get selectPicturePassword;
  String get confirmPicturePassword;
  String get picturePasswordError;
  String get loginError;
  String get registerError;

  // ✅ Child Login Screen (NEW)
  String get chooseProfileToContinue;
  String get chooseYourProfile;
  String get clearSelection;
  String get goBack;
  String get noChildProfilesFound;
  String get childProfileNotFound;
  String get failedToStartSession;
  String get incorrectPicturePassword;
  String get childLoginNotFound;
  String get childLoginIncorrectPictures;
  String get childLoginMissingData;
  String get createChildProfile;
  String get childRegisterParentNotFound;
  String get childRegisterLimitReached;
  String get childRegisterForbidden;
  String get paywallTitle;
  String get paywallPrice;
  String get paywallSubscribe;
  String get paywallManagePaymentMethods;
  String get paymentMethodsTitle;
  String get paymentMethodsEmpty;
  String get noNotifications;
  String get addPaymentMethod;
  String get removePaymentMethod;
  String get openPaymentPortal;

  // ✅ parameterized strings (NEW)
  String yearsOld(int age);
  String levelXp(int level, int xp);

  // User Types
  String get selectUserType;
  String get selectUserTypeSubtitle;
  String get childMode;
  String get parentMode;
  String get teacherMode;
  String get parentModeDescription;
  String get childModeDescription;

  // Child Mode
  String get home;
  String get learn;
  String get play;
  String get aiBuddy;
  String get profile;
  String get hello;
  String get dailyGoal;
  String get continueLearning;
  String get recommendedForYou;
  String get activityOfTheDay;
  String get moodIndicator;
  String get happy;
  String get sad;
  String get excited;
  String get tired;
  String get angry;
  String get calm;

  // Learning
  String get educationalContent;
  String get behavioralSkills;
  String get skillfulActivities;
  String get subjects;
  String get mathematics;
  String get science;
  String get reading;
  String get history;
  String get geography;
  String get languages;
  String get socialStories;
  String get emotionCards;
  String get problemSolving;
  String get drawing;
  String get music;
  String get crafts;
  String get cooking;
  String get quiz;
  String get lesson;
  String get game;
  String get story;
  String get video;
  String get complete;
  String get start;

  // Learn Search & Labels
  String get searchPagesHint;
  String get learnExplorePrompt;
  String get noPagesFound;
  String get valuesLabel;
  String get methodsLabel;
  String get valueDetailsLabel;
  String get methodContentLabel;
  String get storiesLabel;
  String get gamesLabel;
  String get videosLabel;
  String get lessonsLabel;
  String get lessonDetailLabel;
  String get skillsLabel;
  String get skillDetailsLabel;
  String get skillVideoLabel;
  String get behavioralValuesLabel;
  String get behavioralMethodsLabel;
  String get songsAndMusic;
  String get cartoonsLabel;
  String get foundSomethingFun;
  String get puzzleGame;
  String get racingCars;
  String get memoryMatch;
  String get coloringFun;
  String get adventureTime;
  String get funnyAnimals;
  String get spaceHeroes;
  String get magicWorld;
  String get abcSong;
  String get babyShark;
  String get twinkleStar;
  String itemNumber(int number);

  // Behavioral Values & Methods
  String get valueGiving;
  String get valueRespect;
  String get valueTolerance;
  String get valueKindness;
  String get valueCooperation;
  String get valueResponsibility;
  String get valueHonesty;
  String get valuePatience;
  String get valueCourage;
  String get valueGratitude;
  String get valuePeace;
  String get valueLove;
  String get practiceKindnessPrompt;
  String get methodRelaxation;
  String get methodImagination;
  String get methodMeditation;
  String get methodArtExpression;
  String get methodSocialBonding;
  String get methodSelfDevelopment;
  String get methodSocialJusticeFocus;
  String get activityKindnessChallenge;
  String get activityRespectSharing;
  String get tryNewSkillPrompt;

  // Skillful Activities
  String get skillCooking;
  String get skillDrawing;
  String get skillColoring;
  String get skillMusic;
  String get skillSinging;
  String get skillHandcrafts;
  String get skillSports;
  String get skillCookingDesc;
  String get skillDrawingDesc;
  String get skillColoringDesc;
  String get skillMusicDesc;
  String get skillSingingDesc;
  String get skillHandcraftsDesc;
  String get skillSportsDesc;
  String get createSomethingFunPrompt;
  String get allLabel;
  String get beginnerLabel;
  String get intermediateLabel;
  String get advancedLabel;
  String skillBasicsTitle(String skillTitle);
  String skillFunTitle(String skillTitle);
  String skillAdvancedTitle(String skillTitle);
  String skillMasteringTitle(String skillTitle);
  String get searchActivitiesHint;
  String get noActivitiesFound;
  String get watchNow;
  String get letsCreate;
  String followStepsToCreate(String videoTitle);
  String get imDone;

  // Educational
  String get animalsLabel;
  String get plantsLabel;
  String get learnSomethingNewPrompt;
  String get searchLessonsHint;
  String get noLessonsFound;
  String get lessonIntroBasics;
  String get lessonAdvancedConcepts;
  String get lessonIntermediatePractice;
  String get lessonFunWithMath;
  String get lessonDeepDive;

  // Quiz
  String get readyForFunQuiz;
  String get playQuickQuizPrompt;
  String get startQuiz;
  String get quizQuestionSkyColor;
  String get quizOptionBlue;
  String get quizOptionGreen;
  String get quizOptionRed;
  String get quizOptionYellow;
  String get quizQuestionDogLegs;
  String get quizOptionTwo;
  String get quizOptionFour;
  String get quizOptionSix;
  String get quizOptionEight;
  String get quizQuestionFruit;
  String get quizOptionCarrot;
  String get quizOptionApple;
  String get quizOptionPotato;
  String get quizOptionOnion;
  String get quizGreatJob;
  String get quizCompleted;
  String get quizAwesome;
  String quizTitle(String lessonTitle);
  String get quizTime;
  String quizQuestionCount(int current, int total);
  String get nextQuestion;
  String get finish;

  // Entertainment
  String get entertainment;
  String get educationalGames;
  String get puppetShows;
  String get interactiveStories;
  String get miniChallenges;
  String get natureVideos;
  String get brainTeasers;
  String get cartoonMovies;
  String get songs;
  String get funnyClips;

  // AI Buddy
  String get askMeAnything;
  String get quickActions;
  String get recommendLesson;
  String get suggestGame;
  String get tellStory;
  String get funFact;
  String get motivation;
  String typeMessage(String name);
  String get voiceChat;
  String get textChat;
  String get aiThinking;
  String get aiError;

  // Progress & Rewards
  String get progress;
  String get xp;
  String get level;
  String get streak;
  String get achievements;
  String get badges;
  String get dailyStreak;
  String get weeklyProgress;
  String get monthlyProgress;

  // Parent Dashboard
  String get parentDashboard;
  String get overview;
  String get childProfiles;
  String get addChild;
  String get editChild;
  String get childName;
  String get childAge;
  String get childInterests;
  String get avatar;
  String get saveChanges;

  // Reports
  String get reports;
  String get activityReports;
  String get learningProgress;
  String get skillDevelopment;
  String get behavioralProgress;
  String get screenTimeReport;
  String get aiInsights;
  String get recentActivities;
  String get timeSpent;
  String get completedActivities;
  String get averageScore;
  String get strengths;
  String get areasForImprovement;

  // Parental Controls
  String get parentalControls;
  String get contentRestrictions;
  String get screenTime;
  String get dailyLimit;
  String get allowedHours;
  String get sleepMode;
  String get emergencyLock;
  String get contentFiltering;
  String get ageAppropriate;
  String get blockContent;
  String get allowContent;
  String get timeLimits;
  String get breakReminders;
  String get smartControl;
  String get aiRecommendations;

  // Settings
  String get settings;
  String get accountSection;
  String get familySection;
  String get preferencesSection;
  String get supportSection;
  String get legalSection;
  String get profileLabel;
  String get changePassword;
  String get helpFaq;
  String get about;
  String get coppaCompliance;
  String get logout;
  String comingSoon(String title);
  String get notifications;
  String get privacySettings;
  String get dataSharing;
  String get parentalConsent;
  String get accessibility;
  String get fontSize;
  String get contrast;
  String get language;
  String get english;
  String get arabic;
  String get theme;
  String get mode;
  String get systemMode;
  String get themePalette;
  String get themePaletteHint;
  String get lightMode;
  String get darkMode;
  String get eyeFriendlyMode;
  String get auto;
  String get sound;
  String get soundEffects;
  String get voiceGuidance;

  // General Labels
  String get week;
  String get month;
  String get year;
  String get yearlyProgress;
  String get recentAchievements;
  String get activityBreakdown;
  String get learningProgressReports;
  String get trackChildDevelopment;
  String get reportsAndAnalytics;
  String get noChildSelected;
  String get addChildToViewReports;

  // Parental Controls (extended)
  String get contentRestrictionsAndScreenTime;
  String get manageChildAccess;
  String get screenTimeLimits;
  String get timeRestrictions;
  String get emergencyControls;
  String get lockAppNow;
  String get hoursPerDay;
  String get requireApproval;
  String get bedtime;
  String get wakeTime;

  // Child Management (extended)
  String get childManagement;
  String get manageChildProfiles;
  String get addEditManageChildren;
  String get yourChildren;
  String get noChildProfilesYet;
  String get tapToAddChild;
  String get addChildProfiles;
  String get editProfiles;
  String get picturePasswords;
  String get configurePreferences;
  String get deactivateProfiles;
  String get childProfileAdded;
  String get childProfileAddFailed;

  // Notifications (extended)
  String get markAllRead;
  String notificationDailyGoal(String name, int activities);
  String notificationScreenTime(String name, int hours);
  String notificationAchievement(String name, String badge);
  String get notificationWeeklyReport;
  String notificationMilestone(String name, int count);
  String notificationRecommendation(String name);
  String get hoursAgo;
  String get daysAgo;
  String get justNow;

  // Welcome & Onboarding
  String get welcomeTitle;
  String get welcomeSubtitle;
  String get chooseLanguageTitle;
  String get chooseLanguageSubtitle;
  String get educational;
  String get funGames;
  String get aiPowered;
  String get safe;
  String get getStarted;
  String get coppaGdprNote;
  String get onboardingGrow;
  String get onboardingLearnSubtitle;
  String get onboardingLearnDescription;
  String get onboardingPlaySubtitle;
  String get onboardingPlayDescription;
  String get onboardingGrowSubtitle;
  String get onboardingGrowDescription;

  // Child Profile
  String get yourProgress;
  String get yourInterests;
  String get weeklyChallenge;
  String get activities;
  String levelExplorer(int level);
  String xpToLevel(int level);
  String helloName(String name);
  String get levelsTitle;
  String get levelJourneySubtitle;
  String get achievementFirstQuizTitle;
  String get achievementFirstQuizDescription;
  String get achievementFiveDayStreakTitle;
  String get achievementFiveDayStreakDescription;
  String get achievementMathMasterTitle;
  String get achievementMathMasterDescription;
  String get levelLockedMessage;
  String levelStartMessage(int level);

  // Child Settings & Profile Helpers
  String get searchSettingsHint;
  String get appSettingsSection;
  String get editProfile;
  String get changeAvatar;
  String get backgroundMusic;
  String get themes;
  String get lightAndCalm;
  String get aboutUs;
  String get noSettingsFound;
  String get selectLanguage;
  String languageChanged(String languageName);
  String get englishUs;
  String get chooseAvatar;
  String get avatarSaved;
  String get pleaseSelectThreePictures;
  String get failedToUpdatePicturePassword;
  String get profileUpdated;
  String get changeAvatarFromProfile;
  String get nameLabel;
  String get enterYourName;
  String get pleaseEnterName;
  String get chooseExactlyThreePictures;
  String get darkLight;
  String get chooseCalmColor;
  String get kinderWorldAppTitle;
  String versionLabel(String version);
  String get aboutAppDescription;
  String privacyLastUpdated(String date);
  String get privacyIntroTitle;
  String get privacyIntroBody;
  String get privacyDataCollectionTitle;
  String get privacyDataCollectionBody;
  String get privacySecurityTitle;
  String get privacySecurityBody;

  // Subscription
  String get subscription;
  String get freeTrial;
  String get familyPlan;
  String get premiumFeatures;
  String get upgradeNow;
  String get choosePlan;
  String get currentPlan;
  String get planFree;
  String get planPremium;
  String get planFamilyPlus;
  String get planFeatureInPremium;
  String planChildLimit(int count);
  String get planUnlimitedChildren;
  String get planBasicReports;
  String get planAdvancedReports;
  String get planAiInsightsPro;
  String get planOfflineDownloads;
  String get planSmartControls;
  String get planExclusiveContent;
  String get planFamilyDashboard;
  String get freePlanChildLimit;
  String get manageSubscription;
  String get paymentMethod;
  String get billingInfo;
  String get trialEnds;
  String get subscriptionActive;
  String get subscriptionExpired;

  // Safety & Privacy
  String get safety;
  String get privacy;
  String get termsOfService;
  String get privacyPolicy;
  String get childProtection;
  String get dataSecurity;
  String get parentalConsentRequired;
  String get minimalDataCollection;
  String get encryptedStorage;

  // Help & Support
  String get help;
  String get support;
  String get faq;
  String get contactUs;
  String get tutorial;
  String get walkthrough;
  String get feedback;

  // System Messages
  String get maintenanceMode;
  String get updateRequired;
  String get syncData;
  String get dataSyncComplete;
  String get sessionExpired;
  String get logoutConfirm;
  String get exitConfirm;
  String get deleteConfirm;
  String get deleteChildTitle;
  String get deleteChildDescription;
  String get deleteChildSuccess;
  String get deleteChildFailed;

  // Validation
  String get fieldRequired;
  String get invalidEmail;
  String get parentEmailNotFound;
  String get passwordTooShort;
  String get passwordsDontMatch;
  String get invalidAge;
  String get selectAvatar;

  // Accessibility
  String get increaseFontSize;
  String get decreaseFontSize;
  String get highContrast;
  String get screenReader;
  String get voiceCommands;
  String get switchAccess;

  // Parent Settings
  String get parentProfile;
  String get parentChangePassword;
  String get parentTheme;
  String get parentPrivacySettings;
  String get parentHelp;
  String get parentContactUs;
  String get parentAbout;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'ar':
        return AppLocalizationsAr();
      case 'en':
      default:
        return AppLocalizationsEn();
    }
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}
