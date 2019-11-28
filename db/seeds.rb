User.create!(name: "phan hoang hieu",
             email: "hieupeo1234@gmail.com",
             password: "123456",
             password_confirmation: "123456",
             role: 0)

8.times do |n|
  name  = Faker::Name.name
  email = "tuoanh-#{n+1}@gmail.com"
  User.create!(name: name,
               email: email,
               password: "123456",
               password_confirmation: "123456")
end

5.times do |n|
  name  = "Khai mở máy chủ mới S#{n+1}"
  description = "Chào đón các vị Thuyền Trưởng chinh phục những thử thách tại Kho Báu Huyền Thoại, máy chủ S#{n+1} chính thức khai mở vào lúc 09h00 ngày #{n+3}/08/2019 "
  Topic.create!(name: name,
               description: description)
end

users = User.where "id <= 8"
topic = Topic.where("id <= 5").count
2.times do
  users.each do |user|
    for i in 1..topic do
      user.posts.create(content: content = Faker::Lorem.sentence(word_count: 60), topic_id: i)
    end
  end
end
