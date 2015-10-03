#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer

  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(text_line, number)
    @line_number = number
    @content = text_line
    @highest_wf_count = 0
    @words_hash = Hash.new(0)
    @highest_wf_words = []
    calculate_word_frequency
  end

  def calculate_word_frequency
    content.downcase.split.each do |word|
      @words_hash[word] += 1
      @highest_wf_count = @words_hash[word] if @words_hash[word] > @highest_wf_count
    end
    @words_hash.each { |word, count|
      @highest_wf_words.push(word) if count == @highest_wf_count
    }
  end
end

#  Implement a class called Solution. 
class Solution

  attr_reader :highest_count_across_lines, :highest_count_words_across_lines, :analyzers

  def initialize
    @analyzers = []
    @highest_count_words_across_lines = nil
  end

  def analyze_file
    File.foreach('test.txt').each_with_index do |line, index|
      @analyzers[index] = LineAnalyzer.new(line, index)
    end
  end

  def calculate_line_with_highest_frequency
    @highest_count_words_across_lines ||= []
    @analyzers.each do |analyzer|
      @highest_count_across_lines ||= analyzer.highest_wf_count
      @highest_count_across_lines = analyzer.highest_wf_count if @highest_count_across_lines < analyzer.highest_wf_count
    end

    @analyzers.each do |analyzer|
      if analyzer.highest_wf_count == @highest_count_across_lines
        @highest_count_words_across_lines.push(analyzer)
      end
    end
    print_highest_word_frequency_across_lines()
  end

  def print_highest_word_frequency_across_lines
    @highest_count_words_across_lines.each do |analyzer|
      puts "#{analyzer.highest_wf_words} (appears in line #{analyzer.line_number + 1})"
    end
  end

end
