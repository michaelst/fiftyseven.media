defmodule FSMWeb.Utils.Controller do
  @sort_regex ~r/(-?)(\S*)/
  @doc false
  def sort(results, %{params: %{"sort" => fields}} = args, controller) do
    fields
    |> String.split(",")
    |> Enum.reduce(results, fn field, acc ->
      case Regex.run(@sort_regex, field) do
        [_, "", field] -> controller.sort(args, acc, field, :asc)
        [_, "-", field] -> controller.sort(args, acc, field, :desc)
      end
    end)
  end

  def sort(results, _args, _controller), do: results

  @doc false
  def filter(results, %{params: %{"filter" => filters}} = args, controller) do
    filters
    |> Map.keys()
    |> Enum.reduce(results, fn k, acc ->
      controller.filter(args, acc, k, filters[k])
    end)
  end

  def filter(results, _args, _controller), do: results
end
