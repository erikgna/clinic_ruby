class MedicalRecordsController < ApplicationController
  before_action :set_medical_record, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /medical_records
  def index
    if params[:patient_id]
      @medical_records = MedicalRecord.where(patient_id: params[:patient_id])
    else
      @medical_records = MedicalRecord.all
    end

    @medical_records = @medical_records.page(params[:page]).per(params[:per_page] || 10)

    render json: @medical_records
  end

  # GET /medical_records/1
  def show
    render json: @medical_record
  end

  # POST /medical_records
  def create
    @medical_record = MedicalRecord.new(medical_record_params)

    if @medical_record.save
      render json: @medical_record, status: :created, location: @medical_record
    else
      render json: @medical_record.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /medical_records/1
  def update
    if @medical_record.update(medical_record_params)
      render json: @medical_record
    else
      render json: @medical_record.errors, status: :unprocessable_entity
    end
  end

  # DELETE /medical_records/1
  def destroy
    @medical_record.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_medical_record
    @medical_record = MedicalRecord.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def medical_record_params
    params.require(:medical_record).permit(:patient_id, :consultation_id, :file_key)
  end
end
