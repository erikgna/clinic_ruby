class MedicalRecord < ApplicationRecord
  belongs_to :patient
  belongs_to :consultation

  def file_url
    # Implement logic to generate the S3 file URL
    # Example using aws-sdk-s3:
    # Aws::S3::Object.new(bucket_name: 'your_bucket', key: file_key).presigned_url(:get)
  end
end
