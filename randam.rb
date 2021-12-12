#カプセルの順番---------------------------------------------
#引数
#戻り値
def NewCapsuleRand()
  new_capsule_rand = [[1, 2, 3, 4, 5, 6], [2, 1, 3, 5, 4, 6], [1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6], [1, 2, 3, 4, 5, 6]]    
  return new_capsule_rand[rand(2)]
end
#ゲームクリアの判定ここまで----------------------------------

#カプセルの順番---------------------------------------------
#引数
#戻り値
def NewCapsuleFlag(new_capsule_array)
  new_capsule_array.each_with_index do |x, id|
    if(x != 0)
      p new_capsule_array
      return id
    end
  end
end
#ゲームクリアの判定ここまで----------------------------------

new_capsule_array = Array.new(6, 0);
NewCapsule(new_capsule_array)
NewCapsule(new_capsule_array)