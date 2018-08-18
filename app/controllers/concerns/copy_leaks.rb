require 'copyleaks_api'
module CopyLeaks
  extend ActiveSupport::Concern

	def check_plagiarism_document(file)
    email = "arturo2017-1@hotmail.com"
    #api_key = "497C60D3-FC9E-4B27-B60A-E761EABBD9E4"
    api_key = ENV.fetch('COPYLEAKS_KEY')

    # There are currently 3 available products - :businesses, :education, :websites
    begin
      cloud = CopyleaksApi::CopyleaksCloud.new(email, api_key, :education)
    rescue
      return[false , []]
    end

    # Check your account balance
    puts "You have #{cloud.get_credits_balance} credits"
    if(cloud.get_credits_balance.to_i < 2)
      return[false , []]
    end

    @results = []
    begin #TRY
      process = cloud.create_by_file(file)

      while process.processing?
        sleep(1)
        process.update_status
        puts "#"*(process.progress/2) + "-"*(50 - process.progress/2) + "#{process.progress}%"
      end

      @results = process.get_results
    rescue Exception => e
      puts e
      return [false , []]
    end

    @plag_array = []

    puts "#{@results.size} Results: "
    #itera entre todos los resultados que tienen similitud de plagio
    @results.each do |res|
      puts "!!!!!!!!!"
      temp = res.to_yaml
      temp_info = temp.split(" ")

      #url
      url = temp_info.index("URL:")
      url += 1

      #percent plagiarism
      percents = temp_info.index("Percents:")
      percents += 1
      number = temp_info[percents].split("%")

      #embededComparison
      embededComparison = temp_info.index("EmbededComparison:")
      embededComparison += 1

      if(number.first.to_f >= 30)
        hash = {}
        hash["url"] = temp_info[url]
        hash["percents"] = number.first
        hash["embededComparison"] = temp_info[embededComparison]

        #puts hash
        @plag_array << hash
      end

    end

    puts @plag_array

    #si encontró paginas con plagio
    if(@plag_array.length > 0)
      puts "SI HAY PLAGIO !!!!!"
      return [true, @plag_array]
    else
      return [false, []]
    end

  end

end
