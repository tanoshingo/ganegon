<<<<<<< HEAD
# coding: utf-8
require 'dxopal';
include DXOpal

require_remote 'main_menu_method.rb'


Image.register(:back, "image/back.png")  #背景の画像
Image.register(:medic, "image/YAKU_cupcell.png")    #薬の画像
Image.register(:enemy, "image/uirusu.png")  #ウイルスの画像
Image.register(:heart, "image/heart.png")  #ハートの画像


#ウィンドウの初期設定
Window.width = 1200
Window.height = 800
Window.bgcolor = C_WHITE

#クラス定義・メソッド定義-------------------------------------------------------------------------

#概　要：field用のクラス
class Field
    
    #attr_accessor :map :medics :virus :bottle_chip

    def initialize()
        
        @FIELD_Y = 20   #マップのYの大きさ
        @FIELD_X = 10   #マップのXの大きさ
        
        @EMPTY = 0
        @WALL = 1000000
        
        #フィールド全体の変数を宣言
        @map = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
        
        #画像データを格納する変数
        @medics = Image[:medic].slice_tiles(6, 1)    #薬の画像を分割（配列化、medics[0]～medics[5]）
        @virus = Image[:enemy].slice_tiles(2, 2) #ウイルスの画像を分割（配列化、virus[0]～virus[2]）
        @bottle_chip = Image.new(30, 30, [125, 125, 125]) #薬瓶のbit画像を生成

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
    end
    
    #概　要：マップの描画
    #引　数：なし
    #戻り値：なし
    def draw()
        
        @default_x = 450    #X方向の開始座標
        @default_y = 150    #Y方向の開始座標
        @mapchip_size = 30  #1マスあたりのサイズ
        
        y = 0
        while y < @FIELD_Y do
            
            x = 0
            while x < @FIELD_X do
                
                if (@map[y][x] == @WALL) then   #壁を描画
                    Window.draw(x * @mapchip_size + @default_x, y * @mapchip_size + @default_y, @bottle_chip)
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
    mainmenu = MainMenu.new  #mainmenuを作成
    
    type = 0  #処理タイプ 0:mainmenu 1:game 2:setting
    
    #ここにゲーム全体のループ処理を記述
    Window.loop do
        
        #Window.draw(0, 0, background, -10)  #背景描画
        
        if (type == 0) then
            type = mainmenu.draw()
        
        elsif (type == 1) then
            field.draw()
        
        elsif (type == 2) then
            type = 0
            
        end
        
    end
=======
# coding: utf-8
require 'dxopal';
include DXOpal

Image.register(:medic, "image/REAL_YAKU.png")    #薬の画像
require_remote 'main_menu_method.rb'

Image.register(:back, "image/back.png")  #背景の画像
Image.register(:medic, "image/YAKU_cupcell.png")    #薬の画像
Image.register(:enemy, "image/uirusu.png")  #ウイルスの画像
Image.register(:heart, "image/heart.png")  #ハートの画像


#ウィンドウの初期設定
Window.width = 1200
Window.height = 800
Window.bgcolor = C_WHITE

#クラス定義・メソッド定義-------------------------------------------------------------------------


#medic用のクラス
class Medic
    
    attr_accessor :x, :y, :dir, :color
    
    def initialize()
    
        #色
        @RED = 1
        @BLUE = 2
        @YELLOW = 3
        @color = rand(0..2)
        
        #向き（左1、上2、右3、下4）
        @dir
        
        #くっついているかどうか
        @connecting = 1
        
        #どの状態か（queue内部 or 操作中 or 設置済み）
        @QUEUEING = 0
        @PLAYING = 1
        @PUTTED = 2
        @mode = @QUEUEING
        
        @x = -10
        @y = -10
        
        @medics = Image[:medic].slice_tiles(3, 2)    #薬の画像を分割（配列化、medics[0]～medics[5]）
    end
        
    def draw() 
        
        @mapchip_size = 34
        if (@mode == @QUEUEING && @dir == 2) then
            Window.draw(900, 100, @medics[@color])
        elsif(@mode == @QUEUEING && @dir == 4)
            Window.draw(934, 100, @medics[@color])
        else
            Window.draw(x * @mapchip_size + @default_x, y * @mapchip_size + @default_y, @empty_chip)
        end
    end
end

#player用のクラス
class Player < Medic
    
    def initialize(queue)
        
        #色
        @RED = 1
        @BLUE = 2
        @YELLOW = 3
        
        #どの状態か（queue内部 or 操作中 or 設置済み）
        @QUEUEING = 0
        @PLAYING = 1
        @PUTTED = 2
        
        #座標
        @mymedic_x = [4, 5]
        @mymedic_y = [1, 1]
        
        #薬の情報
        @mymedic_color = queue.color
        @mymedic_dir = queue.dir
        @mymedic_connecting = 1
        @mode = @PLAYING
    end
end

#概　要：field用のクラス
class Field
    
    attr_accessor :map, :medics, :virus, :bottle_chip, :FIELD_X, :FIELD_Y

    def initialize()
        
        @FIELD_Y = 20   #マップのYの大きさ
        @FIELD_X = 10   #マップのXの大きさ
        
        @EMPTY = 0
        @WALL = 1000000
        
        #フィールド全体の変数を宣言
        @map = Array.new(@FIELD_Y) { Array.new(@FIELD_X, @EMPTY) }
        
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
                
                if (@map[y][x] == @WALL) then   #壁を描画
                    Window.draw(x * @mapchip_size + @default_x, y * @mapchip_size + @default_y, @bottle_chip)
                else    #何もない場所を描画
                    Window.draw(x * @mapchip_size + @default_x, y * @mapchip_size + @default_y, @empty_chip)
                end
                x += 1
            end
            y += 1
        end
    end
end


#メイン部分--------------------------------------------------------------------------------------
Window.load_resources do    #画像変数などの定義はここでする
    
    queue = Array.new(2)
    queue[0] = Medic.new    #待機中の薬を作成
    queue[1] = Medic.new    #待機中の薬を作成
    queue[0].dir = 2    #右向き
    queue[1].dir = 4    #左向き
    field = Field.new   #mapを作成する
    p_medic = Array.new(2)
    p_medic[0] = Player.new(queue[0])    #プレイヤー用の薬を作成
    p_medic[1] = Player.new(queue[1])    #プレイヤー用の薬を作成

    #background = Image[:back]  #背景描画
    field = Field.new   #mapを作成する
    mainmenu = MainMenu.new  #mainmenuを作成
    
    #ここにゲーム全体のループ処理を記述
    Window.loop do
        
        queue[0] = Medic.new
        queue[1] = Medic.new
        queue[0].dir = 2    #右向き
        queue[1].dir = 4    #左向き

        #mainmenu.draw()
        #Window.draw(0, 0, background, -10)  #背景描画
        field.draw()
        queue[0].draw()
        queue[1].draw()
        p_medic[0].draw()
        p_medic[1].draw()
        sleep 0.05
        
    end
>>>>>>> upstream/main
end