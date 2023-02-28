require 'faker'

user_count = User.count
article_count = Article.count

# meron
email = 'meron@example.com'
nickname = 'メロン'
pass = 'password'

meron = User.find_or_initialize_by(email: email, activated: true)
if meron.new_record?
    meron.email = email
    meron.nickname = nickname
    meron.password = pass
    meron.activated = true
    meron.save!

    5.times do |n|
        Article.create!(
            title: Faker::Lorem.sentence(word_count: 15),
            content: Faker::Lorem.sentence(word_count: 100),
            user_id: meron.id,
            level_list_id: 1
        )
    end
end

# choko
email = 'choko@example.com'
nickname = 'チョコ'

choko = User.find_or_initialize_by(email: email, activated: true)
if choko.new_record?
    choko.email = email
    choko.nickname = nickname
    choko.password = pass
    choko.activated = true
    choko.save!

    5.times do |n|
        choko.articles.create!(
            title: Faker::Lorem.sentence(word_count: 15),
            content: Faker::Lorem.sentence(word_count: 100),
            user_id: choko.id,
            level_list_id: 2
        )
    end
end

# コナン君
email = 'konan@example.com'
nickname = '名探偵コナン'

konan = User.find_or_initialize_by(email: email, activated: true)
if konan.new_record?
    konan.email = email
    konan.nickname = nickname
    konan.password = pass
    konan.activated = true
    konan.save!

    5.times do |n|
        konan.articles.create!(
            title: Faker::Lorem.sentence(word_count: 15),
            content: Faker::Lorem.sentence(word_count: 100),
            user_id: konan.id,
            level_list_id: 3
        )
    end
end

puts "users = #{User.count - user_count}"
puts "articles = #{Article.count - article_count}"


# 5.times do |n|
#     jon.articles.create!(title: "title#{n}", content: "content#{n}")
# end

# 5.times do |n|
#     emily.articles.create!(title: "title#{n}", content: "content#{n}")
# end