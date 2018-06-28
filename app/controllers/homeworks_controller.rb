class HomeworksController < ApplicationController
  before_action :set_homework, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :destroy]

  # GET /homeworks
  # GET /homeworks.json
  def index
    @homeworks = Homework.where(status:1).nuevos
  end

  # GET /homeworks/1
  # GET /homeworks/1.json
  def show
    @proposals = @homework.proposals.nuevos.paginate(page:params[:page], per_page:5)
  end

  def my_homeworks
    #USUSARIO
    if(current_user)
      #@homeworks = current_user.homeworks.nuevos

      @homeworks_disponibles = current_user.homeworks.where(status: 1).nuevos
      @homeworks_en_proceso = current_user.homeworks.where(status: 2).nuevos
      @homeworks_finalizadas = current_user.homeworks.where(status: 3).nuevos
    end

    #TRABAJADOR
    if(current_admin)
      #@proposals = current_admin.proposals.where("status not in (?)", [1])

      @proposals_en_proceso = current_admin.proposals.where(status: 2)
      @proposals_finalizadas = current_admin.proposals.where(status: 3)

      ids_en_proceso = [] #ids de las tareas en proceso
      @proposals_en_proceso.each do |p|
        ids_en_proceso << p.homework_id
      end

      ids_finalizadas = [] #ids de las tareas finalizadas
      @proposals_finalizadas.each do |p|
        ids_finalizadas << p.homework_id
      end

      #@homeworks = Homework.where("id in (?)" , ids).nuevos

      @homeworks_en_proceso = Homework.where("id in (?)" , ids_en_proceso).nuevos
      @homeworks_finalizadas = Homework.where("id in (?)" , ids_finalizadas).nuevos
    end


  end

  # GET /homeworks/new
  def new
    @homework = Homework.new
  end

  # GET /homeworks/1/edit
  def edit
  end

  # POST /homeworks
  # POST /homeworks.json
  def create
    #@homework = Homework.new(homework_params)

    @homework = current_user.homeworks.new(homework_params)

    respond_to do |format|
      if @homework.save

        #subida de archivos
        if params[:files]
          params[:files].each { |file|
            @homework.archives.create!(archivo: file)
          }
        end

        format.html { redirect_to @homework, notice: 'Homework was successfully created.' }
        format.json { render :show, status: :created, location: @homework }
      else
        format.html { render :new }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homeworks/1
  # PATCH/PUT /homeworks/1.json
  def update
    respond_to do |format|
      if @homework.update(homework_params)
        format.html { redirect_to @homework, notice: 'Homework was successfully updated.' }
        format.json { render :show, status: :ok, location: @homework }
      else
        format.html { render :edit }
        format.json { render json: @homework.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homeworks/1
  # DELETE /homeworks/1.json
  def destroy
    @homework.destroy
    respond_to do |format|
      format.html { redirect_to homeworks_url, notice: 'Homework was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_homework
      @homework = Homework.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def homework_params
      params.require(:homework).permit(:deadline, :description, :name, :numberpages, :status, :tipo, :user_id, :admin_id, :level , :minPrice , :maxPrice)
    end
end
