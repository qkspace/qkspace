# Note: if this file contains > N factories — refactor into factories/*.rb files
# (N is determined by your conscience)

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
  end

  factory :project do
    sequence(:title) { |n| "Project #{n}" }
    sequence(:slug) { |n| "slug#{n}" }
    add_attribute(:private) { false }

    association :owner, factory: :user
  end

  factory :page do
    sequence(:title) { |n| "Page #{n}" }
<<<<<<< HEAD
    sequence(:slug) { |n| "slug#{n}" }
    sequence(:position) { |n| n }
=======
>>>>>>> upstream2/master
    sequence(:source) { |n| "# Header #{n}!\r\nText" }

    association :project
  end
<<<<<<< HEAD
end
=======
end
>>>>>>> upstream2/master
