defmodule ZipBooks do
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.zipbooks.com/v2")

  @token "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjYWxsZXIiOm51bGwsInN1YiI6IjUxNTM1IiwiaXNzIjoiaHR0cHM6XC9cL2FwcC56aXBib29rcy5jb21cL3YyXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU1NjIyNzU2OSwiZXhwIjoxODY3MjY3NTY5LCJuYmYiOjE1NTYyMjc1NjksImp0aSI6ImJkZmYyMWJhLTAwODItNDgxNi1hZDE1LWQ0NzlmN2NmY2VlNiIsInN0ZWFsdGgiOiJmYWxzZSIsInVwZGF0ZWRfYXQiOiIyMDE5LTAzLTI2IDIxOjA3OjEyWiJ9.ACotRw6diNZWplOM_uoamNruA4CA2dlhwnS0UQW6fh4"

  plug(Tesla.Middleware.Headers, [{"authorization", "Bearer #{@token}"}])

  plug(Tesla.Middleware.JSON)

  def create_journal_entry(total, lines) do
    data = %{
      "data" => %{
        "attributes" => %{"name" => "Royalties", "date" => Date.utc_today()},
        "relationships" => %{
          "journal-entry-lines" => %{
            "data" =>
              [create_line(total, "debit", 12630)] ++
                Enum.map(lines, &create_line(&1.amount, "credit", &1.chart_account_id))
          }
        },
        "type" => "journal-entry"
      }
    }

    post("/journal-entries", data, headers: [{"Content-Type", "application/json"}])
  end

  defp create_line(amount, kind, chart_account_id) do
    awal_tag = %{
      "relationships" => %{"taggable" => %{"data" => %{"type" => "contact", "id" => "242934"}}},
      "type" => "tag"
    }

    %{
      "attributes" => %{
        "amount" => amount,
        "kind" => kind
      },
      "relationships" => %{
        "chart-account" => %{
          "data" => %{
            "id" => chart_account_id,
            "type" => "chart-account"
          }
        },
        "tags" => %{
          "data" => [awal_tag]
        }
      },
      "type" => "journal-entry-line"
    }
  end
end
