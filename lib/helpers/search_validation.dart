bool isValidSearchData(String search) {
  // Check if the search data is empty
  if (search.isEmpty) {
    return false;
  }

  // Check if the search data contains only alphanumeric characters
  final alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
  if (!alphanumericRegex.hasMatch(search)) {
    return false;
  }

  return true;
}
