class MainMenu

def initialize()
    @medics = Image[:medic].slice_tiles(6, 1)  #薬の画像を分割（配列化、medics[0]～medics[5]）
    @hearts = Image[:heart]  #ハートの画像を読み込み
    @font_title = Font.new(100)
    @font_choices = Font.new(60)
    @choices = 0
end

def draw()
    #色々描画↓
    Window.draw_ex(120, 65, @medics[3], :angle=>90, :alpha=>255, :scale_x=>2.0, :scale_y=>2.0)
    Window.draw_font(50, 100, "TITLE", @font_title, color: C_BLACK)
    Window.draw_font(100, 200, "PLAY", @font_choices, color: C_BLACK)
    Window.draw_font(100, 230, "SETTING", @font_choices, color: C_BLACK)
      
    #main_menu処理↓
    #選択
    if (Input.key_push?(K_W)) then
        @choices = @choices + 1
            
    elsif (Input.key_push?(K_S)) then
        @choices = @choices - 1
            
    end
      
    #決定
    if ((@choices % 2) == 0) then
        Window.draw(80, 200, @hearts)
        if (Input.key_push?(K_SPACE)) then
            #type変更→処理移行→各種変数初期化(PLAY)
        end
            
    elsif ((@choices % 2) == 1) then
        Window.draw(80, 230, @hearts)
        if (Input.key_push?(K_SPACE)) then
            #type変更→処理移行→各種変数初期化(SETTING)
        end
    end
    
end

end