defmodule Servy.Handler do
  @moduledoc "Handle HTTP requests"

  @pages_path  Path.expand("../../pages", __DIR__)

  @doc "Transforms a request into a response."
  def handle(request) do
#conv = parse(request)    
#conv = route(conv)
#format_response(conv)
    request 
    |> parse 
    |> rewrite_path 
    |> log 
    |> route 
    |> track 
    |> format_response
  end


  @doc "Log 404 requests"
  def track(%{status: 404, path: path} = conv) do
    IO.puts "Warning: #{path} is no the loose!"
    conv
  end
  def track(conv), do: conv

  def rewrite_path(%{path: "/wildlife"} = conv) do
    %{conv | path: "/wildthings" } 
  end

  def rewrite_path(conv), do: conv

  def log(conv) , do:  IO.inspect conv

  def parse(request) do
    [method, path, _] = 
      request 
      |> String.split("\n") 
      |> List.first
      |> String.split(" ")

    %{ method: method, 
      path: path, 
      resp_body: "",
      status: nil
    }
  end


#def route(conv) do
    #conv[:method]
    #conv.method
    #conv = %{ method: "GET", path: "/wildthings", resp_body: "Bears, Lions, Tigers"}
    #%{conv | resp_body: "Bears, Lions, Tigers" }
    #route(conv, conv.method, conv.path)
#  end

#def route(%{method: "GET", path: "/wildthings"}) do

#end


#def route(conv,"GET",  "/wildthings") do
  def route(%{ method: "GET",path: "/wildthings" } = conv ) do
    %{conv | status: 200, resp_body: "Bears, Lions, Tigers" }
  end

#def route(conv,"GET", "/bears") do
  def route(%{method: "GET",path: "/bears" } = conv ) do
    %{conv | status: 200, resp_body: "Teddy, Smokey, Paddington" }
  end
  #pattern match /bears/1
#def route(conv,"GET", "/bears/" <> id) do
  def route(%{method: "GET",path: "/bears" <> id } = conv ) do
    %{conv | status: 200, resp_body: "Bear #{id}" }
  end


  def route(%{method: "GET",path: "/about" } = conv ) do
    #pages_path = Path.expand("../../pages", __DIR__)
    #file = Path.join(pages_path, "about.html")
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


#def route(conv, _method, path) do
#   %{conv | status: 404, resp_body: "No #{path} here!" } 
#  end

def route(%{path: path} = conv) do
   %{conv | status: 404, resp_body: "No #{path} here!" } 
  end

  def format_response(conv) do
    """
    HTTP/1.1 #{conv.status} #{status_reson(conv.status)}
    Content-type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """

  end

  #private function
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
