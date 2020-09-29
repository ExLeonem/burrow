defmodule Mix.Tasks.Brw.New do
    use Mix.Task

    @shotdoc "Create a crawler burrow."
    def run(_) do
        
        Burrow.hello()
    end

end