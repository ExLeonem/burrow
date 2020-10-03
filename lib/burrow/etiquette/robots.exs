defmodule Burrow.Etiquette.Robots do
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


    @doc """
        Parse the content of the robots.txt
    """
    def parse(content) do
        :nil
    end


    defp

end