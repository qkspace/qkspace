
users = User.create([
                      { email: 'test_email@gmail.com' },
                      { email: 'test_email_1@gmail.com' }
                    ])

projects = Project.create([
                            { title: 'First test project',	slug: 'test-project',	user_id: 2,	private: 0 },
                            { title: 'Second test project',	slug: 'second-test-project', user_id: 2,	private: 0 },
                            { title: 'Third test project',	slug: 'third-test-project', user_id:	2, private: 0 },
                            { title: 'Fourth test project',	slug: 'fourth-test-project', user_id:	2, private: 0 },
                            { title: 'Fifth test project',	slug: 'fifth-test-project', user_id:	2, private: 0 }
                          ])

pages = Page.create([
                      { title: 'First test page', project_id: 1, position: 1, slug: 'first-test-page', source: '', html: '' },
                      { title: 'First test page for second test project', project_id: 2, position: 1, slug: 'first-test-page-for-second-test-project', source: '', html: '' },
                      { title: 'First test page for third test project', project_id: 3, position: 1, slug: 'first-test-page-for-third-test-project', source: '', html: '' },
                      { title: 'First test page for fourth test project', project_id: 4, position:	1, slug: 'first-test-page-for-fourth-test-project', source: '', html: '' },
                      { title: 'First test page for fifth test project', project_id: 5, position: 1, slug: 'first-test-page-for-fifth-test-project', source: '', html: '' }
                    ])

pages_update_1 = Page.where(id: (1..5)).update(
  source: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.Nam pretium scelerisque ultricies.
  Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aliquam sed interdum felis, facilisis posuere leo.',
  html: '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam pretium scelerisque ultricies.
  Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aliquam sed interdum felis, facilisis posuere leo.</p>'
)

pages_update_2 = Page.where(id: (6..10)).update(
  source: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  Integer aliquam condimentum elit vel suscipit. Phasellus nec dignissim erat, quis tempus lorem. Integer aliquet mi quis vestibulum viverra.
  Mauris quis odio risus. Nullam molestie vitae nibh quis suscipit.
  Proin maximus, ligula sit amet semper sodales, felis elit porttitor erat, eu euismod lacus nisl a eros. Aliquam erat volutpat.
  Cras varius sollicitudin lorem, sit amet molestie dui interdum vel. Vivamus malesuada semper nunc at consectetur. Nam rhoncus pulvinar tempus.
  Duis vitae dui ut nibh sollicitudin faucibus. Aliquam posuere ullamcorper ullamcorper. In tempus at magna ut porta. Duis vel egestas enim, nec consequat velit.
  Aliquam varius commodo sem, aliquet scelerisque nunc fermentum non. Nam at aliquet quam. Donec maximus interdum ex eget molestie. Nulla facilisi.
  Cras lectus nulla, elementum quis metus vel, rutrum blandit neque. Nulla vitae est molestie, blandit purus non, fringilla dui.
  Phasellus vitae quam id lacus suscipit tincidunt eu non libero. Pellentesque eu urna lobortis, hendrerit lorem quis, luctus est.
  Nunc porta pulvinar sem, id suscipit felis molestie ut. Nullam justo ex, dignissim ut lectus quis, consectetur consequat nunc.
  Duis ante tellus, facilisis non facilisis nec, maximus ut lacus.
  Suspendisse dictum, ligula vitae consectetur ullamcorper, tortor elit lobortis diam, et iaculis mi nibh nec eros. Vivamus porta laoreet sapien eu pulvinar.
  Curabitur aliquet urna quam, sagittis vestibulum nulla tempus non. Ut quis aliquam est. Integer dui velit, vestibulum nec lorem nec, placerat fermentum dui.
  Pellentesque risus tellus, venenatis auctor arcu in, fermentum consequat sem.',
  html: '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer aliquam condimentum elit vel suscipit.
  Phasellus nec dignissim erat, quis tempus lorem. Integer aliquet mi quis vestibulum viverra. Mauris quis odio risus. Nullam molestie vitae nibh quis suscipit.
  Proin maximus, ligula sit amet semper sodales, felis elit porttitor erat, eu euismod lacus nisl a eros. Aliquam erat volutpat.
  Cras varius sollicitudin lorem, sit amet molestie dui interdum vel. Vivamus malesuada semper nunc at consectetur. Nam rhoncus pulvinar tempus.
  Duis vitae dui ut nibh sollicitudin faucibus. Aliquam posuere ullamcorper ullamcorper.
  In tempus at magna ut porta. Duis vel egestas enim, nec consequat velit. Aliquam varius commodo sem, aliquet scelerisque nunc fermentum non.</p><br>
  <p>Nam at aliquet quam. Donec maximus interdum ex eget molestie. Nulla facilisi. Cras lectus nulla, elementum quis metus vel, rutrum blandit neque.
  Nulla vitae est molestie, blandit purus non, fringilla dui. Phasellus vitae quam id lacus suscipit tincidunt eu non libero.</p>
  <p>Pellentesque eu urna lobortis, hendrerit lorem quis, luctus est. Nunc porta pulvinar sem, id suscipit felis molestie ut.
  Nullam justo ex, dignissim ut lectus quis, consectetur consequat nunc. Duis ante tellus, facilisis non facilisis nec, maximus ut lacus. Suspendisse dictum,
  ligula vitae consectetur ullamcorper, tortor elit lobortis diam, et iaculis mi nibh nec eros.</p><br>
  Vivamus porta laoreet sapien eu pulvinar. Curabitur aliquet urna quam, sagittis vestibulum nulla tempus non. Ut quis aliquam est.
  Integer dui velit, vestibulum nec lorem nec, placerat fermentum dui. Pellentesque risus tellus, venenatis auctor arcu in, fermentum consequat sem.</p>')
