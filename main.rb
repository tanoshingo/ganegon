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
    
    #ここにゲーム全体のループ処理を記述
    Window.loop do
        
        #mainmenu.draw()
        #Window.draw(0, 0, background, -10)  #背景描画
        field.draw()
        
    end
end