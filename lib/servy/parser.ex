defmodule Servy.Parser do
#alias Servy.Conv as: Conv
  alias Servy.Conv
  def parse(request) do
    [top, params_sring] = String.split(request, "\n\n")

    [request_line | header_lines] = String.split(top, "\n")
    [method, path, _] = String.split(request_line, " ")

    headers = parse_headers(header_lines, %{})
    params = parse_params(headers["Content-Type"],params_sring)

      #request 
#top 
#      |> String.split("\n") 
#      |> List.first
#      |> String.split(" ")

    %Conv{ 
      method: method, 
      path: path,
      headers: headers,
      params: params,

    }
  end

  def parse_headers([head|tail], headers) do
#IO.puts "Head: #{inspect(head)} Tail: #{inspect(tail)}"
      [key, value] = String.split(head, ": ")
#IO.puts "Key: #{inspect(key)} Value: #{inspect(value)}"
#headers = Map.put(%[}, key, value])
      headers = Map.put(headers, key, value)
#IO.inspect(headers)
      parse_headers(tail, headers) 
  end

#def parse_headers([], headers) , do: IO.puts "Done"
  def parse_headers([], headers) , do: headers

  @doc """
  Parse hte given param string of the form `key1=value1&key2=value2`
  into a map with corresponding keys and values.
  ## Examples
  iex> str = "name=Ballo&type=Brown"
  iex> Servy.Parser.parse_params("application/x-www-form-urlencoded", str), 
  %{"name"=> "Ballo, "type" => "Brown"}
  iex> Servy.Parser.parse_params("multipart/form-data", str)
  %{}

  """
  def parse_params("application/x-www-form-urlencoded", params_sring) do
    params_sring |> String.trim |> URI.decode_query
 end 

  def parse_params(_, _) do
    %{}
  end

end
