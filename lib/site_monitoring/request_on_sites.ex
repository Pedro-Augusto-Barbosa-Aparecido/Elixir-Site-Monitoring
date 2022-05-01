defmodule SiteMonitoring.RequestOnSites do
    def make_request do
        sites = SiteMonitoring.ReadFile.read_site_file_txt(:default_location, :get)
        do_requests(sites)
    end
    defp my_request(site) do
        log_message = ""
        case HTTPoison.get(site) do
            {:ok, %HTTPoison.Response{status_code: status}} -> SiteMonitoring.ExportLog.write_on_file(generate_log_message(:ok, log_message, site, "#{status}"))
            {:error, %HTTPoison.Error{reason: :nxdomain}} -> SiteMonitoring.ExportLog.write_on_file(generate_log_message(:nxdomain, log_message, site))
            {:error, %HTTPoison.Error{reason: :econnrefused}} -> SiteMonitoring.ExportLog.write_on_file(generate_log_message(:econnrefused, log_message, site))
        end
    end
    defp generate_log_message(:ok, msg, site, status), do: msg <> SiteMonitoring.ExportLog.export(:ok, site, status) <> "\n"
    defp generate_log_message(:nxdomain, msg, site), do: msg <> SiteMonitoring.ExportLog.export(:error, :nxdomain, site) <> "\n"
    defp generate_log_message(:econnrefused, msg, site), do: msg <> SiteMonitoring.ExportLog.export(:error, :econnrefused, site) <> "\n"
    defp do_requests([]), do: :ok
    defp do_requests(sites) do
        [site | sites] = sites
        IO.puts site
        site |> String.trim("\r") 
             |> my_request()
        do_requests(sites)
    end
end