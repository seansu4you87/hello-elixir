defmodule KV.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  @manager_name KV.EventManager
  @registry_name KV.Registry
  @bucket_sup_name KV.Bucket.Supervisor

  def init(:ok) do
    # `worker` takes a process module, and an array of arguments to pass into
    # `start_link`.  In this case we start up the event manager, and then take
    # the event manager and pass it into the Registry
    children = [
      worker(GenEvent, [[name: @manager_name]]),
      worker(KV.Bucket.Supervisor, [[name: @bucket_sup_name]]),
      worker(KV.Registry, [@manager_name, @bucket_sup_name, [name: @registry_name]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end