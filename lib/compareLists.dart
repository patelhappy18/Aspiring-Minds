bool compareLists(List<dynamic> listA, List<dynamic> listB) {
  // Sort both lists
  listA.sort();
  listB.sort();

  // Check if all elements of listB are present in listA
  for (String element in listB) {
    if (!listA.contains(element)) {
      return false;
    }
  }

  return true;
}
