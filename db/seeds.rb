user = User.create(email: 'example@example.com')

project = Project.create(user_id: user.id, title: 'QKspace Test Project ', slug: 'test',
  private: '1', secret_enabled: '1')

Page.create(project_id: project.id, title: 'About QKspace', source: 'QKspace (pronounced "quick space")
  is a minimalistic knowledge base for small teams.')

Page.create(project_id: project.id, title: 'QKspace Project Description', source: 'It is perfect for creating
  a course reference base for an educational organisation, for making a QnA list in the IT,
  for exchanging knowledge within social work teams, for making a thematic list
  of personal quotes and notes.')
