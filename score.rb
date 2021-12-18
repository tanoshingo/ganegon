#追加スコア計算----------------------------------------------
#引数　mode: ゲームモード(落下の速さ), rensa: ウイルスを消した連鎖数
#戻り値　add_score: 追加スコア
def Score(mode, rensa)
  add_score = 0
  #ゲームモード毎に追加スコアの基礎点の設定
  if(mode == low) #低速のとき
      basic_score = 100
  elsif(mode == mid) #中速のとき
      basic_score = 200
  else #高速のとき
      basic_score = 300
  end
  
  rensa.times do |id| #追加スコアの連鎖点
    add_score +=  Math.ldexp(basic_score, id)
  end
  return add_score
end
#盤面のウイルス選びここまで----------------------------------

#テスト用
#p Score(1, 5)