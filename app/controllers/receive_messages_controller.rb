class ReceiveMessagesController < ApplicationController

  # POST /process_sms
  def process_sms
    # get array of message words
    body = params[:Body]

    # find the user's name from their phone number
    fromNumRaw = params[:From].split("")
    fromNum = "#{fromNumRaw[2..4].join}-#{fromNumRaw[5..7].join}-#{fromNumRaw[8..-1].join}"
    #user = User.find_by_phone_number(fromNum)
    # if user.nil?
    #   @error = "Could not find user"
    #   user = User.new(name: "unknown", phone_number: fromNum)
    # end
    puts fromNum
    puts body
    input = body.split(" "); # input is the message body slit by space

    case input[0].downcase
      when "request", "r"
        output = pill_request(input[1])  # requests pill to drop of location, returns a txt to the user

      when "wotd", "word-of-the-day" #easter egg
            output = wotd()
      else
        output = "Could not process request"
    end


    # send_text(fromNum, output) # sends response text back to sender confirming there request


    render '/list_texts/list_texts.xml.erb', :content_type => 'text/xml'
  end
end
