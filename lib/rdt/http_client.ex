defmodule Rdt.HTTPClient do
  	alias HTTPotion.Response

	@redditApiUrl "http://www.reddit.com/"
  	@user_agent  [ "User-agent": "rdt/0.0.1"]

  	def get(endpoint, headers // []) do
  		response = HTTPotion.get(@redditApiUrl <> endpoint, Enum.concat(@user_agent, headers)) 
  		handle_response(response)
  	end

  	def post(endpoint, body // "", headers // []) do
	    response = HTTPotion.post(@redditApiUrl <> endpoint, body, Enum.concat(@user_agent, headers))
  		handle_response(response)
  	end

  	def put(endpoint, body // "", headers // []) do
	    response = HTTPotion.put(@redditApiUrl <> endpoint, body, Enum.concat(@user_agent, headers))
  		handle_response(response)
  	end

  	def delete(endpoint, headers // []) do
  		response = HTTPotion.delete(@redditApiUrl <> endpoint, Enum.concat(@user_agent, headers)) 
  		handle_response(response)
  	end

  	defp handle_response(response) do
 	    case response do
	      Response[body: body, status_code: status, headers: _headers ]  ->
	        Rdt.Parser.parse(body)
	      _ ->
			{:error, "An error occured"}
	    end 		
  	end
end