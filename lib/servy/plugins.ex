defmodule Servy.Plugins do
  alias Servy.Conv
  @doc "Log 404 requests"
  def track(%Conv{status: 404, path: path} = conv) do
    IO.puts "Warning: #{path} is no the loose!"
    conv
  end
  def track(conv), do: conv

  def rewrite_path(%Conv{path: "/wildlife"} = conv) do
    %{conv | path: "/wildthings" } 
  end

  def rewrite_path(%Conv{} = conv), do: conv

  def log(%Conv{} = conv) , do:  IO.inspect conv
end
