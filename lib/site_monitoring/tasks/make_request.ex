defmodule Mix.Tasks.MakeRequest do
    @moduledoc """
        Documentação completa da tarefa

        `mix make_request`

    """
    use Mix.Task

    @shortdoc "Faz as requests nos sites listados no arquivo"
    def run(_) do
        SiteMonitoring.RequestOnSites.make_request
    end
end