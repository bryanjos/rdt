defmodule Rdt.Parser do
	def parse(response) do
		{_, data} = JSON.decode(response)

		cond do
			is_list(data) ->
				{_, article} = Enum.fetch(hd(data)["data"]["children"], 0)
				{_, comments} = Enum.fetch(data, 1)
				{:ok, [article: article["data"], comments: comments["data"]["children"]] }	
			Dict.has_key? data, "json" ->
                errors = hd(data["json"]["errors"])
                {_, error_message} = Enum.fetch(errors, 1)
                {:error, error_message}	
			Dict.has_key? data, "errors" ->
				errors = data["errors"]
				{_, error_message} = Enum.fetch(errors, 1)
				{:error, error_message}
			true ->
				{:ok, data["data"]}
		end
	end
end