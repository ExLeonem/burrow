defmodule Burrow.Coordinator.Progress do
    
    @moduledoc """
        Keep information about already traversed urls.
        Used to filter out already visited urls.
    """

    use GenServer


    @doc """
        Adding another url to the progress.

    """
    def add(pid, url) do
        
    end


    @doc """
        Check if given url already exists.
    """
    def has?(pid, url) do
        
    end




    @impl true
    def init(progress_state) do
        # Check for written out progress file and load if previously exited.
        
        {:ok, progress_state}
    end

    
    @impl true
    def handle_call(:has?, _from, state) do
        {}
    end


    @impl true
    def handle_cast(:add, state) do
        {}
    end



    @impl true
    def terminate(reason, state) do
        # Write out the saved urls
    end
end