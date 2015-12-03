class Seeded
  def buckets
    [
      { name: "Life events", created_by: 1 },
      { name: "Things I wanna do", created_by: 2 }
    ]
  end

  def items
    [
      { name: "Play in la liga", done: true, bucketlist_id: 1 },
      { name: "Play in serie A", done: true, bucketlist_id: 2 },
      { name: "Play in NPL", bucketlist_id: 1 },
      { name: "Win the world cup", bucketlist_id: 2 },
      { name: "Win the premier league", bucketlist_id: 1 }
    ]
  end

  def users
    [
      { username: "ozil", password: "asdfghjkl" },
      { username: "alexis", password: "asdfghjkl" }
    ]
  end

  def creator
    users.each { |user| User.create(user) }
    buckets.each { |bucket| Bucketlist.create(bucket) }
    items.each { |item| Item.create(item) }
  end
end
