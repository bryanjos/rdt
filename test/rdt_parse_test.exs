defmodule RdtParseTest do
  use ExUnit.Case

  test "Error Parse" do
  	error_json = "{\"json\": {\"errors\": [[\"RATELIMIT\",\"you are doing that too much. try again in 1 hour.\",\"vdelay\"]]}}"
    assert(Rdt.Parser.parse(error_json) == {:error, "you are doing that too much. try again in 1 hour."})
  end

  test "Success Parse" do
  	success_json = "{\"kind\": \"Listing\", \"data\": { \"modhash\": \"modhash\", \"cookie\": \"cookie\"}}"
  	{status, data} = Rdt.Parser.parse(success_json)
  	assert(status == :ok)
   	assert(data["modhash"] == "modhash")
  end
end
