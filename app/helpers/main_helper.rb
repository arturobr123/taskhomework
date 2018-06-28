module MainHelper
	def fechaBonita date
  	theDate = date.strftime("%b. %e, %Y") # %H:%M   => hour and minute, siempre marcan 00:00
  	theDate.html_safe
  end

  def boleano_si_no booleano

    if(booleano == true)
      return "SI"
    end

    if(booleano == false)
      return "NO"
    end

  end
end
