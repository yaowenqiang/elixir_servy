# install

> wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
> sudo apt-get update
> sudo apt-get install esl-erlang
> sudo apt-get install elixir

# create and run a project

> mix new servy
> elixir lib/servy.ex  #run the code
> iex > String.reverse("peek")
> iex > c "lib/servy.ex"
> iex lib/servy.ex
> iex -S mix
> iex(1)> Servy.hello("world")
> iex > r Servy # recompile
> iex > h Strings.tab
> iex > h Map.put
> iex > h File.read

> for x <- [1,2,3], do: x * 3
