class RegisterValidator {
  static String? validateUsername(String username) {
    if (username.isEmpty) {
      return 'El nombre de usuario es requerido';
    }
    return null;
  }

  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'El correo es requerido';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      return 'Introduce un correo válido';
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (password.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }

    final specialCharacterRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (!specialCharacterRegex.hasMatch(password)) {
      return 'La contraseña debe contener al menos un carácter especial';
    }

    return null;
  }

  static String? validateConfirmPassword(
      String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Confirma tu contraseña';
    }
    if (password != confirmPassword) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  static String? validateUserTypeId(int userTypeId) {
    if (userTypeId == 0) {
      return 'El rol es requerido';
    }
    return null;
  }
}
