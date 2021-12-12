#ゲームクリアの判定-----------------------------------------
#引数　banmen: 薬やウイルスの盤面
#戻値　0: ゲームクリアしていない, 1: ゲームクリア
def GameClearFlag(banmen)
  banmen.each do |retsu| #盤面を列ごとに分解
    retsu.each do |youso| #列を要素ごとに分解
      #判定
      if(youso == 1) #ウイルスがあったらなら1を返す
        return 0
      end
    end
  end
  return 1 #ここまで来たらゲームクリア
end
#ゲームクリアの判定ここまで----------------------------------

#ゲームオーバーの判定----------------------------------------
#引数　banmen: 薬やウイルスの盤面
#戻値　0: ゲームオーバーしていない, 1: ゲームオーバー
def GameOverFlag(banmen)
  banmen[1].each do |youso| #盤面上部を要素ごとに分解
    #判定
	if(youso != Field.EMPTY) #空きでないならゲームオーバー
      return 1
    end
  end
  return 0 #ここまで来たらゲームオーバーしてない
end
#ゲームオーバーの判定ここまで---------------------------------

#以下, デバッグ用
#banmen = [[0, 0] , [0, 1], [0, 0]]
#p GameOver(banmen);
