defmodule Rdt.Listings do

	def get(listing_type, subreddit // "", afterThing // "") do
		url = "#{listing_type}.json"

		if subreddit != "" do
			url = "r/#{subreddit}/" <> url
		end

		if afterThing != "" do
			url = url <> "?after=#{afterThing}"
		end

		case Rdt.HTTPClient.get(url) do
			{:ok, data} ->
				{:ok, parseListingData(data)}
			{:error, data} ->
				{:error, data}
		end
	end

	defp parseListingData(data) do
		Enum.map(data["children"], &createRow(&1))
	end


	defp createRow(child) do
		"""
			#{child["data"]["title"]}
			#{child["data"]["url"]}
			Submitted By: #{child["data"]["author"]}
			Name: #{child["data"]["name"]}
			Id: #{child["data"]["id"]}
			↑ #{child["data"]["ups"]}, ↓ #{child["data"]["downs"]}


		"""
	end
	
end