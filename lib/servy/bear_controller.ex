defmodule Servy.BearController do
  alias Servy.Wildthings
  alias Servy.Bear

  @template_path  Path.expand("../../templates", __DIR__)

  def bear_item(bear) do
    "<li>#{bear.name} - #{bear.type}</li>"
  end

  defp render(conv, template, bindings \\ []) do #\\  means to set default value
    content = 
      @template_path 
      |> Path.join(template)
      |> EEx.eval_file(bindings)
      %{conv | status: 200, resp_body: content }
  end

  def index(conv) do 
    #items = 
    bears = 
      Wildthings.list_bears()
#|> Enum.filter(fn(b) -> Bear.is_grizzly(b) end)
#|> Enum.filter(&Bear.is_grizzly(&1))
#|> Enum.filter(&Bear.is_grizzly/1)
#|> Enum.sort(fn(b1, b2) -> Bear.order_asc_by_name(b1, b2) end)
#|> Enum.sort(&Bear.order_asc_by_name(&1, &2))
      |> Enum.sort(&Bear.order_asc_by_name/2)
#|> Enum.map(fn(b) -> bear_item(b) end)
#|> Enum.map(&bear_item(&1))
#|> eNUM.map(&bear_item/1)
#|> Enum.map(fn(b) -> "<li>#{b.name} - #{b.type}</li>" end)
#|> eNUM.join()
    
    
#%{conv | status: 200, resp_body: "Teddy, Smokey, Paddington" }
#%{conv | status: 200, resp_body: "Teddy, Smokey, Paddington" }
#    %{conv | status: 200, resp_body: "<ul>#{items}</ul>" }
#content = 
    @template_path 
    |> Path.join("index.eex")
#|> EEx.eval_file([bears: bears])
#|> EEx.eval_file(bears: bears)

#    %{conv | status: 200, resp_body: content }
    render(conv, "index.eex", bears: bears)
  end

  def show(conv, %{"id" => id}) do 
    bear = Wildthings.get_bear(id)

#  content = 
#    @template_path 
#    |> Path.join("show.eex")
#    |> EEx.eval_file(bear: bear)

#%{conv | status: 200, resp_body: content }
    render(conv, "show.eex", bear: bear)
  end

  def create(conv, %{"name" => name, "type" => type} = params) do 
    %{ conv | status: 201,
              resp_body: "Create a #{type}, bear named #{name}!"}
  end
end
