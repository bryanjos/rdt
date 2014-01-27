defmodule RdtParseTest do
  use ExUnit.Case

  test "Parse Error" do
  	{_, json} = File.read("examples/rate_limit_error.json")
    assert(Rdt.Parser.parse(json) == {:error, "you are doing that too much. try again in 1 hour."})
  end

  test "Parse Listing" do
  	{_, json} = File.read("examples/listing.json")
  	{status, data} = Rdt.Parser.parse(json)
  	assert(status == :ok)
   	assert(Dict.has_key?(data, "children"))
  end

  test "Parse Article" do
  	{_, json} = File.read("examples/article.json")
  	{status, data} = Rdt.Parser.parse(json)
  	assert(status == :ok)
   	assert(length(data) == 2)
   	assert(data[:article]["id"] == "1w3syi")

   	{_, first_comment} = Enum.fetch(data[:comments], 0)
   	assert(first_comment["data"]["id"] == "ceyi79t")
  end

  test "Parse Me" do
  	{_, json} = File.read("examples/me.json")
  	{_, data} = Rdt.Parser.parse(json)
   	assert(data["id"] == "ey9a8")
  end

end
