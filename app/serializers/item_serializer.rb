class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :done, :date_created, :date_modified

  def date_created
    time_parser(object.created_at)
  end

  def date_modified
    time_parser(object.updated_at)
  end
end
