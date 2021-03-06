defmodule SiteMonitoring.Application do
  use Application

  def start(_type, _args) do
    children = [
        SiteMonitoring.Server,
        SiteMonitoring.Supervisor
    ]

    opts = [strategy: :one_for_one, name: SiteMonitoring.ServerSupervisor]
    Supervisor.start_link(children, opts)
  end
end