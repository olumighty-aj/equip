extension AddressParsing on String {
  String extractCountry() {
    // Regular expression for matching country
    RegExp countryRegExp = RegExp(r'(?<=,\s)([A-Za-z]+)$');

    // Match country
    Iterable<RegExpMatch> countryMatches = countryRegExp.allMatches(this);
    return countryMatches.isNotEmpty ? countryMatches.first.group(1)! : '';
  }

  // String extractState() {
  //   // Regular expression for matching state
  //   RegExp stateRegExp = RegExp(r'(?<=,\s)([A-Za-z]+),\s*[A-Za-z]+(?=,|$)');
  //
  //   // Match state
  //   Iterable<RegExpMatch> stateMatches = stateRegExp.allMatches(this);
  //   return stateMatches.isNotEmpty ? stateMatches.first.group(1)! : '';
  // }
  String extractState() {
    // Regular expression for matching state
    RegExp stateRegExp = RegExp(r'(?<=,\s)([A-Za-z\s]+),\s*[A-Za-z\s]+(?=,|$)');

    // Match state
    // Match state
    Iterable<RegExpMatch> stateMatches = stateRegExp.allMatches(this);
    if (stateMatches.isNotEmpty) {
      String state = stateMatches.first.group(1)!;

      // Check for specific state values and map them
      if (state == 'Federal Capital Territory') {
        return 'Abuja';
      } else {
        return state;
      }
    } else {
      return '';
    }
  }
}
