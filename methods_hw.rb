def create_quiz
  @quiz = []

  quiz_quant.times do
    @quiz.push(q_n_a)
  end
end

def quiz_quant
  length = 0
  until length > 1
    puts 'How long is your quiz?'
    length = gets.chomp.to_i
    if length < 2 then puts 'Quiz must be at least 2 questions long' end
  end
  return length
  take_quiz
end

def q_n_a
  puts 'What is the question?'
  question = gets.chomp
  question = { question: question }

  puts 'What is the answer?'
  answer = gets.chomp
  answer = { answer: answer }
  return [question, answer]
end

def wrap_up
  puts '======================================='
  puts "All done! Final score: #{@score} out of #{@total_points_possible} points possible."
  if @score < @total_points_possible
    puts 'Would you like to retry the ones you got wrong? Yes/No'
    @wants_to_retry = gets.chomp.downcase
  end
end

def evaluate_answers
  wrong_answers = []
  user_answer = gets.chomp

  if user_answer == @quiz.first.last[:answer]
    @score += 1
    puts 'Correct!'
  else
    wrong_answers.push(@quiz.first)
    puts 'Incorrect'
  end
  puts "Current score: #{@score} points"
end

def take_quiz
  question_number = 0
  @score = 0
  @total_points_possible = @quiz.length
  until question_number == @total_points_possible
    puts "Question ##{question_number + 1}"
    puts @quiz.first.first[:question]
    evaluate_answers
    question_number += 1
    @quiz.shift(1)
  end
  wrap_up
  retake_quiz
end

def retake_quiz
  if @wants_to_retry == 'yes'
    take_quiz
  elsif @wants_to_retry == 'no'
    puts 'Bye, Felisha!'
  else
    puts 'Sorry, I don\'t know what that means'
  end
end



create_quiz
take_quiz
