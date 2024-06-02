Map<String, List<T>> groupByFirstLetter<T>(
    List<T> items, String Function(T) getKey) {
  var groupedItems = <String, List<T>>{};

  for (var item in items) {
    var key = getKey(item);

    if (!groupedItems.containsKey(key)) {
      groupedItems[key] = [];
    }

    groupedItems[key]!.add(item);
  }

  return groupedItems;
}

/*
  * HOW TO USE IT
  * var groupedNames = groupByFirstLetter(names, (name) => name[0].toUpperCase());
*/
