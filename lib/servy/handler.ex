defmodule Servy.Handler do
  @moduledoc "Handle HTTP requests"

  alias Servy.Conv

  @pages_path  Path.expand("../../pages", __DIR__)
  import Servy.Plugins, only: [rewrite_path: 1, log: 1, track: 1]
  import Servy.Parser, only: [parse: 1]

  @doc "Transforms a request into a response."
  def handle(request) do
#conv = parse(request)    
#conv = route(conv)
#format_response(conv)
    request 
    |> parse 
#|> Servy.Plugins.rewrite_path 
    |> rewrite_path 
    |> log 
    |> route 
    |> track 
    |> format_response
  end

#def route(%Conv{} = conv) do
    #conv[:method]
    #conv.method
    #conv = %{ method: "GET", path: "/wildthings", resp_body: "Bears, Lions, Tigers"}
    #%{conv | resp_body: "Bears, Lions, Tigers" }
    #route(%Conv{} = conv, conv.method, conv.path)
#  end

#def route(%Conv{method: "GET", path: "/wildthings"}) do

#end


#def route(%Conv{} = conv,"GET",  "/wildthings") do
  def route(%Conv{ method: "GET",path: "/wildthings" } = conv ) do
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers" }
  end

#def route(%Conv{} = conv,"GET", "/bears") do
  def route(%Conv{method: "GET",path: "/bears" } = conv ) do
    %{conv | status: 200, resp_body: "Teddy, Smokey, Paddington" }
  end
  #pattern match /bears/1
#def route(%Conv{} = conv,"GET", "/bears/" <> id) do
  def route(%Conv{method: "GET",path: "/bears" <> id } = conv ) do
    %{conv | status: 200, resp_body: "Bear #{id}" }
  end


  def route(%Conv{method: "GET",path: "/about" } = conv ) do
    #pages_path = Path.expand("../../pages", __DIR__)
    #file = Path.join(pages_path, "about.html")

  def route(%Conv{method: "POST",path: "/bears" } = conv ) do
    %{ conv | status: 201,
              resp_body: "Create a #{conv.param["type"]}, bear named #{conv.params["name"]}!"}

#Path.expand("../../pages", __DIR__)
      @pages_path
      |> Path.join("about.html")
      |>  File.read() 
      |> handle_file(conv)
    end

    def handle_file({:ok, content}, conv) do
        %{conv | status: 200, resp_body: content}
    end

    def handle_file({:error, :enoent}, conv) do
        %{conv | status: 404, resp_body: "File not found!"}
    end

    def handle_file({:error, reason}, conv) do
        %{conv | status: 500, resp_body: "File error: #{reason}"}
    end

#    case file = File.read(file) do
#      {:ok, content} -> 
#        log(file)
#        %{conv | status: 200, resp_body: content}
#      {:error, :enoent} -> 
#        log(file)
#        %{conv | status: 404, resp_body: "File not found!"}
#      {:error, reason} -> 
#        log(file)
#        %{conv | status: 500, resp_body: "File error: #{reason}"}
#    end
    #%{conv | status: 200, resp_body: "contest of file" }
#  end


#def route(%Conv{} = conv, _method, path) do
#   %{conv | status: 404, resp_body: "No #{path} here!" } 
#  end

def route(%Conv{path: path} = conv) do
   %{conv | status: 404, resp_body: "No #{path} here!" } 
  end

  def format_response(%Conv{} = conv) do
    """
    HTTP/1.1 #{Conv.full_status(conv)}}
    Content-type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """

  end

  #private function

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

request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response

request = """
GET /wildlife HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response

request = """
GET /about HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)
IO.puts response

request = """
POST /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded
Content-Length: 21

name=Baloo&type=Brown
"""

response = Servy.Handler.handle(request)
IO.puts response
