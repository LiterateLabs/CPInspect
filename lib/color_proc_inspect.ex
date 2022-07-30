defmodule ColorProcessInspect do
  import Kernel, except: [inspect: 1]

  def start_link(state) do
    GenServer.start_link(CPIGenServer, Map.merge(state, %{count: 0}), name: CPIGenServer)
  end

  def child_spec(opts) do
    %{
      id: CPIGenServer,
      start: {CPIGenServer, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def inspect(data) do
    GenServer.call(CPIGenServer, {:print, self(), data})
  end
end
