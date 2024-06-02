Map<K, V> sortMapByKeys<K extends Comparable<K>, V>(Map<K, V> map) {
  var sortedEntries = map.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

  return Map.fromEntries(sortedEntries);
}

/*
  * HOW TO USE IT
  * var sortedMap = sortMapByKeys(map);
*/