class Validators {
  static String? notEmpty(String? v) {
    if (v == null || v.trim().isEmpty) return 'El campo no puede estar vacío';
    return null;
  }
}
