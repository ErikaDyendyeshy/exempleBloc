final List<LanguageModel> languages = [
  LanguageModel("English", "en"),
];

class LanguageModel {
  LanguageModel(
    this.language,
    this.symbol,
  );

  String language;
  String symbol;
}
