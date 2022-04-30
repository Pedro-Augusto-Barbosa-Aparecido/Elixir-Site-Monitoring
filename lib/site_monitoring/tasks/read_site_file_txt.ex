defmodule Mix.Tasks.ReadSiteFileTxt do
    @moduledoc """
        Documentação completa da tarefa

        `mix read_file_txt`

    """
    use Mix.Task

    @shortdoc "Lê um arquivo txt contendo os sites para serem testados"
    def run(_) do
        # path = "D:\\codes\\Elixir\\site_monitoring\\priv\\sites.txt"
        SiteMonitoring.ReadFile.read_site_file_txt(:default_location, :get)
    end
end