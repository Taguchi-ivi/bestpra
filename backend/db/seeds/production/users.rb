user_count = User.count

# userのマスタ情報を指定
# nicknames = [
#     'meron',
#     'サッカー小僧',
#     'ロナウド',
#     'ペレ',
#     'メッシ',
#     '竈門炭治郎',
#     '禰󠄀豆子',
#     '怪盗キッド',
#     'クレヨンしんちゃん',
#     'リオネルメッシ大好き',
# ]

# nicknames.length.times do |i|
#     # オブジェクトが存在するか確認し、なかったら投入
#     user = User.find_or_initialize_by(nickname: nicknames[i])

#     if user.new_record?
#         user.nickname = names[i]
#         user.email = "#{[i]}useruser@example.com"
#         user.password = "passwordpassword"
#         user.activated = true
#         user.save!
#     end
# end

puts "users = #{User.count - user_count}"