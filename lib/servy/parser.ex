defmodule Servy.Parser do
#alias Servy.Conv as: Conv
  alias Servy.Conv
  def parse(request) do
    [top, params_sring] = String.split(request, "\n\n")

    [request_line | header_lines] = String.split(top, "\n")
    [method, path, _] = String.split(request_line, " ")
      #request 
#top 
#      |> String.split("\n") 
#      |> List.first
#      |> String.split(" ")

    %Conv{ 
      method: method, 
      path: path
    }
  end
end
