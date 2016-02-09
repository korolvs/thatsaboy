# Photo delete command
class File::Command::PhotoDeleteCommand < Core::Command
  attr_accessor :id

  validates :id, presence: true,
                 'Core::Validator::Exists' => ->(x) { { id: x.id, deleted_at: nil } }

  # Runs command
  def execute
    photo = File::Photo.where(id: id, deleted_at: nil).first
    photo.deleted_at = DateTime.now.utc
    photo.save
    nil
  end

  # Get the model to validate
  # @return [Class]
  def model_to_validate
    File::Photo
  end
end