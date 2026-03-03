class Validators {

  // ================= USERNAME VALIDATION =================
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Username is required";
    }

    if (value.trim().length < 3) {
      return "Username must be at least 3 characters";
    }

    return null;
  }

  // ================= EMAIL VALIDATION (Optional) =================
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex =
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return "Invalid email format";
    }

    return null;
  }

  // ================= PASSWORD VALIDATION =================
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }

  // ================= CONFIRM PASSWORD VALIDATION =================
  static String? validateConfirmPassword(
      String? password,
      String? confirmPassword,
      ) {

    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Please confirm your password";
    }

    if (password != confirmPassword) {
      return "Passwords do not match";
    }

    return null;
  }
}