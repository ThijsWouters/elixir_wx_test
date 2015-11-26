-module(wx_const).
-compile(export_all).

-include_lib("wx/include/wx.hrl").

wx_horizontal() ->
  ?wxHORIZONTAL.

wx_vertical() ->
  ?wxVERTICAL.

wx_id_exit() ->
  ?wxID_EXIT.

wx_full_repaint_on_resize() ->
  ?wxFULL_REPAINT_ON_RESIZE.

wx_expand() ->
  ?wxEXPAND.
