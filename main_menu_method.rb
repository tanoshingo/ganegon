# coding: utf-8

class MainMenu

def initialize()
    @medics = Image[:medic].slice_tiles(6, 1)  #薬の画像を分割（配列化、medics[0]～medics[5]）
    @hearts = Image[:heart]  #ハートの画像を読み込み
    @title = Image[:title]  #タイトルの画像の読み込み
    @font_title = Font.new(120)
    @font_choices = Font.new(60)
    @choices = 0
end

def draw()
    #色々描画↓
    #Window.draw_ex(200, 100, @medics[3], :angle=>90, :alpha=>255, :scale_x=>2.0, :scale_y=>2.0)
    Window.draw((Window.width / 2) - (@title.width / 2), 100, @title)
    Window.draw_font((Window.width / 2) - 100, 300, "PLAY", @font_choices, color: C_BLACK)
    Window.draw_font((Window.width / 2) - 100, 400, "SETTING", @font_choices, color: C_BLACK)
      
    #main_menu処理↓
    #選択
    if (Input.y < 0) then
        @choices = @choices + 1
            
    elsif (Input.y > 0) then
        @choices = @choices - 1
            
    end
    
    sleep(0.1)
      
    #決定
    if ((@choices % 2) == 0) then
        Window.draw((Window.width / 2) - 120, 330, @hearts)
        if (Input.key_push?(K_SPACE)) then
            #type変更→処理移行→各種変数初期化(PLAY)
            choices = 0
            return 1
        end
            
    elsif ((@choices % 2) == 1) then
        Window.draw((Window.width / 2) - 120, 430, @hearts)
        if (Input.key_push?(K_SPACE)) then
            #type変更→処理移行→各種変数初期化(SETTING)
            choices = 0
            return 2
        end
    end
    
    return 0
    
end

end