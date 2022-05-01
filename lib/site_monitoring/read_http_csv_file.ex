defmodule Mix.Tasks.ReadHttpCsvFile do
    @moduledoc """
        Documentação completa da tarefa

        `mix read_http_csv_file`

    """
    use Mix.Task

    @shortdoc "Lê um arquivo txt contendo os sites para serem testados"
    def run(_) do
        # path = "D:\\codes\\Elixir\\site_monitoring\\priv\\http_codes.csv"
        SiteMonitoring.ReadFile.read_http_csv_file
    end
end