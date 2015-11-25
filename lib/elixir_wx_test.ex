defmodule ElixirWxTest do
  def start do
    state = make_window
    loop(state)
  end

  defp make_window do
    server = :wx.new
    frame = :wxFrame.new(server, -1, 'Countdown', size: {250, 150})
    panel = :wxPanel.new(frame)

    text = :wxTextCtrl.new(panel, 1001, value: '10')
    static = :wxStaticText.new(panel, 2001, 'Output area')
    countdown_button = :wxButton.new(panel, 101, label: '&Countdown')
    exit_button = :wxButton.new(panel, 201, label: '&Exit')

    outerSizer = :wxBoxSizer.new(:wx_const.wx_horizontal)
    mainSizer = :wxBoxSizer.new(:wx_const.wx_vertical)
    inputSizer = :wxStaticBoxSizer.new(:wx_const.wx_horizontal, panel, label: 'Enter an integer')
    buttonSizer = :wxBoxSizer.new(:wx_const.wx_horizontal)

    :wxSizer.add(inputSizer, text)
    :wxSizer.add(inputSizer, 40, 0)

    :wxSizer.addSpacer(mainSizer, 10)
    :wxSizer.add(mainSizer, inputSizer)
    :wxSizer.addSpacer(mainSizer, 5)

    :wxSizer.add(mainSizer, static)
    :wxSizer.addSpacer(mainSizer, 10)

    :wxSizer.add(buttonSizer, countdown_button)
    :wxSizer.add(buttonSizer, exit_button)
    :wxSizer.add(mainSizer, buttonSizer)

    :wxSizer.addSpacer(outerSizer, 20)
    :wxSizer.add(outerSizer, mainSizer)

    :wxPanel.setSizer(panel, outerSizer)

    :wxFrame.show(frame)

    :wxFrame.connect(frame, :close_window)
    :wxPanel.connect(panel, :command_button_clicked)

    {frame, text, static}
  end

  defp loop({frame, text, static}) do
    receive do
      {:wx, _, ^frame, _, {:wxClose, :close_window}} ->
        :wxWindow.destroy(frame)
        :ok
      {:wx, 201, _, _, {:wxCommand, :command_button_clicked, _, _, _}} ->
        :wxWindow.destroy(frame)
        :ok
      {:wx, 101, _, _, {:wxCommand, :command_button_clicked, _, _, _}} ->
        value = :wxTextCtrl.getValue(text)
        :wxStaticText.setLabel(static, value)
        loop({frame, text, static})
      event ->
        IO.inspect event
        loop({frame, text, static})
    end
  end
end
