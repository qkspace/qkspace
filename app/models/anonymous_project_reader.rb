class AnonymousProjectReader
  def initialize(project:)
    @project = project
  end

  def collaborates?(project)
    project.id == @project.id
  end

  def edits?(project)
    false
  end

  def projects
    Project.where(id: project.id)
  end

  def owned_projects
    Project.none
  end
end
