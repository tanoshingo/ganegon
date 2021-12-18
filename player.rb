class PLYER 
    define 
    def init
        pos = array.new(2,array(2,0)) #2x2の配列に初期形態を記憶
        pos[1][0] = 1 #カプセルA
        pos[1][1] = 2 #カプセルB
        #rempos_x = 1 #2x2マスの左上初期位置
        #rempos_y = 3    # [3][1] = [y][x]
        #pos_routeX = 1 #マスの左上の座標X
        #pos_routeY = 3 #マスの左上の座標Y
        dir_A = 3 #Aの向き 初期設定
        dir_B = 1 #Bの向き 初期設定
    end
    def update
        if Input.key_push?(K_left) then
            return x-1
        elsif Input.key_push(K_right) then
            return x+1
        elsif Input.key_push(K_UP) then
            self.rotation()
        end 
    end
    
    #Absはマップ上での値
    def rotation(Abs_x,Abs_y) #絶対座標,向き 画像は2x2でとっているから相対すぐ左上-\
        defined NONE    0
        defined LEFT    1
        defined UP      2
        defined RIGHT   3
        defined DOWN    4
        @back = 0
        @flag = 0
        @ex_pos = array.new(2,array(2,0)) #2x2の配列に初期形態を記憶
        #向きの変更 A,Bそれぞれについて
        dir_A = (dir_A + 1) % 4 +1 
        dir_B = (dir_B + 1) % 4 +1 
        #回転
            #相対のマス2x2の中での転換
            #ループで2x2の中で1=>2,2=>0
            i = 0
            while i < 2 do
                j = 0
                while j < 2 do
                    ex_pos[i][j] = pos[i][j] #exにもとの2x2を保存
                    if (pos[i][j] == 1) then #カプセルAをBに置換
                        pos[i][j] = 2
                    elsif (pos[i][j] == 2) then #カプセルBは消す
                        pos[i][j] = 0
                    end
                end
            end
            
            #相対マスの中でカプセルAの回転
            if dir_A == 1 then
                pos[0][1] = 1 
                flag = 1 #絶対座標に直すときにYを1下げる卍
            elsif dir_A == 2 then
                pos[1][1] = 1 
                flag = 0
            elsif dir_A == 3 then
                pos[1][0] = 1
            elsif dir_A == 4 then
                pos[0][0] = 1
            end
            
            #絶対のマス目での変更 Ans_x,Abs_yは絶対的な座標
            #マップに対して相対座標の値を挿入
            i = 0
            while i < 2 do
                j = 0
                while j < 2 do
                    if(flag) then #Flag ONならyを1下げる
                        Abs_y = Abs_y -1
                    end
                    if(map[Abs_y][Abs_x] != 1000000) then
                        map[Abs_y][Abs_x] = pos[i][j] #壁じゃなければ相対のマスを置く
                    else
                        back = 1           
                    end
                end
            end
            
            if(back) #逆転リバース だめなら
                dir_A = (dir_A +2) % 4 + 1 #向きのリバース
                dir_B = (dir_B +2) % 4 + 1
                i=0
                while i < 2 do #元の座標置換
                    j=0 
                    while j < 2 do
                        pos[i][j] = ex_pos[i][j]
                    end
                end
            end
            
        end
    end 