USER_AMOUT = 5
BOOK_AMOUT = 20
GROUP_AMOUT = 10

USER_AMOUT.times do |n|
    address_list = [
      ["3771711", "群馬県", "吾妻郡", "草津町草津４０１"],
      ["1510053", "東京都", "渋谷区", "代々木４丁目６"],
      ["1608330", "東京都", "新宿区", "西新宿２丁目２−１"],
    ]
    address = address_list.sample
    User.find_or_create_by!(email: "sample#{n + 1}@sample") do |user|
        user.email = "sample#{n + 1}@sample"
        user.name = "sample#{n + 1}"
        user.password = "asdfasdf"
        user.postal_code = address[0]
        user.prefecture_code = JpPrefecture::Prefecture.find(name: address[1]).code
        user.address_city = address[2]
        user.address_street = address[3]
    end
end

BOOK_AMOUT.times do |n|
  user_id = User.pluck(:id).sample
  # book_content = rand(100..999)
  book = Book.create!(
    user_id: user_id,
    title: Faker::Book.title,
    body: Faker::Lorem.sentence(word_count: 5),
    created_at: rand(Time.current.weeks_ago(1).beginning_of_week(start_day= :saturday)..Time.zone.now.end_of_day)
  )
  
  # タグ付け
  tag_num= rand(1..3)
  tag_list = ActsAsTaggableOn::Tag.new
  book.tag_list = (1..tag_num).map {|x| Faker::Book.genre}
  book.save


end

(BOOK_AMOUT*2).times do |n|
  user_id = User.pluck(:id).sample
  book_id = Book.pluck(:id).sample
  unless Favorite.find_by(user_id: user_id, book_id: book_id)
    Favorite.create!(
      user_id: user_id,
      book_id: book_id
    )
  end
end

(USER_AMOUT*2).times do |n|
  follower_id = User.pluck(:id).sample
  followed_id = User.pluck(:id).sample
  if Relationship.find_by(follower_id: follower_id, followed_id: followed_id).nil? && follower_id != followed_id
    Relationship.create!(
      follower_id: follower_id,
      followed_id: followed_id
    )
  end
end
