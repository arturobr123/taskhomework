require 'openpay'


class MainController < ApplicationController

  def home
  end

  def homeAdmin

    respond_to do |format|
      if(current_admin.phrase.length <= 1)
        format.html { redirect_to phrase_path, notice: "Bienvendido a Task. Por favor escribe tu frase antes de subir propuestas." }
      else
        format.html { redirect_to my_homeworks_path }
      end
    end

  end

  def homeUser
  	redirect_to my_homeworks_path
  end

  def userUnregistered
  	#redirect_to new_user_registration_path
    redirect_to home_page_path
  end

  def adminUnregistered
  	#redirect_to new_admin_registration_path
    redirect_to home_page_path
  end

end
