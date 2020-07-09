User.create(email: 'example@example.com')

Project.create(id: '1', user_id: '1', title: 'test project', slug: 'bbbb',
  private: '1', secret_enabled: '1')

Page.create(title: 'About qkspace project', source: 'QKspace (pronounced "quick space")
  is a minimalistic knowledge base for small teams.',
  id: '2', project_id: '1')

Page.create(title: 'Description qkspace project', source: 'It is perfect for creating
  a course reference base for an educational organisation, for making a QnA list in the IT,
  for exchanging knowledge within social work teams, for making a thematic list
  of personal quotes and notes.',
  id: '3', project_id: '1')
