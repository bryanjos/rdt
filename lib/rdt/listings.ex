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
				{:ok, parse_listing_data(data)}
			{:error, data} ->
				{:error, data}
		end
	end

	def search(query, subreddit // "") do
		url = "search.json?q=#{query}"

		if subreddit != "" do
			url = "r/#{subreddit}/" <> url
		end

		case Rdt.HTTPClient.get(url) do
			{:ok, data} ->
				{:ok, parse_listing_data(data)}
			{:error, data} ->
				{:error, data}
		end
	end

	defp parse_listing_data(data) do
		Enum.map(data["children"], &createRow(&1))
	end


	defp createRow(child) do
		"""
			#{child["data"]["title"]}
			#{child["data"]["url"]}
			Submitted By: #{child["data"]["author"]}
			Name: #{child["data"]["name"]}
			Id: #{child["data"]["id"]}
			/r/#{child["data"]["subreddit"]}
			↑ #{child["data"]["ups"]}, ↓ #{child["data"]["downs"]}


		"""
	end
	
end