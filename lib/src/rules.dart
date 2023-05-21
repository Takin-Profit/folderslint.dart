import 'dart:io';

String posixSeparatedCwd() {
  return Directory.current.path.replaceAll('\\', '/');
}

Map<String, dynamic> getExtendedRules(String root, List rules) {
  List<String> extendedRules = [...rules];
  for (var rule in rules) {
    var splittedRule = rule.split('/');
    String extendedRule = '';
    for (var rulePart in splittedRule) {
      extendedRule += (extendedRule.isNotEmpty ? '/' : '') + rulePart;
      if (!extendedRules.contains(extendedRule)) {
        extendedRules.add(extendedRule);
      }
    }
  }

  var hasRootConfigured = root.isNotEmpty && root != '.';
  var extendedRoot = '${posixSeparatedCwd()}${hasRootConfigured ? '/$root' : ''}';
  var extendedRulesWithRoot = extendedRules.map((rule) => (extendedRoot.isNotEmpty ? '$extendedRoot/' : '') + rule).toList();

  return {
    'root': extendedRoot,
    'rules': [...extendedRulesWithRoot, extendedRoot],
  };
}

bool isPathMatchRule(String path, String rule) {
  var splittedPath = path.split('/');
  var splittedRule = rule.split('/');

  var isValid = true;
  for (var i = 0; i < splittedPath.length; i++) {
    var pathPart = splittedPath[i];
    var rulePart = splittedRule.length > i ? splittedRule[i] : null;
    var isPermitted = rulePart != '*' && rulePart != '**' && rulePart != null ? pathPart == rulePart : true;
    isValid = isValid && isPermitted;
  }

  if (!isValid) {
    return false;
  }

  if (!rule.contains('**') && splittedPath.length > splittedRule.length) {
    return false;
  }

  return true;
}

bool checkPath(String path, List<String> rules) {
  var isPermitted = false;
  for (var rule in rules) {
    isPermitted = isPermitted || isPathMatchRule(path, rule);
  }
  return isPermitted;
}
