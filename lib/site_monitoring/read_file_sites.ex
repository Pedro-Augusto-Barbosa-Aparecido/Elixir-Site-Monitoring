defmodule SiteMonitoring.ReadFile do
    def read_site_file_txt(:default_location, method) do
        path = Path.join([
            File.cwd!(), 
            "priv\\sites.txt"
        ])

        sites = File.read!(path)
        sites = String.split(sites, "\n")

        # treaty_sites(sites, [], method)
        sites
    end
    def read_site_file_txt(path) when is_bitstring(path) do
        sites = File.read!(path)
        IO.puts(length(String.split(sites, "\n")))
    end
    def read_site_file_txt(_) do 
        IO.puts("No path or definition of default path")
        :error
    end
    def read_http_csv_file do
        path = Path.join([
            File.cwd!(),
            "priv\\http_codes.csv"
        ])
        codes = File.read!(path) |> String.split("\n")
        treaty_http_codes(codes, [])
    end
    defp treaty_http_codes([], codes_treated), do: codes_treated 
    defp treaty_http_codes(codes, codes_treated) do
        [el | codes] = codes

        el = String.split(el, ";")

        [code | texts] = el
        [title | texts] = texts
        [descrip | texts] = texts

        descrip = String.trim(descrip, "\r")

        treaty_http_codes(codes, codes_treated ++ [%{code: code, title: title, description: descrip}])

    end
    defp treaty_sites([], sites_treated, _), do: sites_treated
    defp treaty_sites(sites, sites_treated, method) do
        [site | sites] = sites
        treaty_sites(sites, [%{site: String.trim(site, "\r"), method: method}] ++ sites_treated, method)
    end
end