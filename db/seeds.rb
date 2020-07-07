User.create(email: 'example@example.com')

Project.create(id: '1', user_id: '1', title: 'test_project', slug: 'bbbb',
  private: '1', secret_enabled: '1')

Page.create(title: 'about_qkspace_page', source: 'QKspace (произносится как «быстрое
 пространство») является минималистической базой знаний для небольших команд.',
 id: '2', project_id: '1')

Page.create(title: 'description_qkspace_page', source: 'Он идеально подходит
  для создания справочной базы курсов для образовательной организации, для
  составления списка QnA в ИТ, для обмена знаниями в социальных группах, для
  cоставления тематического списка личных цитат и заметок.',
  id: '3', project_id: '1')
