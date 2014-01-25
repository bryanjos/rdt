defmodule Rdt.Parser do
	def parse(response) do
		data = Jsonex.decode(response)
		cond do
			Dict.has_key? data, "data" ->
				{:ok, data["data"]}	
			Dict.has_key? data, "json" ->
				{_, data} = hd(data)
                new_body = hd(data["errors"])
                error_type = hd(new_body)
                {_, error_message} = Enum.fetch(new_body, 1)

                {:error, error_message}				
			true ->
				new_body = hd(data["errors"])
				{_, error_type} = Enum.fetch(new_body, 0)
				{_, error_message} = Enum.fetch(new_body, 1)

				{:error, error_message}				 			
		end
	end
end