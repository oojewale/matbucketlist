class BucketlistSerializer < ActiveModel::Serializer
  attributes :id, :name, :items, :date_created, :date_modified, :created_by
  has_many :items

  def date_created
    time_parser(object.created_at)
  end

  def date_modified
    time_parser(object.updated_at)
  end
end
