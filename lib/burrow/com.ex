defmodule Burrow.Com do
    @moduledoc """
        HTTP Client

        https: 443
        http: 80

        Guide: https://scoutapm.com/blog/how-to-use-mint-an-awesome-http-library-for-elixir-part-01
    """
    

    @doc """

    """
    def get(url, opts \\ []) do
        request(url, :GET, opts)
    end


    def post(url, opts \\ []) do
        request(url, :POST, opts)
    end


    @doc """
        Issue a request to a http or https address.

        Parameters:
            url: 
            method: The method to use, choose from HTTP Methods (:GET, :POST, :DELETE, ...)
            raw_opts: Additional options that can be passed. [:headers, :body, :proxy]

        Return:
            {response ::, meta}
    """
    def request(url, method, raw_opts) do

        # Set default options if not available
        opts = set_defaults(raw_opts)

        # Split url into parts
        uri = URI.parse(url)

        default_con_opt = [protocols: [:http1]]
        conn_opt = if opts.proxy != {}, do: Keyword.put(default_con_opt, :proxy, opts.proxy), else: default_con_opt
        {:ok, conn} = Mint.HTTP.connect(String.to_atom(uri.scheme), uri.host, uri.port, conn_opt)

        # Make the request
        start_request = Time.utc_now()    
        {:ok, conn, request_ref} = Mint.HTTP.request(conn, to_string(method), uri.path, opts.headers, opts.body)

        # response = nil
        receive do
            message -> 
                {:ok, conn, responses} = Mint.HTTP.stream(conn, message)
                # IO.inspect(responses)
                # IO.inspect(conn)
                Mint.HTTP.close(conn)
                end_time = Time.utc_now()
                responses
        after
            1_000 -> 
        end
    end


    @doc """
        Update the currenty latency value
    """
    defp set_meta(latency) do

    end


    @doc """
        Set default parameters for 
    """
    defp set_defaults(opts) do
        defaults = %{
            headers: [],
            body: nil,
            proxy: {}
        }

        parsed_options = Enum.into(opts, defaults)
    end
end