require "stripe"
class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :edit, :update, :destroy, :uploadFiles , :score]
  before_action :authenticate_admin!, only: [:finish_homework]
  # GET /classrooms
  # GET /classrooms.json
  def index
    @classrooms = Classroom.all
  end

  # GET /classrooms/1
  # GET /classrooms/1.json
  def show
    @homework = Homework.find(@classroom.homework.id)
    @user = User.find(@classroom.user.id)
    @admin = Admin.find(@classroom.admin.id)
    @proposal = Proposal.find(@classroom.proposal.id)
  end

  # GET /classrooms/new
  def new
    @classroom = Classroom.new
  end

  # GET /classrooms/1/edit
  def edit
  end

  # POST /classrooms
  # POST /classrooms.json
  def create
    #@classroom = Classroom.new(classroom_params)

    admin_id = params[:admin_id]
    homework_id = params[:homework_id]
    proposal_id = params[:proposal_id]
    @classroom = Classroom.new(user_id:current_user.id, homework_id: homework_id, admin_id: admin_id, proposal_id:proposal_id)

    #ahora la tarea cambia su status a en proceso
    @homework = Homework.find(homework_id)
    @homework.update!(status: 2) 

    #ahora la propuesta cambia su status a en proceso
    @proposal = Proposal.find(proposal_id)
    @proposal.update!(status: 2) 

    respond_to do |format|
      if @classroom.save
        format.html { redirect_to @classroom, notice: 'Se ha creado el salon para la tarea.' }
        format.json { render :show, status: :created, location: @classroom }
      else
        format.html { render :new }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classrooms/1
  # PATCH/PUT /classrooms/1.json
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


    #CREATE THE CHARGE
    charge = Stripe::Charge.create(
      :customer    => @homework.user.stripe_customer_token,
      :amount      => 500 + @proposal.cost.to_i,
      :description => @homework.name,
      :currency    => 'usd'
    )

    respond_to do |format|
      if @homework.update!(status: 3) && @proposal.update!(status: 3)
        format.html { redirect_to root_path, notice: 'Tarea terminada! Recibirás tu pago pronto.' }
        format.json { render :show, status: :ok, location: root_path }
      else
        format.html { redirect_to root_path, notice: 'Error'}
      end
    end
    
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

  # DELETE /classrooms/1
  # DELETE /classrooms/1.json
  def destroy
    @classroom.destroy
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def classroom_params
      params.require(:classroom).permit(:homework_id, :status, :user_id, :admin_id)
    end
end
