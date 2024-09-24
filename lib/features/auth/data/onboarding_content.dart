class OnboardingContent {
  String image;
  String title;
  String discription;

  OnboardingContent({ required this.image,required this.title,required this.discription});
}

List<OnboardingContent> contents = [
  OnboardingContent(
      title: 'Meet Doctors Online',
      image: 'assets/images/onboarding3.png',
      discription: "Connect with Specialized Doctors Online for ""Convenient and Comprehensive Medical"
          "Consultations."
  ),
  OnboardingContent(
      title: 'Connect with Specialists',
      image: 'assets/images/onboardingsec.png',
      discription: "Connect with Specialized Doctors Online for ""Convenient and Comprehensive Medical"
          "Consultations."

  ),
  OnboardingContent(
      title: 'Thousands of Online Specialists',
      image: 'assets/images/onboarding3.png',
      discription: "Connect with Specialized Doctors Online for ""Convenient and Comprehensive Medical"
          "Consultations."
  ),
];