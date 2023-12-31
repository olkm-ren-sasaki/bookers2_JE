USER_AMOUT = 5
BOOK_AMOUT = 20
GROUP_AMOUT = 10

USER_AMOUT.times do |n|
    User.find_or_create_by!(email: "sample#{n + 1}@sample") do |user|
        user.email = "sample#{n + 1}@sample"
        user.name = "sample#{n + 1}"
        user.password = "asdfasdf"
    end
end

BOOK_AMOUT.times do |n|
  user_id = User.pluck(:id).sample
  book_content = rand(100..999)
  Book.create!(
    user_id: user_id,
    title: "sample-#{user_id}-#{book_content}",
    body: "sample#{user_id}-#{book_content}",
    created_at: rand(Time.current.weeks_ago(1).beginning_of_week(start_day= :saturday)..Time.zone.now.end_of_day)
  )
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
