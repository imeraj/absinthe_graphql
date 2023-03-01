defmodule PlateSlateWeb.SessionController do
  use PlateSlateWeb, :controller

  use Absinthe.Phoenix.Controller, schema: PlateSlateWeb.Schema, action: [mode: :internal]

  def new(conn, _) do
    render(conn, "new.html")
  end

  @graphql """
  mutation ($email: String!, $password: String!) {
    login(input: {
      email: $email,
      password: $password,
      role: EMPLOYEE
    })
  }
  """
  def create(conn, %{data: %{login: result}}) do
    case result do
      %{user: employee} ->
        conn
        |> put_session(:employee_id, employee.id)
        |> put_flash(:info, "Login successful")
        |> redirect(to: "/admin/items")

      _ ->
        conn
        |> put_flash(:error, "Email or password incorrect")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> clear_session()
    |> redirect(to: "/admin/session/new")
  end
end
