String formatPhoneNumber(String phoneNumber) {
  // Remove all non-digit characters from the phone number
  final digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

  // Check if the phone number has enough digits
  if (digitsOnly.length < 10) {
    return phoneNumber; // Return the original number if it's invalid
  }

  // Extract the country code, area code, and local number
  final countryCode = digitsOnly.substring(0, 3);
  final areaCode = digitsOnly.substring(3, 6);
  final localNumber = digitsOnly.substring(6);

  // Construct the formatted phone number
  final formattedNumber =
      '$countryCode $areaCode ${localNumber.substring(0, 4)} ${localNumber.substring(4)}';

  return formattedNumber;
}
