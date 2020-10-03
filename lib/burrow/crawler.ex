defmodule Burrow.Crawler do
    @behaviour Crawler
    

    @callback fetch() :: any
    @callback parse() :: any
    @callback forward() :: any


    @doc """
        Starts the crawler. Options are getting passed to it.

        Parameters:
        - name: The crawler name
    """
    # @spec start(any) :: {:ok, String.t()}
    def start(opts) do
        
        :nil
    end



    # @doc """
    #     Generate a dynamic dispatch for the crawler
    # """
    # defmacro gen_default() do

 # end

end