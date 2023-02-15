10.times do |n|
    nickname = "user#{n}"
    email = "#{nickname}@example.com"

    # オブジェクトが存在するか確認し、なかったら投入
    user = User.find_or_initialize_by(email: email, activated: true)

    if user.new_record?
        user.nickname = nickname
        user.password = "password"
        user.save!
    end
end

puts "users = #{User.count}"