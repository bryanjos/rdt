defmodule Rdt.HTTPClient do
  	alias HTTPotion.Response

	@redditApiUrl "http://www.reddit.com/"
  	@user_agent  [ "User-agent": "rdt/0.0.1"]

  	def get(endpoint, headers // []) do
  		HTTPotion.get(@redditApiUrl <> endpoint, Enum.concat(@user_agent, headers)) |> handle_response
  	end

  	def post(endpoint, body // "", headers // []) do
	    HTTPotion.post(@redditApiUrl <> endpoint, body, Enum.concat(@user_agent, headers)) |> handle_response
  	end

  	def put(endpoint, body // "", headers // []) do
	   	HTTPotion.put(@redditApiUrl <> endpoint, body, Enum.concat(@user_agent, headers)) |> handle_response
  	end

  	def delete(endpoint, headers // []) do
  		HTTPotion.delete(@redditApiUrl <> endpoint, Enum.concat(@user_agent, headers)) |> handle_response
  	end

  	defp handle_response(response) do
 	    case response do
	      Response[body: body, status_code: _status, headers: _headers ]  ->
	        Rdt.Parser.parse(body)
	      _ ->
			{:error, "An error occured"}
	    end 		
  	end
end