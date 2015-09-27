module QuestionHelper

  def any_votes? question
    votes = false
    
    question.choices.each do |choice|
      votes = true if choice.votes.any?
    end

    votes
  end
  
end