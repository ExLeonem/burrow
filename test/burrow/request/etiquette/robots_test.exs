defmodule Burrow.Request.Etiquette.RobotsTest do

    use ExUnit.Case
    require HTTPoison
    alias Burrow.Request.Etiquette.Robots


    describe "No robots.txt response." do

        test "Received strange format" do
            assert true
        end

        test "Non 200 response" do
            assert true
        end

    end

    
    describe "Parse robots.txt" do

        test "Empty robots" do
            assert true
        end


        test "Simple robots content" do
            assert true
        end



        test "Twitter robots.txt" do

            resp = HTTPoison.get!("https://twitter.com/robots.txt")
            content = resp.body

            parsed = Robots.parse(content)
            IO.inspect(parsed)

            assert false
        end
    end

end