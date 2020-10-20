defmodule Burrow.Crawler do
    @moduledoc """
        use Burrow.Crawler to create a new crawler.

        Options:
            name: Set a unique crawler name that will be used.
            policy: The policy to be used.
            base_url: Starting point

    """

    # http://erlang.org/doc/man/pool.html


    # https://medium.com/learn-elixir/supervisors-and-workers-in-10-minutes-83fbad6f16d1

    @doc """
        Automatically sets the Crawler behaviour and defines default functions to fetch content
        from a url and extract the contained links.
    """
    defmacro __using__(opts) do


        # Crawler name for identification, defaults to caller module name
        caller_module = __CALLER__.module 
        caller_module_string = caller_module |> to_string |> String.replace(".", "")
        name = Keyword.get(opts, :name, caller_module_string)

        base_url = Keyword.get(opts, :base_url, nil)
        policy = Keyword.get(opts, :policy, Burrow.Crawler.Policy.Default)

        concurrent_count = Keyword.get(opts, :con_count, 5)
        depth_limit = Keyword.get(opts, :depth, nil)


        # Check if optional functions are exported
        has_filter = function_exported?(__CALLER__.module, :filter_links, 1)

        quote do
            require Logger
            require Floki
            require HTTPoison
            @behavior Burrow.Crawler.Spec


            defmodule Worker do
                
                @name unquote(name)
                @base_url unquote(base_url)
                @policy unquote(policy)
                @has_filter 

                def run(args) do

                    # Run scheduler adadpter in here, 

                    content = args |> fetch |> extract_links
                    apply(unquote(__CALLER__.module), :parse, [content])
                end
    

                @doc """
                    Fetches the content of a source.
    
                    Parameters:
                    url :: String.t() - The url from which to fetch the content
                """
                def fetch(url \\ @base_url) do

                    resp = HTTPoison.get!(url)

                    case resp.status_code do
                        
                        # Success proceed
                        200 -> 
                            {:ok, document} = Floki.parse_document(resp)
                            document

                        # Potentially blocked by the server
                        x when x in [303, 400] -> 
                            Logger.info("The server potentially blocked you. Crawler exiting.")
                    end
                end
    

                if unquote(has_filter) do
                    def extract_links(document) do
                        links = Floki.attribute(document, "a", "href")
                        filtered = apply(unquote(__CALLER__.module), :filter_links, [links])
                        # Do something with the links
    
                        # Pass the document on
                        document
                    end     
                else

                    def extract_links(document) do
                        links = Floki.attribute(document, "a", "href")
                        # Do something with filtered links

                        
                        # Pass The document on
                        document
                    end 
                end



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
            end



            # Workerpool will be generated in another directory
            defmodule Pool do
                @moduledoc """
                    Supervise a group of crawlers.    

                """
                use Supervisor
        
                defp poolboy_config do
                    [
                        name: {:local, unquote(name <> "-pool" )},
                        worker_module: unquote(Module.concat(caller_module, Worker)),
                        size: 10,
                        max_overflow: 2
                    ]
                end


                def start(_type, _args) do
                    children = [
                        :poolboy.child_spec(:worker, poolboy_config())
                    ]

                    opts = [strategy: :one_for_one, name: unquote(Module.concat(caller_module, Pool, Supervisor))]
                    Supervisor.start_link(children, opts)
                end


                # def start_link(init_arg) do
                #     Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
                # end

        
                # @doc """
                #     Arguments:
                #         crawler_count: count,
                #         policy: 
                # """
                # @impl true
                # def init(args) do

                #     crawler_name = unquote(name)
                #     children = Enum.map(1.. unquote(concurrent_count), fn (count) -> 
                #         {unquote(caller_module), [bot_name: "BOT:#{crawler_name}:#{count}"]}
                #     end)

                #     # URL Queue
                #     children ++ []
        
                #     Supervisor.init(children, strategy: :one_for_one)
                # end
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
        @callback filter_links(links :: any) :: any
        @callback forward() :: any

        @optional_callback filter_links: 1, forward: 1
    end
end