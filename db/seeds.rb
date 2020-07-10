User.create(email: 'example@example.com')

Project.create(id: '1', user_id: '1', title: 'QKspace Test Project ', slug: 'test',
  private: '1', secret_enabled: '1')

Page.create(title: 'About Qkspace Project', source: 'QKspace (pronounced "quick space")
  is a minimalistic knowledge base for small teams.',
  id: '2', project_id: '1')

Page.create(title: 'Description Qkspace Project', source: 'It is perfect for creating
  a course reference base for an educational organisation, for making a QnA list in the IT,
  for exchanging knowledge within social work teams, for making a thematic list
  of personal quotes and notes.',
  id: '3', project_id: '1')
