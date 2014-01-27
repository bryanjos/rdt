defmodule Rdt.CLI do

  def main(argv) do
    argv 
      |> parse_argv 
      |> process
  end

  def parse_argv(argv) do
  	cond do
  		length(argv) == 0 ->
  			:help
  		hd(argv) == "list" ->
			parse_args({:list, tl(argv)}) 
   		hd(argv) == "view" ->
			parse_args({:list, tl(argv)}) 
   		hd(argv) == "search" ->
			parse_args({:search, tl(argv)}) 
   		true ->
   			:help
  	end
  end

  defp parse_args({:list, args}) do
    parse = OptionParser.parse(args, switches: [ controversial: :boolean, hot: :boolean, new: :boolean, top: :boolean],
                                     aliases:  [ c: :controversial, h: :hot, n: :new, t: :top])
    case  parse  do

	    { [ controversial: true], [subreddit], 	_ }  -> {:controversial, subreddit}
	    { [ controversial: true ], 	_, 				_ } 	 -> {:controversial, ""}

	    { [ hot: true], 	[subreddit], 			_ } 	-> {:hot, subreddit}
	    { [ hot: true ], 	_, 						_ } 	-> {:hot, ""}

	    { [ new: true], 	[subreddit], 			_ } 	-> {:new, subreddit}
	    { [ new: true ], 	_, 						_ } 	-> {:new, ""}

	    { [ top: true], 	[subreddit], 			_ } 	-> {:top, subreddit}
	    { [ top: true ], 	_, 						_ } 	-> {:top, ""}

	    _                                  					-> :help
    end
  end

  defp parse_args({:view, args}) do
  	if length(args) != 2 do
  		:help
  	else
  		{:comments, hd(args), List.last(args)}
  	end
  end

  defp parse_args({:search, args}) do
  	cond do
  		length(args) == 0 ->
  			:help
  		length(args) == 1 ->
  			{:search, hd(args), ""}
    	length(args) == 2 ->
  			{:search, hd(args), List.last(args)}
  		true ->
  			:help
  	end
  end

  def process(:help) do
    IO.puts """
    usage:  rdt [COMMAND] [COMMAND_PARAMETERS]

    commands:
    help									# This message
    list [-c[--controversial], -h[--hot], -t[--top], -n[--new]] ?<subreddit> # Get controversial articles (subreddit optional)
    view <subreddit> <id> 					# Gets a specific article and comments
    search <query> ?<subreddit> 		# Search (subreddit optional)
    """
    System.halt(0)
  end

  def process({listing_type, subreddit}) do
  	Rdt.Listings.get(to_string(listing_type), subreddit) |> process_response
  end

  def process({:search, query, subreddit}) do
  	Rdt.Listings.search(query, subreddit) |> process_response
  end

  def process({:comments, subreddit, id}) do
  	Rdt.Article.get(subreddit, id) |> process_response
  end

  defp process_response(response) do
  	case response do
  		{:ok, body} 	-> IO.puts body
  		{:error, body} 	-> IO.puts body
  	end
  end
	
end