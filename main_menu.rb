#メインメニュー (naio)
require 'dxopal'
include DXOpal

font = Font.new(32)

Window.load_resources do
  Window.loop do
      Window.draw_font(100, 100, "Dr.MARIO", font)  # "Dr.MARIO"を描画する
      
  end
end