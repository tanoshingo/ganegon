require 'dxopal'

image = Image.load_tiles('image/YAKU_cupcell.png', 6, 1)

Window.loop do
       Window.draw_rot(100, 100, image[0])  # data.pngの左上を描画する
end
