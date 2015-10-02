class BuildJSON

  def self.call(event, question)
    choices_array = []

    question.choices.each do |choice|
      choice_hash = { content: choice.content, id: choice.id }
      choices_array << choice_hash
    end

    event_object = event.attributes.reject!{|key,value| %w"updated_at created_at user_id".include? key}
    question_object = question.attributes.reject!{|key,value| %w"updated_at created_at event_id".include? key}

    questions_array = event.questions.all.order(:id)
    question_number = questions_array.index(question).to_i + 1

    question_object.merge!(question_number: question_number)
    { event: event_object, question: question_object, choices: choices_array }.to_json
  end

end