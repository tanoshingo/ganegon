require 'dxopal'; include DXOpal
Image.register(:medic, "image/YAKU_cupcell.png")
Window.width = 300
Window.height = 300
Window.bgcolor = C_WHITE
Window.load_resources do
  image = Image[:medic].slice_tiles(6, 1)
  Window.loop do
    Window.draw(100, 100, image[0])
  end
end
