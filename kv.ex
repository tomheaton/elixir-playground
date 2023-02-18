defmodule KV do
    def start_link do
        Task.start(fn -> loop(%{}) end)
    end

    # defp is a private function
    defp loop(map) do
        receive do
            {:get, key, caller} ->
                send caller, Map.get(map, key)
                loop(map)
            {:put, key, value} ->
                loop(Map.put(map, key, value))
        end
    end
end
