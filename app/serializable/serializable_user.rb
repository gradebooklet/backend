# app/serializable/SerializableUser.rb
class SerializableUser < JSONAPI::Serializable::Resource
  type 'users'

  attributes :email, :username
end