defmodule Servy.BearController do
  alias Servy.Wildthings
  alias Servy.Bear


  def bear_item(bear) do
    "<li>#{bear.name} - #{bear.type}</li>"
  end
  def index(conv) do 
    items = 
      Wildthings.list_bears()
#|> Enum.filter(fn(b) -> Bear.is_grizzly(b) end)
#|> Enum.filter(&Bear.is_grizzly(&1))
      |> Enum.filter(&Bear.is_grizzly/1)
#|> Enum.sort(fn(b1, b2) -> Bear.order_asc_by_name(b1, b2) end)
#|> Enum.sort(&Bear.order_asc_by_name(&1, &2))
      |> Enum.sort(&Bear.order_asc_by_name/2)
#|> Enum.map(fn(b) -> bear_item(b) end)
#|> Enum.map(&bear_item(&1))
      |> Enum.map(&bear_item/1)
#|> Enum.map(fn(b) -> "<li>#{b.name} - #{b.type}</li>" end)
      |> Enum.join()
    
    
#%{conv | status: 200, resp_body: "Teddy, Smokey, Paddington" }
#%{conv | status: 200, resp_body: "Teddy, Smokey, Paddington" }
    %{conv | status: 200, resp_body: "<ul>#{items}</ul>" }
  end

  def show(conv, %{"id" => id}) do 
    bear = Wildthings.get_bear(id)
    %{conv | status: 200, resp_body: "<h1>#{bear.id}: #{bear.name}</h1>" }
  end

  def create(conv, %{"name" => name, "type" => type} = params) do 
    %{ conv | status: 201,
              resp_body: "Create a #{type}, bear named #{name}!"}
  end
end
