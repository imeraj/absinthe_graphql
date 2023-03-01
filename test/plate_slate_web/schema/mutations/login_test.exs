defmodule PlateSlateWeb.Schema.Mutations.LoginTest do
  use PlateSlateWeb.ConnCase, async: true

  alias PlateSlate.Fixtures

  @query """
  mutation ($input: LoginInput!) {
    login(input: $input) {
      ... on Session {
    	  token
        user {
          name
        }
      }
    }
  }
  """
  test "creating an employee session", %{conn: conn} do
    user = Fixtures.create_user(%{role: "employee"})

    login_input = %{
      email: user.email,
      password: "super-secret",
      role: String.upcase(user.role)
    }

    response = post(conn, "/api", query: @query, variables: %{"input" => login_input})

    assert %{"data" => %{"login" => %{"token" => token, "user" => user_data}}} =
             json_response(response, 200)

    assert %{"name" => user.name} ==
             user_data

    assert {:ok, %{id: user.id, role: user.role}} ==
             PlateSlateWeb.Authentication.verify(token)
  end
end
