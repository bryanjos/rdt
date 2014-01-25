defmodule Rdt.Account do
	def login(username, password) do
		Rdt.HTTPClient.post("login/#{username}?user=#{username}&passwd=#{password}&api_type=json")
	end

	def me() do
		Rdt.HTTPClient.post("me.json")
	end
end