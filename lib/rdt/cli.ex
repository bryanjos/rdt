defmodule Rdt.CLI do

	@switches 	[ 
		help:		:boolean, 	
		hot:		:boolean,  
		comments:	:boolean, 
		search:		:boolean
	]

	@aliases 	[ 
		h:	:help, 
		lh:	:hot, 
		c:	:comments, 
		s:	:search
	]

  def main(argv) do
    argv 
      |> parse_args 
      |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: @switches ,
                                     aliases:  @aliases)
    case  parse  do

    { [ help: true ], 	_,           			_ } 	-> :help
    { [ hot: true ], 	[subreddit], 			_ } 	-> {:hot, subreddit}
    { [ hot: true ], 	_, 						_ } 	-> {:hot, ""}
    { [ search: true ], [query, subreddit], 	_ } 	-> {:search, query, subreddit}
    { [ search: true ], [query], 				_ } 	-> {:search, query, ""}
    { [ comments: true ], [subreddit, id], 		_ } 	-> {:comments, subreddit, id}

    _                                  					-> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage:  rdt [COMMAND] [COMMAND_PARAMETERS]

    commands:
    -h  --help								# This message
    -lh	--hot    	?<subreddit> 			# Get hot articles (subreddit optional)
    -c	--comments  <subreddit> <id> 		# Gets a specific article and comments
    -s	--search  	<query> ?<subreddit> 	# Search (subreddit optional)
    """
    System.halt(0)
  end

  def process({:hot, subreddit}) do
  	process_response(Rdt.Listings.get("hot", subreddit))
  end

  def process({:search, query, subreddit}) do
  	process_response(Rdt.Listings.search(query, subreddit))
  end

  def process({:comments, subreddit, id}) do
  	process_response(Rdt.Article.get(subreddit, id))
  end

  defp process_response(response) do
  	case response do
  		{:ok, body} 	-> IO.puts body
  		{:error, body} 	-> IO.puts body
  	end
  end
	
end