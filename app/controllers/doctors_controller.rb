class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /doctors
  def index
    if params[:search].present? || params[:specialization].present? || params[:experience_years].present?
      @doctors = search_doctors.page(params[:page]).per(params[:per_page] || 10)
    else
      @doctors = Patient.page(params[:page]).per(params[:per_page] || 10)
    end

    render json: @doctors
  end

  # GET /doctors/1
  def show
    render json: @doctor
  end

  # POST /doctors
  def create
    @doctor = current_user.doctors.build(doctor_params)

    if @doctor.save
      render json: @doctor, status: :created, location: @doctor
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /doctors/1
  def update
    if @doctor.update(doctor_params)
      render json: @doctor
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /doctors/1
  def destroy
    @doctor.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def doctor_params
    params.require(:doctor).permit(:name, :specialization, :experience_years)
  end

  def search_patients
    query = Doctor.all

    query = query.where("name LIKE ?", "%#{params[:search]}%") if params[:search].present?
    query = query.where(experience_years: params[:experience_years]) if params[:experience_years].present?
    query = query.where(specialization: params[:specialization]) if params[:specialization].present?

    query
  end
end