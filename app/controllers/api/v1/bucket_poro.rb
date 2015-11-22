class Api::V1::BucketlistsController
  class BucketPoro
    def bucket_info(info)
        {
          bucket_id: info.id,
          bucket_creation_time: info.created_at,
          bucket_update_time: info.updated_at,
          bucket_name: info.name,
          bucket_creator: info.created_by
        }
    end

    def user_bucket(data,item)
      {
        id: data[:bucket_id],
        name: data[:bucket_name],
        items: item_data(item),
        date_created: time_parser(data[:bucket_creation_time]),
        date_modified: time_parser(data[:bucket_update_time]),
        created_by: data[:bucket_creator]
      }
    end

    def time_parser(time_data)
      time_data.to_time.strftime("%Y-%m-%d %H:%M:%S")
    end

    def item_data(item)
      item_arr = []
      item.each do | i |
        item_arr << {
                      id: i.id,
                      name: i.name,
                      date_created: time_parser(i.created_at),
                      date_modified: time_parser(i.updated_at),
                      done: i.done
                    }
      end
      item_arr
    end

    def data_formatter(bucket_data)
      data = bucket_info(bucket_data)
      item = bucket_data.items
      user_bucket(data,item)
    end

  end
end