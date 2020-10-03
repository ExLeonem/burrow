defmodule Burrow.Crawler do
    @behaviour Crawler

    @typedoc """

    """
    @type name :: string


    @doc """
        Starts the crawler. You can pass 

        Parameters:
        - name: The crawler name
    """
    @spec start(any) :: {:ok, pid} | {:error, reason}
    def start(opts), do: {:ok, 2022}

end