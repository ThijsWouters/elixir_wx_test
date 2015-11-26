defmodule WxCanvasTest do
  def start do
    wx = :wx.new
    frame = :wxFrame.new(wx, -1, 'Canvas test', size: {1000, 1000})
    panel = :wxPanel.new(frame, [])

    main_sizer = :wxBoxSizer.new(:wx_const.wx_vertical)
    sizer = :wxStaticBoxSizer.new(:wx_const.wx_vertical, panel)
    win = :wxPanel.new(panel, [style: :wx_const.wx_full_repaint_on_resize])

    :wxPanel.connect(win, :paint, [:callback])
    :wxPanel.connect(win, :size)

    :wxSizer.add(sizer, win, [flag: :wx_const.wx_expand, proportion: 1])
    :wxSizer.add(main_sizer, sizer, [flag: :wx_const.wx_expand, proportion: 1])
    :wxPanel.setSizer(panel, main_sizer)
    :wxFrame.show(frame)

    dc = :wxPaintDC.new(win)
    canvas = :wxGraphicsContext.create(dc)

    #Draw line
    red = :wxPen.new({255, 0, 0, 255})
    :wxGraphicsContext.setPen(canvas, red)
    :wxGraphicsContext.drawLines(canvas, [{100, 100}, {200, 200}])

    #Draw rectangle
    yellow = :wxGraphicsContext.createBrush(canvas, :wxBrush.new({255, 255, 0, 255}))
    black = :wxPen.new({0, 0, 0, 255})
    :wxGraphicsContext.setPen(canvas, black)
    :wxGraphicsContext.setBrush(canvas, yellow)
    :wxGraphicsContext.drawRectangle(canvas, 200, 300, 400, 400)
  end
end
