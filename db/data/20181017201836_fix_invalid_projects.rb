class FixInvalidProjects < ActiveRecord::Migration[5.2]
  def up
    Project.all.each do |project|
      unless project.valid?
        begin
          project.slug = SecureRandom.urlsafe_base64
          project.save!
        rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid => e
          if project.errors[:slug].any?
            retry
          else
            raise e
          end
        end
      end
    end
  end

  def down; end
end
