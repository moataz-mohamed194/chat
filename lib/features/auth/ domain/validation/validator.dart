class Validator {
  String? validatorEmail(val) {
    return val!.isEmpty || val.contains(RegExp(r"^\S+@\S+\.\S+$")) == false
        ? "must add valid email"
        : null;
  }

  String? validatorPassword(val) {
    return val!.isEmpty
        ? 'must add the password'
        : val.length < 8
            ? "the password must be more than 8 digits"
            : null;
  }

  String? validatorPhoneNumber(String val) {
    return val.isEmpty || val.contains(RegExp(r'^[0-9]{10}$')) == false
        ? "must add valid phone number"
        : null;
  }

  String? validatorName(val) {
    return (val.contains(RegExp(r'^\w+\s+\w+$')) == false || val.length <= 4)
        ? 'must add the first and last name'
        : null;
  }
}
