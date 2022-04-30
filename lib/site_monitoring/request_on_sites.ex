defmodule SiteMonitoring.RequestOnSites do
    def make_request do
        sites = SiteMonitoring.ReadFile.read_site_file_txt(:default_location, :get)
        do_requests(sites)
    end
    defp my_request(site) do
        case HTTPoison.get(site) do
            {:ok, %HTTPoison.Response{status_code: 404}} -> IO.puts("Site fora do ar 'NÃO ENCONTRADO'") 
            {:ok, %HTTPoison.Response{status_code: 500}} -> IO.puts("Site fora do ar 'ERRO NO SERVIDOR'") 
            {:ok, %HTTPoison.Response{status_code: status}} -> IO.puts status
            {:error, %HTTPoison.Error{reason: :nxdomain}} -> IO.puts("Não existe esse dominio")
            {:error, %HTTPoison.Error{reason: :econnrefused}} -> IO.puts("Conexão recusada ou não autorizada")
        end
    end
    defp do_requests([]), do: :ok
    defp do_requests(sites) do
        [site | sites] = sites
        IO.puts site
        site |> String.trim("\r") 
             |> my_request()
        do_requests(sites)
    end
end