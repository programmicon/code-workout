require 'factory_girl'

namespace :db do
  desc "Reset database and then fill it with sample data"
  task populate: [:environment, :reset] do
    FactoryGirl.create(:organization)
    FactoryGirl.create(:term)
    FactoryGirl.create(:term2)
    FactoryGirl.create(:course)
    c = FactoryGirl.create(:course_offering)
    FactoryGirl.create(:course_offering2)

    FactoryGirl.create(:course_enrollment,
      user: FactoryGirl.create(:admin),
      course_offering: c,
      course_role: CourseRole.instructor)
    FactoryGirl.create(:course_enrollment,
      user: FactoryGirl.create(:instructor_user,
        first_name: 'Ima',
        last_name:  'Teacher',
        email:      "example-1@railstutorial.org"),
      course_offering: c,
      course_role: CourseRole.instructor)
    50.times do |n|
      FactoryGirl.create(:course_enrollment,
        user: FactoryGirl.create(:confirmed_user,
          first_name: Faker::Name.first_name,
          last_name:  Faker::Name.last_name,
          email:      "example-#{n+2}@railstutorial.org"),
        course_offering: c)
    end

    # Create a workout with one exercise, and a second exercise
    FactoryGirl.create :workout_with_exercises
    FactoryGirl.create :coding_exercise, name: 'Factorial 3'
  end

#  task exercises: :environment do
#  end

end
