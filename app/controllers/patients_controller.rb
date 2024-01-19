class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /patients
  def index
    if params[:search].present? || params[:age].present? || params[:gender].present? || params[:diagnosis].present?
      @patients = search_patients.page(params[:page]).per(params[:per_page] || 10)
    else
      @patients = Patient.page(params[:page]).per(params[:per_page] || 10)
    end

    render json: @patients
  end

  # GET /patients/1
  def show
    render json: @patient
  end

  # POST /patients
  def create
    @patient = current_user.patients.build(patient_params)

    if @patient.save
      render json: @patient, status: :created, location: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /patients/1
  def update
    if @patient.update(patient_params)
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # DELETE /patients/1
  def destroy
    @patient.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(:name, :age, :gender, :diagnosis)
    end

    def search_patients
      query = Patient.all
  
      query = query.where("name LIKE ?", "%#{params[:search]}%") if params[:search].present?
      query = query.where(age: params[:age]) if params[:age].present?
      query = query.where(gender: params[:gender]) if params[:gender].present?
      query = query.where("diagnosis LIKE ?", "%#{params[:diagnosis]}%") if params[:diagnosis].present?
  
      query
    end
end
