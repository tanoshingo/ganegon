# coding: utf-8
require 'dxopal';
include DXOpal

Image.register(:medic, "image/REAL_YAKU.png")    #薬の画像
require_remote 'main_menu_method.rb'
require_remote 'randam.rb'

Image.register(:back, "image/back.png")  #背景の画像
Image.register(:enemy, "image/uirusu.png")  #ウイルスの画像
Image.register(:heart, "image/heart.png")  #ハートの画像
Image.register(:light, "image/koutakumi.png")   #光沢の画像

#ウィンドウの初期設定
Window.width = 1200
Window.height = 800
Window.bgcolor = C_WHITE

#クラス定義・メソッド定義-------------------------------------------------------------------------


#medic用のクラス
class Medic
    
    attr_accessor :x, :y, :dir, :color, :mode
    
    def initialize()
        
        #色
        @BLUE = 0
        @RED = 1
        @YELLOW = 2
        @color = rand(0..2)
        
        #向き（左1、上2、右3、下4）
        @dir
        
        #くっついているかどうか
        @connecting = 1
        
        #どの状態か（queue内部 or 操作中 or 設置済み）
        @QUEUEING = 0
        @PLAYING = 1
        @PUTTED = 2
        @mode = @PLAYING
        
        @x = 4
        @y = 1
        
        @medics = Image[:medic].slice_tiles(3, 2)    #薬の画像を分割（配列化、medics[0]～medics[5]）
        @light = Image[:light]
        
        @move_count = 0 #move_countを1ずつ増やしてLIMITになったら下に落とす
        @LIMIT = 10
    end
        
    def draw()
        
        @default_x = 440    #X方向の開始座標
        @default_y = 100    #Y方向の開始座標
        @mapchip_size = 34
        p "color:{#@color}"
        
        if (@dir == 1) then
            Window.draw_ex(@x * @mapchip_size + @default_x - 5, @y * (@mapchip_size - 1) + @default_y + 2, @medics[@color], {scale_x: 2.0, scale_y: 2.0})
            #Window.draw_ex(@x * @mapchip_size + @default_x - 26, @y * (@mapchip_size - 1) + @default_y, @light, {scale_x: 2.0, scale_y: 2.0})
        elsif(@dir == 3)
            Window.draw_ex(@x * @mapchip_size + @default_x + 3, @y * (@mapchip_size - 1) + @default_y + 2, @medics[@color], {angle: 180, scale_x: 2.0, scale_y: 2.0})
        end
    end
    
    def move(map, moves, i)
        
        if (moves > 190) then
            
        elsif (moves == -1)
            
            @x -= 1
            @move_count = 0
            if ((map[@y][@x] != 0 && i == 0) || (map[@y][@x - 1] != 0 && i == 1)) then
                
                @x += 1
            end
        elsif (moves == 1)
            
            @x += 1
            @move_count = 0
            if ((map[@y][@x] != 0 && i == 1) || (map[@y][@x + 1] != 0 && i == 0)) then
                
                @x -= 1
            end
        elsif (moves == 2)
            
            @y += 1
            @move_count = 0
        end
        
        @move_count += 1
        if (@move_count == @LIMIT) then
            
            @move_count = 0
            @y += 1
        end
        if (map[@y][@x] != 0) then
            
            @y -= 1
            @mode = @PUTTED
        end
    end
end

#概　要：field用のクラス
class Field
    
    attr_accessor :map, :dir_map, :virus, :bottle_chip, :FIELD_X, :FIELD_Y

    def initialize()
        
        @FIELD_Y = 20   #マップのYの大きさ
        @FIELD_X = 10   #マップのXの大きさ
        
        @EMPTY = 0
        @WALL = 1000000
        
        #フィールド全体の変数を宣言
        @map = Array.new(@FIELD_Y) { Array.new(@FIELD_X, @EMPTY) }
        @dir_map = Array.new(@FIELD_Y) { Array.new(@FIELD_X, @EMPTY) }
        
        #画像データを格納する変数
        @medics = Image[:medic].slice_tiles(3, 2)    #薬の画像を分割（配列化、medics[0]～medics[5]）
        @virus = Image[:enemy].slice_tiles(2, 2) #ウイルスの画像を分割（配列化、virus[0]～virus[2]）
        @bottle_chip = Image.new(34, 34, [125, 125, 125]) #薬瓶のbit画像を生成
        @empty_chip = Image.new(34, 34, [0, 0, 0]) #薬瓶のbit画像を生成

        #壁を生成
        (@FIELD_Y).times do |y|
            
            (@FIELD_X).times do |x|
                
                @map[y][x] = 0
                
                if (x == 0 || x == @FIELD_X - 1 || y == 0 || y == @FIELD_Y - 1) then    #壁を設置
                    
                    @map[y][x] = @WALL
                else
                    
                    @map[y][x] = @EMPTY
                end
                
                x += 1
            end
            y += 1
        end
        #薬が降ってくる場所には穴をあける
        @map[0][4] = @EMPTY
        @map[0][5] = @EMPTY
        
        @move_count = 0 #move_countを1ずつ増やしてLIMITになったら下に落とす
        @LIMIT = 10
    end
    
    #概　要：マップの描画
    #引　数：なし
    #戻り値：なし
    def draw()
        
        @default_x = 430    #X方向の開始座標
        @default_y = 90    #Y方向の開始座標
        @mapchip_size = 34  #1マスあたりのサイズ
        
        y = 0
        while y < @FIELD_Y do
            
            x = 0
            while x < @FIELD_X do
                
                Window.draw(x * @mapchip_size + @default_x, y * @mapchip_size + @default_y, @empty_chip)    #背景を描画
                
                if (@map[y][x] == @WALL) then   #壁を描画
                    Window.draw(x * @mapchip_size + @default_x, y * @mapchip_size + @default_y, @bottle_chip)
                    
                elsif (@map[y][x] > @EMPTY && @map[y][x] >= 10)
                    if (@map[y][x] == 10) then
                        Window.draw_ex(x * @mapchip_size + @default_x + 5, y * @mapchip_size + @default_y + 1, @virus[@map[y][x] - 10], {scale_x: 2.0, scale_y: 2.0})
                    elsif (@map[y][x] == 11)
                        Window.draw_ex(x * @mapchip_size + @default_x + 5, y * @mapchip_size + @default_y + 1, @virus[@map[y][x] - 10], {scale_x: 2.0, scale_y: 2.0})
                    elsif (@map[y][x] == 12)
                        Window.draw_ex(x * @mapchip_size + @default_x + 5, y * @mapchip_size + @default_y + 1, @virus[@map[y][x] - 10], {scale_x: 2.0, scale_y: 2.0})
                    end
                            
                    
                elsif (@map[y][x] > @EMPTY && @map[y][x] < 8) then #薬の描画
                    if (dir_map[y][x] - 1 == 1) then
                        Window.draw_ex(x * @mapchip_size + @default_x + 5, y * @mapchip_size + @default_y + 1, @medics[@map[y][x] - 1], {scale_x: 2.0, scale_y: 2.0})
                    elsif (dir_map[y][x] - 1 == 3) then
                        Window.draw_ex(x * @mapchip_size + @default_x + 13, y * @mapchip_size + @default_y + 1, @medics[@map[y][x] - 1], {angle: 180, scale_x: 2.0, scale_y: 2.0})
                    end
                end
                x += 1
            end
            y += 1
        end
    end
end


#メイン部分--------------------------------------------------------------------------------------
Window.load_resources do    #画像変数などの定義はここでする

    #background = Image[:back]  #背景描画
    field = Field.new   #mapを作成する
    queue = Array.new(2)
    queue[0] = Medic.new
    queue[1] = Medic.new
    queue[0].dir = 3;   queue[0].x = 4;
    queue[1].dir = 1;   queue[1].x = 5;
    mainmenu = MainMenu.new  #mainmenuを作成
    type = 0  #処理タイプ 0:mainmenu 1:game 2:setting
    new_medic_flag = 0;
    new_game_flag = 1;
    virus_num = 10
    move = 0;
    
    #ここにゲーム全体のループ処理を記述
    Window.loop do
        
        if (type == 0) then
            
            new_game_flag = 1
            type = mainmenu.draw()
            
        elsif (type == 1) then
            
            if (new_game_flag == 1) then
                
                NewMap(field.map, virus_num)
                new_game_flag = 0
            end
        
        
            if (new_medic_flag == 1) then
            
                queue[0] = Medic.new
                queue[1] = Medic.new
                queue[0].dir = 3;   queue[0].x = 4;
                queue[1].dir = 1;   queue[1].x = 5;
                queue[0].mode = 1; queue[1].mode = 1;
                new_medic_flag = 0
            end
            
            field.draw()
            2.times do |i|
            
                if (queue[i].mode == 1) then    #移動中なら
            
                    queue[i].draw()
                    queue[i].move(field.map, move, i)
                
                    #止まったら
                    if (queue[i].mode == 2) then
                    
                        if (i == 0) then
                            queue[1].mode = 2
                            field.map[queue[0].y][queue[0].x] = queue[0].color + 1
                            field.map[queue[0].y][queue[0].x + 1] = queue[1].color + 1
                            field.dir_map[queue[0].y][queue[0].x] = queue[0].dir + 1
                            field.dir_map[queue[0].y][queue[0].x + 1] = queue[1].dir + 1
                        else
                            queue[0].mode = 2
                            field.map[queue[1].y][queue[1].x] = queue[1].color + 1
                            field.map[queue[1].y][queue[1].x - 1] = queue[0].color + 1
                            field.dir_map[queue[1].y][queue[1].x] = queue[1].dir + 1
                            field.dir_map[queue[1].y][queue[1].x - 1] = queue[0].dir + 1
                        end
                        new_medic_flag = 1  #新しく薬を生成
                    end
                end
            end
            #if (move != 0 && move < 190) then
            #    move += 200
            #end
        
            move = 0
            if (Input.x < 0) then   #左
            
                move = -1
            elsif (Input.x > 0) #右
            
                move = 1
            elsif (Input.y > 0) #した
            
                move = 2
            else
            
                move = 0
            end
            sleep(0.1)
            
        elsif (type == 2) then
            type = 0
            
        end
    end
end