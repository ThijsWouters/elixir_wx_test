-module(gl_const).
-compile(export_all).

-include_lib("wx/include/gl.hrl").

gl_projection() ->
  ?GL_PROJECTION.

gl_modelview() ->
  ?GL_MODELVIEW.

gl_blend() ->
  ?GL_BLEND.

gl_texture_2d() ->
  ?GL_TEXTURE_2D.

gl_src_alpha() ->
  ?GL_SRC_ALPHA.

gl_one_minus_src_alpha() ->
  ?GL_ONE_MINUS_SRC_ALPHA.

gl_flat() ->
  ?GL_FLAT.

gl_quads() ->
  ?GL_QUADS.
