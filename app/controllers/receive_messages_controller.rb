require 'ostruct'
class ReceiveMessagesController < ApplicationController
   skip_before_filter  :verify_authenticity_token

  # twilio account information
  TWILIO_NUMBER = "+12484681032"
  ACCOUNT_SID = 'AC96796c001a76c46cedafc99786c61642'
  AUTH_TOKEN = 'f8d659f3cc40cb5662f84c7432d46375'
  @fromNum = 0

  # POST /process_sms
  def process_sms
    # get array of message words

    body = params[:Body]
    # find the user's name from their phone number
    fromNumRaw = params[:From].split("")
    @fromNum = "#{fromNumRaw[2..4].join}#{fromNumRaw[5..7].join}#{fromNumRaw[8..-1].join}"
    puts @fromNum

    puts body

    input = body.split(" "); # input is the message body slit by space
    # Figure out command
    iter = 0
    command = input[iter].downcase
    iter += 1
    puts command
    
    case command
    # request to GPS
      when "r2g"
        gpsLat = input[iter].downcase 
        iter += 1
        gpsLon = input[iter].downcase
        iter += 1
        meds = getMedsList(input, iter)

        ## TEST
        puts "lat: " + gpsLat
        puts gpsLon

      meds.each { |a| puts a }
      runArduino(meds)
      ##

      # request to address
      when "r2a"
        addr = input[iter].downcase
        iter += 1
        street = input[iter].downcase
        iter += 1
        city = input[iter].downcase
        iter += 1
        state = input[iter].downcase
        iter += 1
        zip = input[iter].downcase
        iter += 1
        meds = getMedsList(input, iter)
     ## TEST
        puts addr
        puts street
        puts city
        puts state
        puts zip
      meds.each { |a| puts a }
      ##
      runArduino(meds)

      # request to location
      when "r2l"
        location = input[iter].downcase
        iter += 1
        meds = getMedsList(input, iter)

        ## TEST
        puts location
      meds.each { |a| puts a }
      runArduino(meds)
      ##
       # check stock
      when "cs"
        medID = input[iter];
        iter += 1
        med = Medicine.find(medID)
        count = med.quantity
        #send back count requester
        sendMessage("#{count} of medicine #{med.name} available")


      # Similar to
      when "s"
        medID = input[iter];
        iter += 1
        med = Medicine.find(medID)
        # get list of medicines of the same type
        meds = Medicine.find_by_name(med.type)
        # send back similar medicines
        msg = "Similar to medicine #{med.name} are meds {"
        for i in (0..meds.length) 
          msg += "#{meds[i]}, "
        end
        msg += "}"
        sendMessage(msg)

      #help menu
      when "?"
        sendMessage("Text \"?cmd\" for more info.\nFormat: Full name[cmd]\nRequest Meds[RM]\nCheck Stock[CS]\nSimilar To[s]")
      # request meds help
      when "?rm"
        helpMsg = "Request Medication\nto GPS:\n"
        helpMsg += "R2G <username> <password> <lat> <lon> <List of <med ID | med name> <amount>>\n"
        helpMsg += "to Address:\nR2A '' ''  <address> <street> <city> <state> <zip> <Med List>\n"
        helpMsg += "to Location:\nR2L '' ''  <location ID | location name> <Med List>"
        sendMessage(helpMsg)

      # check stock help
      when "?cs"
        helpMsg = "Check stock of medicaiton\nCS <med ID | med name>"
        sendMessage(helpMsg)

      # find similar to help
      when "?s"
        helpMsg = "Find medication similar to\nS <med ID | med name>"
        sendMessage(helpMsg)

      when "wotd", "word-of-the-day" #easter egg
        puts "egg"
      else
        output = "Coud not process request"
    end

    # send_text(fromNum, output) # sends response text back to sender confirming there request


   render '/list_texts/list_texts.xml.erb', :content_type => 'text/xml'
  end

  def getMedsList(inputStrs, pos)
    med = OpenStruct.new
    med.id = "medName"
    med.count = 0
    arrSize = (inputStrs.length - pos)/2
    medsIter = 0
    meds = Array.new(arrSize){med}
    while (pos < inputStrs.length) do
      med = OpenStruct.new
      med.id = inputStrs[pos].downcase;
      pos += 1
      med.count = inputStrs[pos].downcase;
      pos += 1
      tempMed = Medicine.find(med.id)
      puts tempMed.quantity
      puts med.count
      if(tempMed.quantity - Integer(med.count) >= 0) then
        tempMed.quantity = tempMed.quantity - Integer(med.count)
        tempMed.save
        meds[medsIter] = med
        medsIter+=1
      else
        sendMessage("Out of stock of " + tempMed.name + ". Use S <medicine name> to find similar medicines.")
      end
    end
    return meds;
  end

  def sendMessage(message)
    account = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN).account
        account.sms.messages.create(
          :from => TWILIO_NUMBER,
          :to => "+1#{@fromNum}",
          :body => message
        )
  end

  def groupMessage(numbers, message)
      account = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN).account
      
      numbers.each do |number|
        logger.info "sending message: #{@text_message.message} to: #{number}"

        begin
          account.sms.messages.create(
              :from => TWILIO_NUMBER,
              :to => "#{number}",
              :body => message
          )
          successes << "#{number}"
        rescue Exception => e
          logger.error "error sending message: #{e.to_s}"
          errors << e.to_s
        end
      end
  end

  def runArduino(meds)
      fileName = `ls /dev/tty.usbmodem14*`
      puts fileName[0..-2]
      system("stty -f " + fileName[0..-2] + " cs8 9600 ignbrk -brkint -icrnl -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts")
      cmdStr = "echo \"m";
      meds.each { |a| cmdStr += " " + a.id}
      cmdStr += " 0\" > " + fileName[0..-2]
      puts cmdStr
      `#{cmdStr}`
  end

end
