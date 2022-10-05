require 'amatch'
require 'string-similarity'
require 'trigram'

module ComparisonAlgorithm
  ROUND = 3
  module Cosine
    def self.similarity(word_a, word_b)
      String::Similarity.cosine(word_a, word_b).round(ROUND)
    end
  end

  module Levenshtein
    def self.similarity(word_a, word_b)
      String::Similarity.levenshtein(word_a, word_b).round(ROUND)
    end
  end

  module Trigrams
    def self.similarity(word_a, word_b)
      Trigram.compare(word_a, word_b).round(ROUND)
    end
  end

  module JaroWinkler
    def self.similarity(word_a, word_b)
      word_a.jarowinkler_similar(word_b).round(ROUND)
    end
  end

  module FuzzyScore
    def self.similarity(word_a, word_b)
      a = word_a.downcase
      b = word_b.downcase
      score = 0
      termIndex = 0
      previousMatchingCharacterIndex = -1
      b.split("").each do |queryChar|
        termCharacterMatchFound = false
        while termIndex < a.length && !termCharacterMatchFound
          termChar = a[termIndex]
          if queryChar == termChar
            score = score + 1
            if previousMatchingCharacterIndex+1 == termIndex
              score = score + 2
            end
            previousMatchingCharacterIndex = termIndex
            termCharacterMatchFound = true
          end

          termIndex = termIndex + 1
        end
      end

      (score*2.0/(b.length+a.length)).round(3)
    end
  end
end
