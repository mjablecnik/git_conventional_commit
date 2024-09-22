enum CommitType {
  // Add improvements
  ux("Improve user experience or interface"),
  feat("Add new feature"),
  docs("Update or add documentation"),
  i18n("Add or update translations or internationalization files"),

  // Code refactor
  perf("Improve performance"),
  style("Code style changes (formatting, missing semicolons, etc.)"),
  refactor("Refactor code without changing functionality"),

  // Testing
  test("Add or update tests"),
  mock("Add or update mock data for testing purposes"),

  // Bug fix
  fix("Fix bug"),
  hotfix("Apply a critical bug fix or patch"),
  security("Implement or fix security-related features or issues"),

  // Project configuration
  ci("Changes to CI configuration or scripts"),
  env("Changes to environment configurations"),
  dep("Add, remove, or update project dependencies"),
  config("Modify configuration files or settings"),
  lint("Fix or configure code linting issues"),
  legal("Update legal documents or licenses"),
  build("Changes to the build system or external dependencies"),
  chore("Maintenance tasks that don't modify src, lib or test files"),

  // Project development
  wip("Work in Progress"),
  temp("Temporary changes"),
  merge("Merge branches"),
  revert("Revert a previous commit"),
  ;
  const CommitType(this.description);

  final String description;
}
