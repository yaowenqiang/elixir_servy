defmodule Servy.Handler do
  def handle(request) do
#conv = parse(request)    
#conv = route(conv)
#format_response(conv)
    request 
    |> parse 
    |> log 
    |> route 
    |> format_response
  end

  def log(conv) , do:  IO.inspect conv

  def parse(request) do
    [method, path, _] = 
      request 
      |> String.split("\n") 
      |> List.first
      |> String.split(" ")
    %{ method: method, path: path, resp_body: ""}
  end

  def route(conv) do
    #conv[:method]
    #conv.method
    #conv = %{ method: "GET", path: "/wildthings", resp_body: "Bears, Lions, Tigers"}
    #%{conv | resp_body: "Bears, Lions, Tigers" }
    route(conv, conv.method, conv.path)
  end

  def route(conv,"GET",  "/wildthings") do
    %{conv | resp_body: "Bears, Lions, Tigers" }
  end

  def route(conv,"GET", "/bears") do
    %{conv | resp_body: "Teddy, Smokey, Paddington" }
  end

  def format_response(conv) do
    """
    HTTP/1.1 200 ok
    Content-type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """

  end
end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

expected_response = """
HTTP/1.1 200 ok
Content-type: text/html
Content-Length: 20

Bears, Lions, Tigers
"""


response = Servy.Handler.handle(request)
IO.puts response

request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response


request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response
