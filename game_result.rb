#ゲームクリアの判定-----------------------------------------
#引数　banmen: カプセルやウイルスの盤面
#戻値　0: ゲームクリアしていない, 1: ゲームクリア
def GameClearFlag(banmen)
  banmen.each do |gyou| #盤面を行ごとに分解
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
#引数　banmen: カプセルやウイルスの盤面
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


#追加スコア計算-----------------------------------------------
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
#追加スコア計算ここまで---------------------------------------


=begin
(没)
def MaxArray(a)
  max = 0
  a.each do |x|
    if(x > max)
        max = x
    end
  end
  return max
end


#消し判定(没)-----------------------------------------------------
#引数　mode: ゲームモード(落下の速さ), rensa: ウイルスを消した連鎖数
#戻り値　add_score: 追加スコア
def Delete(banmen, x, y, n)
  color = banmen[y][x]
  a = Array.new(4, 0)
  
  if(x+1 <= 8 && banmen[y][x+1] = color)
    a[0] = Delete(banmen, x+1, y  , n+1)
  end
  if(y+1 <= 18 && banmen[y+1][x] = color)
    a[1] = Delete(banmen, x  , y+1, n+1)
  end
  if(x-1 >= 1 && banmen[y][x-1] = color)
    a[2] = Delete(banmen, x-1, y  , n+1)
  end
  if(y-1 >=1 && banmen[y-1][x] = color)
    a[3] = Delete(banmen, x  , y-1, n+1)
  end
  
  if(MaxArray(a) >= 4)
    banmen_t[y][x] = 1
  end
end
#消し判定ここまで---------------------------------------------
=end

#カプセルとウイルスを消す判定の配列生成-----------------------
#引数　banmen_t: 消す判定の配列, renozoku: 連続した個数, (idx, idy): 連続した中で一番後ろの座標, gyouretsu_flag: 行(横並び)か列(縦並び)か(true:行, false: 列)
#戻り値　なし
def AddDeleteFlag(banmen_t, renzoku, idx, idy, gyouretsu_flag)
    if(renzoku >= 4)  #4つ以上連続していたら
      renzoku.times do |id|
        if(gyouretsu_flag)  #行に代入
          banmen_t[idy+1][idx-id] = 1
        else  #列に代入
          banmen_t[idy-id][idx+1] = 1
        end
      end
    end
end
#カプセルとウイルス消す判定の配列生成ここまで-----------------


#消す判定-----------------------------------------------------
#引数　banmen: カプセルやウイルスの盤面
#戻り値　banmen_t: 消す判定の配列
def Delete(banmen)
  banmen_t = Array.new(20){Array.new(10, 0)}  #消す判定の配列生成
  
  #行方向
  gyouretsu_flag = true  #調べているのが行方向か列方向かのフラグ(true:行, false: 列)
  18.times do |idy|  #行に分解
    renzoku = 0  #連続回数の初期化
    8.times do |idx|
      if(banmen[idy+1][idx+1] != banmen[idy+1][idx])  #今調べている要素 ≠ 1つ前に調べていた要素
        AddDeleteFlag(banmen_t, renzoku, idx, idy, gyouretsu_flag)
        renzoku = 1  #連続回数の初期化して1増やす(要するに1にする)
      else  #今調べている要素 = 1つ前に調べていた要素
        renzoku += 1  #連続回数を1増やす
      end
    end
    AddDeleteFlag(banmen_t, renzoku, 7, idy, gyouretsu_flag)
  end
  
  #列方向
  gyouretsu_flag = false
  8.times do |idx|  #列に分解
    renzoku = 0  #連続回数の初期化
    18.times do |idy|
      if(banmen[idy+1][idx+1] != banmen[idy][idx+1])  #今調べている要素 ≠ 1つ前に調べていた要素
        AddDeleteFlag(banmen_t, renzoku, idx, idy, gyouretsu_flag)
        renzoku = 1  #連続回数の初期化して1増やす(要するに1にする)
      else  #今調べている要素 = 1つ前に調べていた要素
        renzoku += 1  #連続回数を1増やす
      end
    end
    AddDeleteFlag(banmen_t, renzoku, idx, 17, gyouretsu_flag)
  end
  return banmen_t
end
#消す判定ここまで----------------------------------------------


#以下, デバッグ用

#banmen = [[0] , [0, 1], [0, 0]]
#p GameOver(banmen)
#p Score(1, 5)

=begin
banmen = Array.new(20){Array.new(10, 0)}
18.times do |idy|  #行方向
  8.times do |idx|
    banmen[idy+1][idx+1] = rand(1..3)
  end
end

banmen.each do |gyou|
  p gyou
end
print "\n\n"
Delete(banmen).each do |gyou|
  p gyou
end
=end
