# Rdt

Command line Reddit built in Elixir.

Compile:
```
mix deps.get
mix escriptize
```

Usage:
```
    usage:  rdt (COMMAND) [COMMAND_PARAMETERS]

    commands:
    help									# This message
    list (listing) [subreddit] 				# Get controversial articles (subreddit optional)

    	listing:
    		-c, --controversial Controversial Listings
    		-h, --hot           Hot Listings
    		-t, --top           Top Listings
    		-n, --new           New Listings

    view (subreddit) (article_id)			# Gets a specific article and comments
    search (query) [subreddit] 				# Search (subreddit optional)
```
