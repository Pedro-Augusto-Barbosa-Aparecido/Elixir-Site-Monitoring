defmodule SiteMonitoring.ExportLog do
    def get_date do
        today = DateTime.utc_now
        date = [today.year, today.month, today.day]
        h = [today.hour, today.minute, today.second]

        date = Enum.join(date, "/")
        h = Enum.join(h, ":")

        "[#{date} - #{h}]"
    end
    def write_on_file(message) do
        path = Path.join([
            File.cwd!(), 
            "priv\\log.txt"
        ])
        {:ok, file} = File.open(path, [:append, {:encoding, :utf8}])
        IO.write(file, message)
        File.close(file)
    end
    def export(:error, :nxdomain, site), do: get_date() <> " LOG: Site: #{site} - Result: Não existe esse dominio"
    def export(:error, :econnrefused, site), do: get_date() <> " LOG: Site: #{site} - Result: Conexão recusada ou não autorizada"
    def export(:ok, site, status) do
        code = SiteMonitoring.ReadFile.read_http_csv_file |> Enum.find(fn map -> map[:code] == status end)
        "#{get_date()} LOG: Site: #{site} - Result: #{status} | Title: #{code[:title]} Desc: #{code[:description]}"
    end
end