defmodule OpenGLTest do
  def start do
    size = {500, 500}
    wx = :wx.new
    frame = :wxFrame.new(wx, -1, 'OpenGL Test')
    gl = :wxGLCanvas.new(frame, size: size, attribList: [:wx_const.wx_gl_rgba, :wx_const.wx_gl_doublebuffer, 0])

    :wxWindow.setMinSize(gl, size)
    :wxWindow.setMaxSize(gl, size)
    :wxWindow.setSize(gl, size)

    mainSizer = :wxBoxSizer.new(:wx_const.wx_vertical)
    :wxSizer.setMinSize(mainSizer, size)
    :wxSizer.fit(mainSizer, frame)

    :wxWindow.setMinSize(frame, :wxWindow.getSize(frame))
    :wxWindow.setMaxSize(frame, :wxWindow.getSize(frame))
    :wxWindow.setSize(frame, :wxWindow.getSize(frame))

    :wxWindow.show(frame)
    :wxWindow.setFocus(frame)

    :wxGLCanvas.setCurrent(gl)

    {width, height} = :wxWindow.getClientSize(gl)

    :gl.viewport(0, 0, width, height)
    :gl.matrixMode(:gl_const.gl_projection)
    :gl.loadIdentity()
    :gl.ortho(0, width, height, 0, -1, 1)

    :gl.matrixMode(:gl_const.gl_modelview)
    :gl.loadIdentity()
    :gl.clearColor(0.0, 0.0, 0.0, 1.0)

    :gl.enable(:gl_const.gl_blend)
    :gl.enable(:gl_const.gl_texture_2d)
    :gl.blendFunc(:gl_const.gl_src_alpha, :gl_const.gl_one_minus_src_alpha)
    :gl.shadeModel(:gl_const.gl_flat)

    :wxWindow.raise(frame)

    loop(gl, {1, 0, 0})
  end

  def loop(gl, {red, green, blue}) do
    :gl.color3f(red, green, blue)

    :gl.begin(:gl_const.gl_quads)
    :gl.vertex2f(50, 50)
    :gl.vertex2f(50, 200)
    :gl.vertex2f(200, 200)
    :gl.vertex2f(200, 50)
    :gl.end

    :wxGLCanvas.swapBuffers(gl)
    :timer.sleep(1000)
    if red == 1 do
      loop(gl, {0, 1, 0})
    else
      loop(gl, {1, 0, 0})
    end
  end
end
