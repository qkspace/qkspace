class MistakeController < PublicController
  def create
    #set_project - this method from PublicController
    @project_title = set_project.title

    owner = set_project.owner.email
    collaborators = set_project.collaborators.map(&:email)
    @authors = [owner] + collaborators

    @authors.each do |author|
      MistakeMailer.mistake(params[:content], params[:url], author, @project_title).deliver
    end

    redirect_to root_path, notice: "Ваше сообщение с ошибкой успешно отправлено"
  end
end
