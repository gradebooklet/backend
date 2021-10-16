require 'faker'
require 'factory_bot_rails'

module UserHelpers

  # Creates user in database
  def create_user
    FactoryBot.create(:user,
                      email: Faker::Internet.email,
                      username: Faker::Internet.username,
                      password: Faker::Internet.password
    )
  end

  # Only returns user attributes
  def build_user
    FactoryBot.build(:user,
                     email: Faker::Internet.email,
                     username: Faker::Internet.username,
                     password: Faker::Internet.password
    )
  end

end