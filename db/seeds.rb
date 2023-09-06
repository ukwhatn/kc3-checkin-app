# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

groups = [
  "大阪工業大学 HxSコンピュータ部",
  "大阪工業大学 デザイン思考実践研究部",
  "大阪大学 大阪大学コンピュータクラブ",
  "関⻄大学 電気通信工学研究会",
  "関⻄学院大学 プログラミング研究会 Tech.Uni",
  "京都工芸繊維大学コンピュータ部",
  "京都産業大学 電子計算機応用部",
  "京都産業大学 エンジニアコミュニティ あまてく",
  "近畿大学 KINDAI Info-Tech HUB",
  "近畿大学 電子計算機研究会",
  "甲南大学 甲南大学文化会KSWL 技術部門",
  "同志社大学 電気情報研究会",
  "立命館大学 立命館コンピュータクラブ",
  "立命館大学 情報理工学部プロジェクト団体 RiG++",
  "立命館大学 情報理工学部プロジェクト団体 RiST",
  "立命館大学 情報理工学部プロジェクト団体 Ri-one",
  "和歌山大学 クリエゲーム制作プロジェクト",
  "インカレ watnow",
  "その他",
  "無所属"
]

groups.each do |group|
  unless Group.find_by(name: group)
    puts "create group: #{group}"
    Group.create(name: group)
  end
end
