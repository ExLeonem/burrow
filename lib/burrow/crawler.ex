defmodule Burrow.Crawler do
    @moduledoc """
        use Burrow.Crawler to create a new crawler.

        Options:
            name: Set a unique crawler name that will be used.


    """


    @doc """
        Automatically sets the Crawler behaviour and defines default functions to fetch content
        from a url and extract the contained links.
    """
    defmacro __using__(opts) do

        quote do
            @behavior Burrow.Crawler.Spec
            @name opts[:name]
            @base_url opts[:base_url]
            @policy Burrow.Crawler.Policy.Default


            def run() do
                
                fetch()

            end


            @doc """
                Fetches the content of a source.

                Parameters:
                url :: String.t() - The url from which to fetch the content
            """
            def fetch(url \\ @base_url) do

                :nil
            end


            
            @doc """
                Extract the links from the html content, pass the content to the parse function.            
            """
            def extract_links(content) do

                :nil
            end



            defp filter_links() do

                :nil
            end

            defoverridable start: 1, get_links: 1
        end
    end


    @doc """
        Starts the crawler. Options are getting passed to it.

        Parameters:
        - name: The crawler name
    """
    # @spec start(any) :: {:ok, String.t()}
    # def start(opts) do
    #     fetch(opts[:url])
    #     |> get_links
    #     |> parse
    #     |> forward
    # end


    defmodule Spec do
        @callback fetch(url :: String.t()) :: any
        @callback filter_links() :: any
        @callback parse(response :: any) :: any
        @callback forward() :: any

        @optional_callback fetch: 0, fetch: 1, filter_links: 0
    end
end