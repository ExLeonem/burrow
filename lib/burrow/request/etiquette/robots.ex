defmodule Burrow.Request.Etiquette.Robots do
    @moduledoc """
        Process the robots.txt of a webpage and use it's content.

        Example robots.txt content:

            Sitemap: https://www.mydomain.com/sitemap.xml

            User-agent: *
            Allow: /public/*
            Disallow: /secret_content/*
            Crawl_delay: 100

            User-agent: google-bot
            Disallow: /specific_url
    """
    require HTTPoison

    @doc """
        Parse the content of the robots.txt
    """
    def request(url) do
        
        url
        |> get_robots
        |> parse
    end


    @doc """
        Get the robots.txt for the current domain to be crawled.
    """
    def get_robots(url) do
        
        parsed = URI.parse(url)
        base_url = %URI{authority: parsed.authority, host: parsed.host, port: parsed.port, scheme: parsed.scheme}
        robots_url = Path.join([URI.to_string(base_url), "robots.txt"])

        # Parse the response
        content = HTTPoison.get(robots_url)

        # case content.status_code do
        #     200 -> parse(content.)
        # end
    end

    
    @doc """
        Process the content of the robots.txt

        Parameters:
            robots_content (): Content of the robots file.
    """
    def parse(robots_content) do

        robots_content
        |> String.split("\n")
        |> Enum.reduce(%{}, fn (entry, acc) ->
        
            new_acc = acc
            if String.at(entry, 0) != "#" && entry != "" do

                splitted_codes = String.split(entry, ": ")
                {key, path} = parse_key_path(splitted_codes)

                IO.puts(key)
                IO.puts(path)

                if key != :"" && path != "" do
                    
                    # May throw an error on malformed robots, needs to be updated with trie
                    old_paths = Map.get(new_acc, key, [])
                    new_acc = Map.put(new_acc, key, [path | old_paths])
                end
            end
            IO.inspect(new_acc)
            new_acc
        end)
    end


    @doc """
        Parse a line of robots.txt into tuple of {directive, value}
    """
    defp parse_key_path([directive | [path]]) when is_bitstring(directive) and is_bitstring(path) do
        normalized_directive = directive |> String.downcase |> String.to_atom
        {normalized_directive, path}

    end
    defp parse_key_path(_), do: {"", ""}


    @doc """
        Update 
    """
    defp update_robots_map(map, (:allowed = directive) , value) when directive in [:allowed, :disallow] do
        old_list = Map.get(map, directive)
    end


    defmodule RobotsScheme do
        defstruct  user_agent: "", allow: %{}, disallow: %{}
    end
end