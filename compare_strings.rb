require 'terminal-table'
require_relative 'comparison_algorithm'

words_list = [
  { word_a: 'iZ *Lomi Boutique', word_b: 'Cafe Lomi'},
  { word_b: 'iZ *Lomi Boutique', word_a: 'Cafe Lomi'},
]

table = Terminal::Table.new(headings: ['Word A', 'Word B', 'Cosine', 'Levenshtein', 'Trigram', 'Jaro-Winkler', 'FuzzyScore'])

words_list.each do |words|
  word_a = words[:word_a]
  word_b = words[:word_b]
  table.add_row([
    word_a,
    word_b,
    ComparisonAlgorithm::Cosine.similarity(word_a.downcase, word_b.downcase),
    ComparisonAlgorithm::Levenshtein.similarity(word_a.downcase, word_b.downcase),
    ComparisonAlgorithm::Trigrams.similarity(word_a.downcase, word_b.downcase),
    ComparisonAlgorithm::JaroWinkler.similarity(word_a.downcase, word_b.downcase),
    ComparisonAlgorithm::FuzzyScore.similarity(word_a.downcase, word_b.downcase)
  ])
end

puts table
