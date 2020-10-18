defmodule Burrow.Policy.Etiquette do

    @moduledoc """
        
        Following basic crawler etiqutte.

        - Limit crawling speed (Auto-Throttle)
        - Identify the user
        - Follow robot.rules
        
    """

    
    @doc """
        Read the robots.txt for a given domain and saves.

        looc at base_url/robots.txt.
    """
    def robots(url) do
        :nil
    end


    def identify() do
        :nil
    end


    def auto_throttle() do
        :nil
    end

end