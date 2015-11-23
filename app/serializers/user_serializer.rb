class UserSerializer < ActiveModel::Serializer
  attributes :id, :username
  has_many :bucketlists, foreign_key: "created_by"
end
