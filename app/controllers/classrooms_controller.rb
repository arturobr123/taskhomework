require 'openpay'
class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :edit, :update, :destroy, :uploadFiles , :score]
  before_action :authenticate_admin!, only: [:finish_homework, :update]
  before_action :own_user, only: [:create]
  before_action :own_admin, only: [:update]
  before_action :check_card, only: [:create]
  before_action :check_user_admin, only: [:show]
  

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
    else
      @deadline = "2015, 7, 24"
    end
  end


  def new
    @classroom = Classroom.new
  end


  def edit
  end

  def create
    admin_id = params[:admin_id]
    homework_id = params[:homework_id]
    proposal_id = params[:proposal_id]

    @homework = Homework.find(homework_id)
    @proposal = Proposal.find(proposal_id)
    
    @pago = pay_user(@homework, @proposal) #antes que nada hace el cobro

    @classroom = Classroom.new(user_id:current_user.id, homework_id: homework_id, admin_id: admin_id, proposal_id:proposal_id) 

    respond_to do |format|
      if @pago
        if @homework.update!(status: 2) && @proposal.update!(status: 2) &&  @classroom.save
          format.html { redirect_to @classroom, notice: 'Se ha creado el salon para la tarea. Se le notificará al trabajador' }
          format.json { render :show, status: :created, location: @classroom }
        else
          format.html { render :new }
          format.json { render json: @classroom.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to root_path, notice: 'No se pudo hacer el cargo. Revisa que tengas los fondos necesarios y si no, contactanos.' }
      end
    end
  end


  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to @classroom, notice: 'Classroom was successfully updated.' }
        format.json { render :show, status: :ok, location: @classroom }
      else
        format.html { render :edit }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end


  def uploadFiles

    #subida de archivos
    if params[:files]
      params[:files].each { |file|
        @classroom.archive_classrooms.create!(archivo: file)
      }
    end

    respond_to do |format|
      if params[:files]
        format.html { redirect_to @classroom, notice: 'Subida de archivos exitoso.' }
        format.json { render :show, status: :ok, location: @classroom }
      else
        format.html { redirect_to root_path}
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end


  def finish_homework

    homework_id = params[:homework_id]
    proposal_id = params[:proposal_id]

    #ahora la tarea cambia su status a finalizada
    @homework = Homework.find(homework_id)
    #ahora la propuesta cambia su status a finalizada
    @proposal = Proposal.find(proposal_id)

    respond_to do |format|
      if @homework.update!(status: 3) && @proposal.update!(status: 3)
        format.html { redirect_to root_path, notice: 'Tarea terminada! Recibirás tu pago pronto.' }
        format.json { render :show, status: :ok, location: root_path }
      else
        format.html { redirect_to root_path, notice: 'Error'}
      end
    end
    
  end


  def agree_homework

    homework_id = params[:homework_id]
    proposal_id = params[:proposal_id]
    classroom_id = params[:classroom_id]

    #ahora la tarea cambia su status a finalizada
    @homework = Homework.find(homework_id)
    #ahora la propuesta cambia su status a finalizada
    @proposal = Proposal.find(proposal_id)

    @pago = pay(@homework, @proposal)#hace el pago por open pay

    @classroom = Classroom.find(classroom_id)

    respond_to do |format|
      if(@pago)
        #actualiza el boleano diciendo que el usuario ya aprobo
        @classroom.update(user_accepts: true)

        format.html { redirect_back(fallback_location: root_path, notice: 'Muchas gracias. Ahora puedes calificar al trabajador en el salon.') }
        format.json { render :show, status: :ok, location: root_path }
      else
        format.html { redirect_to root_path, notice: 'Hubo un error. Por favor vuelvelo a intentar y si no contactanos.' }
      end
    end
    
  end


  def disagree_homework
    classroom_id = params[:classroom_id]
    @classroom = Classroom.find(classroom_id)

    if !@classroom
      redirect_to root_path, notice: 'Error'
    end

  end

  def send_disagree_homework_email
    
    if(params[:classroom_id])
      classroom_id = params[:classroom_id]
      @classroom = Classroom.find(classroom_id)
      @classroom.update(user_accepts: false)
    end

    if(params[:comment])
      comment = params[:comment]
    end

    NotiMailer.disagree_homework_email(comment, classroom_id , @classroom.homework.user.open_pay_user_id).deliver

    respond_to do |format|
      format.html { redirect_to @classroom, notice:"Muchas gracias. Se te notificará por correo en 24 horas. Ahora puedes calificar al trabajador." }
    end

  end


  #cuando el usuario acepta quien le hará la tarea, este se le hace el cobro de lo que tiene
  #asignado la propuesta(y se le agrega a su cuenta en openpay)
  def pay_user(homework, proposal)

    #CREATE THE CHARGE OPEN PAY

    #merchant and private key
    merchant_id='mnn5gyble3oezlf6ca3v'
    private_key='sk_33044f35a7364f81b7139b21327a5927'
    openpay=OpenpayApi.new(merchant_id,private_key)

    request_hash={
      "method" => "card",
      "source_id" => homework.user.card_id,
      "amount" => proposal.cost,
      "currency" => "MXN",
      "description" => homework.name,
      "device_session_id" => "kR1MiQhz2otdIuUlQkbEyitIqVMiI16f",
      "order_id" => homework.id #este id puede ser inventado pero debe ser unico
    }

    charges=openpay.create(:charges)

    begin
      @charge = charges.create(request_hash.to_h, homework.user.open_pay_user_id)
    rescue Exception => e
      puts e.description# => 'The api key or merchant id are invalid.'
      return false
    end

    return true #si se pudo hacer el cargo
    
  end



  def pay(homework, proposal)

    #merchant and private key
    merchant_id='mnn5gyble3oezlf6ca3v'
    private_key='sk_33044f35a7364f81b7139b21327a5927'
    openpay=OpenpayApi.new(merchant_id,private_key)

    #HACER TRANSFERENCIAS ENTRE CLIENTES USUARIOS
    new_transaction_hash={
       "customer_id" => proposal.admin.open_pay_user_id,
       "amount" => proposal.cost,
       "description" => "Transferencia entre cuentas tarea #{homework.id}"
     }

    transfers=openpay.create(:transfers)

    begin
      transfers.create(new_transaction_hash.to_h, homework.user.open_pay_user_id) #de aqui se sacara el dinero
    rescue Exception => e
      puts e.http_code  #  => 401
      puts e.error_code # => 1002
      puts e.description# => 'The api key or merchant id are invalid.'
      puts e.json_body #  {"category":"request","description":"The api key or merchant id are invalid.","http_code":401,"error_code":1002,"request_id":null}
      return false
    end

    return true
    
  end



  def show_to_score

    @classroom = Classroom.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
    
  end

  #score the homework
  def score

    score = params[:score]

    respond_to do |format|
      if @classroom.update!(scoreTrabajador: score.to_i)

        #update the rank of worker
        @admin = Admin.find(@classroom.admin_id)
        rank_new = (@admin.rank + score.to_f)/2
        @admin.update!(rank: rank_new)

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
      format.html { redirect_to classrooms_url, notice: 'Classroom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



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
        if @classroom.user_id != current_user.id
          redirect_to root_path, notice: "No estas autorizado"
        end
      end

      if current_admin
        if @classroom.admin_id != current_admin.id
          redirect_to root_path, notice: "No estas autorizado"
        end
      end
    end

    def own_admin
      if current_admin.id != @classroom.admin_id
        redirect_to root_path, notice: "No estas autorizado"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classroom_params
      params.require(:classroom).permit(:homework_id, :status, :user_id, :admin_id)
    end
end
