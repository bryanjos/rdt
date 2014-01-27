defmodule Rdt.Parser do
	def parse(response) do
		data = Jsonex.decode(response)

		if !is_list(hd(data)) do
			cond do
				Dict.has_key? data, "json" ->
					{_, data} = hd(data)
	                errors = hd(data["errors"])
	                {_, error_message} = Enum.fetch(errors, 1)
	                {:error, error_message}	
				Dict.has_key? data, "errors" ->
					errors = hd(data["errors"])
					{_, error_message} = Enum.fetch(errors, 1)
					{:error, error_message}
				true ->
					{:ok, data["data"]}
			end				
		else
			{_, article} = Enum.fetch(hd(data)["data"]["children"], 0)
			{_, comments} = Enum.fetch(data, 1)
			{:ok, [article: article["data"], comments: comments["data"]["children"]] }	
		end
	end
end