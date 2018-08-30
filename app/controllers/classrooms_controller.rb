require 'openpay'
class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :edit, :update, :destroy, :uploadFiles , :score]
  before_action :authenticate_admin!, only: [:finish_homework, :update]
  before_action :own_user, only: [:create]
  before_action :own_admin, only: [:update]
  before_action :check_card, only: [:create]
  before_action :check_user_admin, only: [:show]

  include OpenPay
  include CopyLeaks
  include PaypalConcern

  def index
    @classrooms = Classroom.all
  end

  def show
    @proposal = Proposal.find(@classroom.proposal.id)
    @homework = Homework.find(@classroom.homework.id)
    @user = User.find(@classroom.user.id)
    @admin = Admin.find(@classroom.admin.id)

    if @homework.status != 3
      @deadline = @proposal.deadline.strftime("%Y, %m, %e")
      puts @deadline
    else
      @deadline = "2015, 7, 24"
    end

  end


  def new
    @classroom = Classroom.new
  end

  def edit
  end

  def select_proposal_paypal
    admin_id = params[:admin_id]
    homework_id = params[:homework_id]
    proposal_id = params[:proposal_id]

    @result = pay_paypal(admin_id, homework_id, proposal_id)

    respond_to do |format|
      if @result[1] == true
        format.html { redirect_to @result[0] }
      else
        format.html { render root_path, notice: "ERROR, alguio salió mal, vuelve a intentarlo y si no contactanos."}
      end
    end
  end

  def execute_payment_paypal

    admin_id = params[:admin_id]
    homework_id = params[:homework_id]
    proposal_id = params[:proposal_id]

    paymentId = params[:paymentId]
    payerID = params[:PayerID]

    @result = execute_payment(paymentId,payerID)

    respond_to do |format|
      if @result
        format.html { redirect_to create_classroom_paypal_path(admin_id: admin_id, homework_id: homework_id, proposal_id: proposal_id) }
        format.json { render :show, status: :created, location: @classroom }
      else
        format.html { render root_path, notice: "ERROR, alguio salió mal, vuelve a intentarlo y si no contactanos."}
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end

  end

  def create_classroom_paypal
    admin_id = params[:admin_id]
    homework_id = params[:homework_id]
    proposal_id = params[:proposal_id]

    @homework = Homework.find(homework_id)
    @proposal = Proposal.find(proposal_id)

    @classroom = Classroom.new(user_id:current_user.id, homework_id: homework_id, admin_id: admin_id, proposal_id:proposal_id)

    respond_to do |format|
      if @homework.update!(status: 2) && @proposal.update!(status: 2) &&  @classroom.save
        format.html { redirect_to @classroom, notice: 'Se ha creado el salon para la tarea. Se le notificará al trabajador' }
        format.json { render :show, status: :created, location: @classroom }
      else
        format.html { render root_path, notice: "ERROR, alguio salió mal, contactanos. contacto@taskhomework.com"}
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    admin_id = params[:admin_id]
    homework_id = params[:homework_id]
    proposal_id = params[:proposal_id]

    @homework = Homework.find(homework_id)
    @proposal = Proposal.find(proposal_id)

    #@pago = pay_user(@homework, @proposal) #antes que nada hace el cobro

    @classroom = Classroom.new(user_id:current_user.id, homework_id: homework_id, admin_id: admin_id, proposal_id:proposal_id, transaction_id: @pago[1])

    respond_to do |format|
      if @pago[0] == true
        if @homework.update!(status: 2) && @proposal.update!(status: 2) &&  @classroom.save
          format.html { redirect_to @classroom, notice: 'Se ha creado el salon para la tarea. Se le notificará al trabajador' }
          format.json { render :show, status: :created, location: @classroom }
        else
          format.html { render root_path, notice: "ERROR, alguio salió mal, contactanos."}
          format.json { render json: @classroom.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to root_path, notice: 'No se pudo hacer el cargo. Revisa que tengas los fondos necesarios y conexión a internet y si no, contactanos.' }
      end
    end
  end


  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to @classroom, notice: 'El salon fue creado correctamente.' }
        format.json { render :show, status: :ok, location: @classroom }
      else
        format.html { render :edit }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  #Subida de archivos del trabajador al salon
  def uploadFiles
    #subida de archivos
    @result_plag = [false, []]
    if params[:files]
      params[:files].each { |file|

        if params[:type_homework] == "2" #español, aplica el algoritmo de plagio
          @result_plag = check_plagiarism_document(file.path)
          break if @result_plag.first
        end

        @classroom.archive_classrooms.create!(archivo: file)
      }
    end

    respond_to do |format|
      if @result_plag.first == true #SI HUBO PLAGIO
        NotiMailer.send_plagiarism_to_woker(@classroom.admin.email, @classroom.admin, @result_plag.second).deliver #enviar correo con la info de plagio al tasker
        format.html { redirect_to plagiarism_checker_path(:info => @result_plag.second), notice: "El algoritmo de plagio detecto algo." }
      else
        if params[:files]
          format.html { redirect_to @classroom, notice: 'Subida de archivos exitoso. Si ya terminaste la tarea recuerda darle click al boton "finalizar tarea".' }
          format.json { render :show, status: :ok, location: @classroom }
        else
          format.html { redirect_to @classroom, notice:"No hay archivos que subir"}
          format.json { render json: @classroom.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  def plagiarism_checker
    #fake
    @info = [{"url"=>"https://www.wikiplanet.click/enciclopedia/es/Revolución_mexicana", "percents"=>"99", "embededComparison"=>"https://copyleaks.com/compare-embed/a904be8a-6f74-4f1c-b4e1-6214a86ee980/5243250"},
            {"url"=>"http://asambleademajaras.com/videos/detalle_video.php?idvideo=826", "percents"=>"77", "embededComparison"=>"https://copyleaks.com/compare-embed/a904be8a-6f74-4f1c-b4e1-6214a86ee980/5243257"}]

    @info = params[:info]
  end

  #el trabajador finaliza la tarea y notifica al estudiante
  def finish_homework

    homework_id = params[:homework_id]
    proposal_id = params[:proposal_id]

    #ahora la tarea cambia su status a finalizada
    @homework = Homework.find(homework_id)
    #ahora la propuesta cambia su status a finalizada
    @proposal = Proposal.find(proposal_id)

    respond_to do |format|
      if @homework.update!(status: 3) && @proposal.update!(status: 3) && @proposal.classroom.update!(:finished => true, :finished_date => DateTime.now)
        format.html { redirect_to root_path, notice: 'Tarea terminada! Se le notificará al estudiante para que la vea.' }
        format.json { render :show, status: :ok, location: root_path }
      else
        format.html { redirect_to root_path, notice: 'Error'}
      end
    end

  end

  #El estudiante acepta que esta de acuerdo con la tarea que se le entrego
  def agree_homework

    homework_id = params[:homework_id]
    proposal_id = params[:proposal_id]
    classroom_id = params[:classroom_id]

    @homework = Homework.find(homework_id)
    @proposal = Proposal.find(proposal_id)

    #@pago = payout_paypal(@homework, @proposal)
    @pago = true

    @classroom = Classroom.find(classroom_id)

    respond_to do |format|
      if(@pago)
        #actualiza el boleano diciendo que el usuario ya aprobo
        @classroom.update(user_accepts: true)

        #envio de correo al trabajador
        NotiMailer.send_money_to_tasker_homework_complete(@proposal.admin.email, @homework, @classroom).deliver
        #enviarme correo para pasar el dinero a la cuenta del trabajador
        NotiMailer.notify_worker_accepts_homework(@proposal.admin.email, @homework, @classroom).deliver

        format.html { redirect_back(fallback_location: root_path, notice: 'Muchas gracias. Ahora puedes calificar al tasker en el salon.') }
        format.json { render :show, status: :ok, location: root_path }
      else
        format.html { redirect_to root_path, notice: 'Hubo un error. Cheque su conexión a interntet. Por favor vuelvelo a intentar y si no contactanos.' }
      end
    end

  end

  #pagina para escribir el mensaje de porque no le gusto la tarea
  def disagree_homework
    classroom_id = params[:classroom_id]
    @classroom = Classroom.find(classroom_id)

    if !@classroom
      redirect_to root_path, notice: 'Error'
    end
  end

  #mandar el mensaje de porque no le gusto la tarea
  def send_disagree_homework_email
    if(params[:classroom_id])
      classroom_id = params[:classroom_id]
      @classroom = Classroom.find(classroom_id)
      @classroom.update(user_accepts: false)
    end

    if(params[:comment])
      comment = params[:comment]
    end

    NotiMailer.disagree_homework_email(comment, classroom_id,  @classroom.admin.email , @classroom.proposal.cost).deliver

    respond_to do |format|
      format.html { redirect_to @classroom, notice:"Muchas gracias. Se te notificará por correo en 24 horas. Ahora puedes calificar al trabajador." }
    end
  end

  #mostrar el modal para calificar la tarea
  def show_to_score
    @classroom = Classroom.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  #Calficiar la tarea
  def score
    score = params[:score]

    respond_to do |format|
      if @classroom.update!(scoreTrabajador: score.to_i)

        #update the rank of worker
        @admin = Admin.find(@classroom.admin_id)
        rank_new = (@admin.rank + score.to_f)/2
        @admin.update!(rank: rank_new)
        #enviar correo de notificación al trabajador
        NotiMailer.notify_worker_score_homework(@admin.email, @classroom.homework , @classroom).deliver

        format.html { redirect_to root_path, notice: 'Tarea calificada. Gracias!' }
        format.json { render :show, status: :ok, location: root_path }
      else
        format.html { redirect_to root_path, notice: 'Error'}
      end
    end
  end

  def destroy
    #@classroom.destroy
    respond_to do |format|
      format.html { redirect_to classrooms_url, notice: 'El salon fue eliminado.' }
      format.json { head :no_content }
    end
  end


  #################################################################################


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    #checa que el usuario tenga una tarjeta agregada
    def check_card
      if !current_user.card_id
        redirect_to edit_user_path(current_user), notice: "No tienes tarjeta de debito agregada."
      end
    end

    def own_user
      if current_user.id != params[:user_id].to_i
        redirect_to root_path, notice: "No estas autorizado"
      end
    end

    def check_user_admin
      if current_user
        if @classroom.user_id == current_user.id
          return true
        end
      end

      if current_admin
        if @classroom.admin_id == current_admin.id
          return true
        end
      end
      redirect_to root_path, notice: "No estas autorizado"
    end

    def own_admin
      if current_admin.id != @classroom.admin_id
        redirect_to root_path, notice: "No estas autorizado"
      end
    end

    def classroom_params
      params.require(:classroom).permit(:homework_id, :status, :user_id, :admin_id)
    end
end
