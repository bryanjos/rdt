# Rdt

Command line Reddit built in Elixir.

Compile:
```
mix deps.get
mix escriptize
```

Usage:
```
    usage:  rdt [COMMAND] [COMMAND_PARAMETERS]

    commands:
    help									# This message
    list [-c[--controversial], -h[--hot], -t[--top], -n[--new]] ?<subreddit> # Get controversial articles (subreddit optional)
    view <subreddit> <id> 					# Gets a specific article and comments
    search <query> ?<subreddit> 		# Search (subreddit optional)
```
