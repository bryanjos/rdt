defmodule Rdt.CLI do

  def main(argv) do
    argv 
      |> parse_args 
      |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean, 	login: :boolean, 	me: :boolean],
                                     aliases:  [ h:    :help, 		l: :login, 			m: :me])
    case  parse  do

    { [ help: true ], _,           _ } 				-> :help
    { [ login: true ], [username, password], _ } 	-> { username, password }
    { [ me: true ], _, _ } 							-> :me
    _                                  				-> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage:  rdt [COMMAND] [COMMAND_PARAMETERS]

    commands:
    -h --help								# This message
    -l --login 	<username> <password>		# Login to your reddit account
    -m --me 								# Get data about yourself
    """
    System.halt(0)
  end

  def process({username, password}) do
  	process_response(Rdt.Account.login(username, password))
  end

  def process(:me) do
  	process_response(Rdt.Account.me())
  end

  defp process_response(response) do
  	case response do
  		{:ok, body} 	-> IO.puts body
  		{:error, body} 	-> IO.puts body
  	end
  end
	
end