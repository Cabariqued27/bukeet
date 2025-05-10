class RegexPattern {
  static const String emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String passwordRegex =
      r'^(?=.*[!@#\$&*~.\-])[A-Za-z\d!@#\$&*~.\-]{8,12}$';
  static const String nameRegex =
      r'^(?=.*[A-Za-zÁÉÍÓÚÑáéíóúñ])[A-Za-zÁÉÍÓÚÑáéíóúñ\s]+$';

  static const String fullNameRegex =
      r'^[A-Za-zÁÉÍÓÚÑáéíóúñ]+ [A-Za-zÁÉÍÓÚÑáéíóúñ]+$';
}
