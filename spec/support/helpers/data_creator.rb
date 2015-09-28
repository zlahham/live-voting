module DataHelpers
  def data_creator(question_number)
    data = {
      event: {
        id: @event.id,
        title: @event.title
      },
      question: {
        id: @question.id,
        content: @question.content,
        question_number: question_number
      },
      choices: [
        {
          content: @choice.content,
          id: @choice.id
        },
        {
          content: @choice2.content,
          id: @choice2.id
        },
        {
          content: @choice3.content,
          id: @choice3.id
        }
      ]
    }
    data.to_json
  end
end


RSpec.configure do |config|
  config.include(DataHelpers)
end
