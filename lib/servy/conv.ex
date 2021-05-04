defmodule Servy.Conv do
  #defstruct [method: "", path: "", resp_body: "", status: nil]
  defstruct method: "", 
            path: "", 
            params: %{}, 
            headers: %{}, 
            resp_body: "", 
            status: nil

  def full_status(conv) do
      "#{conv.status} #{status_reson(conv.status)}"
  end

  defp status_reson(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error",
    }[code]
  end
end
