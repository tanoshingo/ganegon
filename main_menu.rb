#メインメニュー (naito)
require 'dxopal'
include DXOpal

#init
Image.register(:medic, "image/Yaku_mainmenu.png")
Image.register(:heart, "image/heart.png")
Image.register(:back, "image/back.png")
Window.width = 300
Window.height = 300
Window.bgcolor = C_WHITE

font_title = Font.new(40)
font_choices = Font.new(20)

type = 0  #テケトー　処理の移行に使う予定
select = 0  #main_menu 選択用変数

#main
Window.load_resources do
    background = Image[:back]  #背景画像読み込み
    image1 = Image[:medic].slice_tiles(6, 1)  #画像読み込み
    image2 = Image[:heart]  #

  Window.loop do
      Window.draw(0, 0, background)  #背景描画
      
      #type=0 main_menu
      if (type == 0) then
        #色々描画↓
        Window.draw_ex(120, 65, image1[3], :angle=>90, :alpha=>255, :scale_x=>2.0, :scale_y=>2.0)
        Window.draw_font(50, 100, "TITLE", font_title, color: C_BLACK)
        Window.draw_font(100, 200, "PLAY", font_choices, color: C_BLACK)
        Window.draw_font(100, 230, "SETTING", font_choices, color: C_BLACK)
      
        #main_menu処理↓
        #選択
        if (Input.key_push?(K_W)) then
            select = select + 1
            
        elsif (Input.key_push?(K_S)) then
            select = select - 1
            
        end
      
        #決定
        if ((select % 2) == 0) then
            Window.draw(80, 200, image2)
            if (Input.key_push?(K_SPACE)) then
                #type変更→処理移行→各種変数初期化(PLAY)
            end
            
        elsif ((select % 2) == 1) then
            Window.draw(80, 230, image2)
            if (Input.key_push?(K_SPACE)) then
                #type変更→処理移行→各種変数初期化(SETTING)
            end
        end
    end
    #type=0↑
    
  end
end