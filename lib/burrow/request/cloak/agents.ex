defmodule Burrow.Policy.Cloak.Agents do
    @moduledoc """
        Load use-agents for rotations.

    """
    require Logger


    @doc """
        Load use agents available user agent files.
    """
    def load() do
        agents_path = Path.join([__DIR__, "..", "..", "..", "..", "assets", "agents"])
            |> process_files
            |> combine
            # |> 
    end



    @doc """
        Combine different user-agent files into single one.
    """
    def process_files(agents_path) do
        # file_list = System.ls

    end


    defp aggregate_agents() do
        
    end


    defp combine(file_contents) do
        
    end

end