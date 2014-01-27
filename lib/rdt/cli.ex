defmodule Rdt.CLI do

	@switches 	[ 
		help:			:boolean,
		controversial: 	:boolean,  	
		hot:			:boolean, 
		new:			:boolean,
		top:			:boolean,    
		comments:		:boolean, 
		search:			:boolean
	]

	@aliases 	[ 
		h:	:help,
		cl:	:controversial,  
		hl:	:hot, 
		nl:	:new, 
		tl:	:top, 
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

    { [ controversial: true ], 	[subreddit], 	_ } 	-> {:controversial, subreddit}
    { [ controversial: true ], 	_, 				_ } 	-> {:controversial, ""}

    { [ hot: true ], 	[subreddit], 			_ } 	-> {:hot, subreddit}
    { [ hot: true ], 	_, 						_ } 	-> {:hot, ""}

    { [ new: true ], 	[subreddit], 			_ } 	-> {:new, subreddit}
    { [ new: true ], 	_, 						_ } 	-> {:new, ""}

    { [ top: true ], 	[subreddit], 			_ } 	-> {:top, subreddit}
    { [ top: true ], 	_, 						_ } 	-> {:top, ""}

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
    -cl	--controversial    	?<subreddit> 	# Get controversial articles (subreddit optional)
    -hl	--hot    	?<subreddit> 			# Get hot articles (subreddit optional)
    -nl	--new    	?<subreddit> 			# Get new articles (subreddit optional)
    -tl	--top    	?<subreddit> 			# Get top articles (subreddit optional)
    -c	--comments  <subreddit> <id> 		# Gets a specific article and comments
    -s	--search  	<query> ?<subreddit> 	# Search (subreddit optional)
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