class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @word_count = @text.split.count

    @character_count_with_spaces = @text.size

    @character_count_without_spaces = @text.gsub(" ","").size

    @occurrences = @text.downcase.gsub(/[^a-z0-9\s]/i,"").split.count(@special_word.downcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @apr_decimal = @apr/1200
    @monthly_payment = (@apr_decimal/(1-(1+@apr_decimal)**(-1*@years*12)))*@principal

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52 #hopefully this is done

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    #   @squared_numbers = []

    #   @numbers.each do |num|
    #     square = num * num
    #     @squared_numbers.push(square)
    #   end

    # @sorted_numbers = @squared_numbers

    ####################SORTED NUMBERS####################
    @sorted_numbers = @numbers.sort!

    ####################COUNT####################
    @count = @numbers.size

    ####################MINIMUM####################
    @minimum = @numbers.min

    ####################MAXIMUM####################
    @maximum = @numbers.max

    ####################RANGE####################
    @range = @numbers.max - @numbers.min

    ###################MEDIAN####################
    if(@count % 2 == 0)
      @median = (@sorted_numbers[(@count/2).to_i - 1] + @sorted_numbers[(@count/2).to_i])/2.0
    else
      @median = @sorted_numbers[(@count/2).to_i]
    end

    ###################SUM####################
    @sum = @numbers.sum

    ###################MEAN####################
    @mean = @sum/@count

    ###################VARIANCE####################
      @calculation = []

      @numbers.each do |num|
        difference = num - @mean
        @calculation.push(difference * difference)
      end
    
    @variance = (@calculation.sum) / (@count)

    ###################STANDARD DEVIATION####################
    @standard_deviation = @variance ** (1.0/2.0)

    ###################MODE####################
    counter = Hash.new(0)

    @sorted_numbers.each do |num|
      counter[num] += 1
      # p counter
    end
    
    highest_mode = counter.max_by{|key,value| value}[1] #counter.sort_by{|key,value| value}[-1]
    values = counter.select{|key,value| value==highest_mode}

    @mode = values 
    
    #values.select{|k,v| v == hash.values.max}
    #counter.invert["key"=>highest_mode]


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
