#ゲームクリアの判定
#引数　banmen: 薬やウイルスの盤面
#戻値　0: ゲームクリアしていない, 1: ゲームクリア
def GameClear(banmen)
  banmen.each do |x| #盤面のチェック
    #判定
    if(x == 1) #ウイルスがあったらなら1を返す
      return 0
    end
  end
  return 1 #ここまで来たらゲームクリア
end

#ゲームオーバーの判定
#引数　banmen: 薬やウイルスの盤面
#戻値　0: ゲームオーバーしていない, 1: ゲームオーバー
def GameOver(banmn)
  banmen.each do |x|
    if(banmen != 0) #盤面上部が空きでないならゲームオーバー
      return 1
    end
  end
  return 0 #ここまで来たらゲームオーバーしてない
end
