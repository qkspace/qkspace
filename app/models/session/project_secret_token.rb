class Session::ProjectSecretToken < Session
  belongs_to :project

  def user
    AnonymousProjectReader.new(project: project)
  end
end
