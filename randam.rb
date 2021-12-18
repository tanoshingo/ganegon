#カプセルの順番のパターン選び(没)----------------------------
#引数　なし
#戻り値　カプセルの順番のパターン
#def NewCapsuleRand()
#  #カプセルの順番のパターン候補
#  new_capsule_rand = [[1, 2, 3, 4, 5, 6], [2, 1, 3, 5, 4, 6], [1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6]]    
#  return new_capsule_rand[rand(2)] #カプセルの順番のパターンを候補から選んで返す
#end
#カプセルの順番のパターン選びここまで------------------------

#盤面のウイルス選び------------------------------------------
#引数　banmen: 薬やウイルスの盤面, virus_num: 配置するウイルスの個数
#戻り値　なし
def NewMap(banmen, virus_num)
  virus_num.times do #ウイルスの個数続ける
    loop{
      x = rand(1..8) #ウイルスのx座標
      y = rand(6..18) #ウイルスのy座標
      if(banmen[y][x] == 0) #空いていたらウイルスの色を決めて代入
        banmen[y][x] = rand(0..2)
        break
      end
      #空いていないなら続行
    }
  end
end
#盤面のウイルス選びここまで----------------------------------

#カプセルの順番が取り出せるのかのフラグ(没)------------------
#引数　new_capsule_array: NewCapsuleRand()で作ったカプセルの順番のパターン
#戻り値　t: カプセルの順番を返す, 100: カプセルの順番が取り出せないとき(NewCapsuleRand()を行う)
#def NewCapsuleFlag(new_capsule_array)
#  new_capsule_array.each_with_index do |x, id|
#    if(x != 0) #要素が0出ないならカプセルの順番を返す
#      p new_capsule_array
#      t = new_capsule_array[id] #カプセルの順番を保存しておく
#      new_capsule_array[id] = 0 #カプセルの順番消す保存しておく
#      return t
#    end
#  end
#  p "/////////"
#  return 100 #ここまで来たらカプセルの順番が取り出せないので100を返す
#end
#ゲームクリアの判定ここまで----------------------------------

banmen = Array.new(20){Array.new(10, 0)}
NewMap(banmen, 10)
p banmen

