#メインメニュー (naio)
require 'dxopal'
include DXOpal

Image.register(:medic, "image/YAKU_cupcell.png")
Window.width = 300
Window.height = 300
Window.bgcolor = C_WHITE

font_title = Font.new(40)
font_choices = Font.new(20)

Window.load_resources do
    image = Image[:medic].slice_tiles(6, 1)
  Window.loop do
      Window.draw_ex(50, 70, image[3], :angle=>90, :alpha=>180, :scalex=>100, :scaley=>100)
      Window.draw_font(50, 100, "Dr.MARIO", font_title, color: C_BLACK)  # "Dr.MARIO"を描画する
      
      Window.draw_font(100, 200, "PLAY", font_choices, color: C_BLACK)
      Window.draw_font(100, 230, "SETTING", font_choices, color: C_BLACK)
  end
end