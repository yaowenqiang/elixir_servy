defmodule Servy.Plugins do
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
end
