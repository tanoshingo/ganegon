# coding: utf-8
require 'dxopal';
include DXOpal

Image.register(:medic, "image/YAKU_cupcell.png")    #薬の画像
#Image.register(:bottle, "image/bing.png")   #薬瓶の画像
Image.register(:enemy, "image/uirusu.png")  #ウイルスの画像

#ウィンドウの初期設定
Window.width = 300
Window.height = 300
Window.bgcolor = C_WHITE

#クラス定義・メソッド定義




#メイン部分-----------------------------------------------------------------------
Window.load_resources do    #画像変数などの定義はここでする
    
    medics = Image[:medic].slice_tiles(6, 1)    #薬の画像を分割（配列化、medics[0]～medics[5]）
    virus = Image[:enemy].slice_tiles(2, 2) #ウイルスの画像を分割（配列化、virus[0]～virus[2]）
    
    #ここにゲーム全体のループ処理を記述
    Window.loop do
        
        Window.draw(100, 100, medics[0])
        
    end
end