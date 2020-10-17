defmodule Burrow.Crawler do
    @moduledoc """
        use Burrow.Crawler to create a new crawler.

        Options:
            name: Set a unique crawler name that will be used.

    """

    # http://erlang.org/doc/man/pool.html


    require Logger


    # https://medium.com/learn-elixir/supervisors-and-workers-in-10-minutes-83fbad6f16d1

    @doc """
        Automatically sets the Crawler behaviour and defines default functions to fetch content
        from a url and extract the contained links.
    """
    defmacro __using__(opts) do


        # Crawler name for identification, defaults to caller module name
        caller_module = __CALLER__.module |> to_string |> String.replace(".", "")
        name = Keyword.get(opts, :name, caller_module)

        base_url = Keyword.get(opts, :base_url, nil)
        policy = Keyword.get(opts, :policy, Burrow.Crawler.Policy.Default)

        concurrent_count = Keyword.get(opts, :con_count, 5)
        depth_limit = Keyword.get(opts, :depth, nil)


        quote do
            @require Floki
            @behavior Burrow.Crawler.Spec

            @name unquote(name)
            @base_url unquote(base_url)
            @policy unquote(policy)


            def run(args) do

                # fetch
                # |> extract_links
                # |> filter_links
            end


            def test() do

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

            defoverridable run: 1


            @doc """
                https://hexdocs.pm/elixir/master/Supervisor.html#module-child-specification
            """
            def child_spec(arg) do
                %{
                    id: @name,
                    start:  {@name, :start_link, [arg]}
                }
            end


            def start_link(args) do
                pid = spawn_link(__MODULE__, :run, args)
            end



            defmodule Group do
                @moduledoc """
                    Supervise a group of crawlers.    

                """
                use Supervisor
        
                
                def start_link(init_arg) do
                    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
                end

        
                @doc """
                    Arguments:
                        crawler_count: count,
                        policy: 
                """
                @impl true
                def init(args) do

                    crawler_name = unquote(name)
                    children = Enum.map(1.. unquote(concurrent_count), fn (count) -> 
                        {unquote(caller_module), [bot_name: "BOT:#{crawler_name}:#{count}"]}
                    end)

                    # URL Queue
                    children ++ []
        
                    Supervisor.init(children, strategy: :one_for_one)
                end
            end
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

        @optional_callback fetch: 1, filter_links: 0
    end
end