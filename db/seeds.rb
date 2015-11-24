class Seed
  def buckets
    [
      { name: "Life events", created_by: 1 },
      { name: "Things I wanna do", created_by: 2 },
      { name: "Must do before laying on death bed", created_by: 3 },
      { name: "Career events", created_by: 1 }
    ]
  end

  def items
    [
      { name: "Play in la liga", done: true, bucketlist_id: 1 },
      { name: "Play in serie A", done: true, bucketlist_id: 2 },
      { name: "Play in NPL", bucketlist_id: 1 },
      { name: "Play in la liga", bucketlist_id: 3 },
      { name: "Win the world cup", bucketlist_id: 2 },
      { name: "Win the premier league", bucketlist_id: 1 },
      { name: "Win UCL", bucketlist_id: 1 },
      { name: "Become a coach", bucketlist_id: 3 },
      { name: "Top assists", bucketlist_id: 4 }
    ]
  end

  def users
    [
      { username: "ozil", password: "1234567890" },
      { username: "alexis", password: "1234567890" },
      { username: "koscienly", password: "1234567890" }
    ]
  end

  def creator
    Bucketlist.destroy_all
    User.destroy_all
    Item.destroy_all
    users.each { | user | User.create(user) }
    buckets.each { | bucket | Bucketlist.create(bucket) }
    items.each { | item | Item.create(item) }
  end

end

sample_data = Seed.new
sample_data.creator