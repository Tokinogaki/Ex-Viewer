String mapToQueryString(Map params) {
  if (params == null || params.isEmpty) return '';

  var paramsString = '?';
  params.forEach((k, v) => paramsString += '$k=$v&');

  return paramsString;
}
