
level_count = LevelList.count

# Level_listのマスタ情報を指定
names = [
    'all',
    '小学生',
    '中学生',
    '高校生',
    '大学生以上'
]

# for name in names do
# each.names do |name|
names.length.times do |i|
    # オブジェクトが存在するか確認し、なかったら投入
    level = LevelList.find_or_initialize_by(name: names[i])

    if level.new_record?
        level.name = names[i]
        level.save!
    end
end

puts "level_lists = #{LevelList.count - level_count}"