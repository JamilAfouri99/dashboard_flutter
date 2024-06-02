bool isValidSearchData(String search) {
  if (search.isEmpty)
    return true; // if we delete all search input, we should return all users

  // Check if the search data contains only alphanumeric characters
  final alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
  if (!alphanumericRegex.hasMatch(search)) {
    return false;
  }

  return true;
}
