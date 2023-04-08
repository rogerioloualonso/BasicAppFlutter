class Utils {
  static validarCEP(String cep) {
    String digitos = cep.replaceAll(RegExp('[^0-9]'), '');

    if (cep == null) {
      return false;
    } else if (digitos.length != 8) {
      return false;
    } else {
      return true;
    }
  }
}
