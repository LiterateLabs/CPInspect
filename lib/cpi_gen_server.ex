defmodule CPIGenServer do
  use GenServer

  @the_types [
    :number,
    :atom,
    :string,
    :boolean,
    :binary,
    :bitstring,
    :list,
    :map,
    :regex,
    :tuple,
    :function,
    :struct,
    :pid,
    :port,
    :reference,
    :date,
    :datetime,
    nil
  ]
  @green Enum.map(@the_types, fn t -> {t, :green} end)
  # @red Enum.map(@the_types, fn t -> {t, :red} end)
  @yellow Enum.map(@the_types, fn t -> {t, :yellow} end)
  @cyan Enum.map(@the_types, fn t -> {t, :cyan} end)
  @purple Enum.map(@the_types, fn t -> {t, IO.ANSI.color(4, 2, 5)} end)
  @orange Enum.map(@the_types, fn t -> {t, IO.ANSI.color(4, 2, 0)} end)
  @blue Enum.map(@the_types, fn t -> {t, IO.ANSI.color(0, 2, 4)} end)
  @gray Enum.map(@the_types, fn t -> {t, IO.ANSI.color(1, 1, 2)} end)
  @sky Enum.map(@the_types, fn t -> {t, IO.ANSI.color(1, 3, 5)} end)
  @lime Enum.map(@the_types, fn t -> {t, IO.ANSI.color(3, 5, 0)} end)
  @lavender Enum.map(@the_types, fn t -> {t, IO.ANSI.color(5, 1, 1)} end)
  @cloud Enum.map(@the_types, fn t -> {t, IO.ANSI.color(3, 5, 5)} end)

  @color_list [
    @green,
    @yellow,
    @blue,
    @orange,
    @purple,
    @cyan,
    @gray,
    @sky,
    @lime,
    @lavender,
    @cloud
  ]

  # client api

  def start_link(state) do
    GenServer.start_link(__MODULE__, Map.merge(state, %{count: 0}), name: __MODULE__)
  end

  defp prnt(cnt, pid, data, color) do
    case is_binary(data) do
      true -> prnt_binary(cnt, pid, data, color)
      false -> prnt_non_binary(cnt, pid, data, color)
    end
  end

  defp prnt_binary(cnt, pid, data, color) do
    IO.inspect("#{cnt} - #{inspect(pid)} #{data}", syntax_colors: color)
    data
  end

  defp prnt_non_binary(cnt, pid, data, color) do
    IO.inspect("#{cnt} - #{inspect(pid)}", syntax_colors: color)
    IO.inspect(data, syntax_colors: color, pretty: true)
  end

  # server callbacks
  @impl true
  def init(state) do
    IO.inspect("I am here")
    IO.inspect(state)
    {:ok, state}
  end

  @impl true
  def handle_call({:print, pid, data}, _from, state) do
    state = update_state(state, pid)

    {:ok, {cnt, _timestamp, color}} = Map.fetch(state, pid)
    prnt(cnt, pid, data, color)

    {:reply, data, state}
  end

  defp update_state(state, pid) do
    case Map.fetch(state, pid) do
      {:ok, {cnt, _timestamp, color}} ->
        Map.put(state, pid, {cnt, DateTime.utc_now(), color})

      :error ->
        ndx =
          Kernel.rem(
            Kernel.length(Map.keys(state)),
            Kernel.length(@color_list)
          )

        incr_count = state.count + 1
        state = Map.put(state, :count, incr_count)
        incr_color = Enum.at(@color_list, ndx)
        Map.put(state, pid, {incr_count, DateTime.utc_now(), incr_color})
    end
  end
end
