# comment to satisfy rubocop
class Quiz
  attr_accessor :quiz_question, :correct_answer, :quiz_length,
                :question_answer_pairs, :current_score, :wrong_answers,
                :user_answer, :total_points_possible, :wants_to_retry,
                :previous_score, :score_log

  def initialize(attr)
    @quiz_question = attr[:quiz_question]
    @correct_answer = attr[:correct_answer]
    @quiz_length = attr[:quiz_length]
    @question_answer_pairs = attr[:question_answer_pairs]
    @current_score = attr[:current_score]
    @wrong_answers = attr[:wrong_answers]
    @user_answer = attr[:user_answer]
    @total_points_possible = attr[:total_points_possible]
    @wants_to_retry = attr[:wants_to_retry]
    @previous_score = attr[:previous_score]
    @score_log = attr[:score_log]
  end

  def ask_for_quiz_length
    @quiz_length = 0
    until @quiz_length > 1
      puts 'How long is your quiz?'
      @quiz_length = gets.chomp.to_i
      if @quiz_length < 2
        puts 'Quiz must be at least 2 questions long'
      end
    end
  end

  def ask_for_question_and_answer
    puts 'What is the question?'
    quiz_question = gets.chomp
    @quiz_question = { quiz_question: quiz_question }

    puts 'What is the answer?'
    @correct_answer = gets.chomp
    @correct_answer = { correct_answer: correct_answer }
  end

  def gather_quiz
    ask_for_quiz_length
    @quiz_length.times do
      ask_for_question_and_answer
      @question_answer_pairs.push([@quiz_question, @correct_answer])
    end
  end

  def take_quiz
    current_question_number = 0
    @current_score || @current_score = 0
    @score_log || @score_log = []
    if !@score_log.empty?
      @total_points_possible -= @score_log.last
    else
      @total_points_possible = @quiz_length
    end

    until current_question_number == @total_points_possible
      puts "Question ##{current_question_number + 1}"
      puts @question_answer_pairs.first.first[:quiz_question]
      evaluate_answers
      current_question_number += 1
      @question_answer_pairs.shift(1)
      @score_log.push(@current_score)
    end
    wrap_up
  end

  def evaluate_answers
    @wrong_answers || @wrong_answers = []
    @user_answer = gets.chom

    if @user_answer == @question_answer_pairs.first.last[:correct_answer]
      @current_score += 1
      puts 'Correct!'
    else
      @wrong_answers.push(@question_answer_pairs.first)
      puts 'Incorrect. Don\'t worry, you can try again later.'
    end
    puts "Current score: #{@current_score} points"
  end

  def wrap_up
    puts '======================================='
    puts "All done! Final score: #{@current_score} out of #{@total_points_possible} possible points."
    if @current_score < @total_points_possible
      puts 'Would you like to retry the ones you got wrong? Yes/No'
      wants_to_retry = gets.chomp.downcase
      if wants_to_retry == 'yes'
        retake_quiz
      elsif wants_to_retry == 'no'
        puts 'Bye, Felisha!'
      else
        puts 'Sorry, I don\'t know what that means'
      end
    end
  end

  def retake_quiz
    new_quiz = Quiz.new(quiz_length: @wrong_answers.length, question_answer_pairs: @wrong_answers)
    new_quiz.take_quiz
  end

  def final_score
    puts "Final Score: #{@score_log.last + @score_log.last - 1}"
  end

end

full_quiz = Quiz.new(quiz_length: nil, question_answer_pairs: [])
full_quiz.gather_quiz
full_quiz.take_quiz
full_quiz.final_score
