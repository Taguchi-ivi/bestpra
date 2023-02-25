
# Level_listのマスタ情報を指定
names = Array['all', '小学生', '中学生', '高校生', '大学生以上']

for name in names do
    # オブジェクトが存在するか確認し、なかったら投入
    level = LevelList.find_or_initialize_by(name: name)

    if level.new_record?
        level.name = name
        level.save!
    end
end