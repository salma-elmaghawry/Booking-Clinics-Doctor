class Routes {
  // ! _____ App Routes _____ ! //
  static const onboardingRoute = "/";
  static const activateRoute = "/activate";
  static const navRoute = "/home";
  static const signup = "/signUp";
  static const signin = "/signin";
  static const onboarding = "/onboarding";
  static const forgetPassword = "/forgetPassword";
  static const editYourProfile = "/editYourProfile";
  static const doctorDetailsRoute = "/doctorDetailsRoute";
  static const userBookingsRoute = "/userBookingsRoute";
  static const profileScreenRoute = "/profileScreenRoute";
  static const seeAll = "/seeAll";
  static const chatDetailsRoute = "/chatDetailsRoute";
}

class ConstString {
  // ! _____ Firebase Queries & Params _____ ! //
  static const userCont = "USER_CONTAINER_NAME";
  static const doctorsCollection = "doctors";
  static const patientsCollection = "patients";

  // ! _____ Text _____ ! //
  static const aboutMeFakeText =
      "Dr. David Patel, a dedicated cardiologist, brings a wealth of experience to Golden Gate Cardiology Center in Golden Gate, CA.";
  static const workingTimeFakeText = "Monday - Friday, 9:00 AM - 7:00 PM";
  static const reviewFakeText =
      'Dr. Patel is a true professional who genuinely cares about his patients. I highly recommend Dr. Patel to anyone seeking exceptional cardiac care.';
  static const bookAppointment = 'Book Appointment';
  static const List<String> specialties = [
    "Dentistry",
    "Cardiologist",
    "Dermatology",
    "Pediatrics",
    "Orthopedics",
    "Neurology",
    "Psychiatry",
  ];
}
