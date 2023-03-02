
tag_count = TagList.count

# tag_listのマスタ情報を指定
names = [
    'シュート',
    'ドリブル',
    'パス回し',
    'ボールコントロール',
    'ゲーム',
    'アジリティ',
    'ボールフィーリング',
    '突破',
    'ボールを失わない',
    'ボールを奪う',
    'ゴールキーパー',
    '戦術',
    '筋トレ',
    'ラントレ',
    'ランニング',
    '1対1',
    '2対2',
    '3対3',
    '4対4',
    'とりかご',
    'ヘディング',
    'タッチ練習',
    'フェイント',
    'フィジカルトレーニング',
    '走力',
    '持久力',
    '瞬発力',
    '筋力トレーニング',
    'ポジショニング',
    '守備練習',
    'マンツーマンディフェンス',
    'ゾーンディフェンス',
    'カバーリング',
    'プレッシング',
    '攻撃練習',
    'パターンプレー',
    'オーバーラップ',
    'クロス',
    'チェンジオブペース',
    'ゴールキーパー練習',
    'ロングキック',
    'セービング',
    'ハイクロスの取り方',
    'オフェンシブセービング',
    '視野を広げる',
    '頭を上げる',
    'スローイング',
    'コーナーキック',

]

# for name in names do
# each.names do |name|
names.length.times do |i|
    # オブジェクトが存在するか確認し、なかったら投入
    tag = TagList.find_or_initialize_by(name: names[i])

    if tag.new_record?
        tag.name = names[i]
        tag.save!
    end
end

puts "tag_lists = #{TagList.count - tag_count}"