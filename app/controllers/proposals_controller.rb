class ProposalsController < ApplicationController
  before_action :set_proposal, only: [:show, :edit, :update, :destroy]
  before_action :set_homework, only: [:new]

  before_action :authenticate_admin!, only: [:new, :create] #NUEVO
  before_action :own_admin,only: [:destroy,:edit] #NUEVO

  before_action :check_clabe,only: [:new]
  before_action :check_phrase,only: [:new]


  def index
    @proposals = Proposal.all
  end

  def show
  end

  def new
    @proposal = Proposal.new

    if current_admin.phrase
      @phrase = current_admin.phrase
    else
      @phrase = ""
    end
  end

  def edit
  end

  def create
    @proposal = Proposal.new(proposal_params)

    respond_to do |format|
      if @proposal.save
        format.html { redirect_to @proposal.homework, notice: 'Proposal was successfully created.' }
        format.json { render :show, status: :created, location: @proposal }
      else
        @homework = Homework.find(@proposal.homework.id)
        if current_admin.phrase
          @phrase = current_admin.phrase
        else
          @phrase = ""
        end
        format.html { render :new }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @proposal.update(proposal_params)
        format.html { redirect_to @proposal, notice: 'Proposal was successfully updated.' }
        format.json { render :show, status: :ok, location: @proposal }
      else
        format.html { render :edit }
        format.json { render json: @proposal.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @proposal.destroy
    respond_to do |format|
      format.html { redirect_to proposals_url, notice: 'Proposal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proposal
      @proposal = Proposal.find(params[:id])
    end

    def set_homework
      @homework = Homework.find(params[:id_homework])
    end

    def own_admin
      if @proposal.admin.id != current_admin.id
        redirect_to root_path, notice: "No estas autorizado"
      end
    end

    def check_clabe
      if(current_admin.open_pay_clabe_id.nil?)
        redirect_to clabeAccount_path, notice: "Ingresa tu CLABE para recibir pagos antes de empezara subir propuestas."
      end
    end

    def check_phrase
      if (current_admin.phrase.length <= 1)
        redirect_to phrase_path, notice: "Escribe tu frase antes de subir propuestas."
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def proposal_params
      params.require(:proposal).permit(:admin_id, :homework_id, :cost, :notes, :status, :deadline)
    end
end
