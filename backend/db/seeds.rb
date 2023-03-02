# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

table_names = %w(
    users
    level_lists
    articles
    tag_lists
)

table_names.each do |table_name|
    path = Rails.root.join("db/seeds/#{Rails.env}/#{table_name}.rb")

    # ファイルが存在しない場合はdevelopmentディレクトリを読み込む
    # path = path.sub(Rails.env, "development") unless File.exist?(path)
    puts "#{table_name}..."
    if File.exist?(path)
        require path
    else
        puts "File not found: #{path}"
    end
end