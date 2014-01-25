defmodule Rdt.Parser do
	
	def parse(response) do
		{_, data} = hd(Jsonex.decode(response))
		if Enum.empty? data["errors"] do
			{:ok, data["data"]}
		else
			new_body = hd(data["errors"])
			error_type = hd(new_body)
			{_, error_message} = Enum.fetch(new_body, 1)

			{:error, error_message}
		end
	end
end