use Mix.Config

config :site_monitoring, SiteMonitoring.Supervisor, jobs: [
                                                           {"* * * * *", fn -> GenServer.cast(:server, :make_request) end}
]