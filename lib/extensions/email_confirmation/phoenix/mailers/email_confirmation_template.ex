defmodule PowEmailConfirmation.Phoenix.Mailer.EmailConfirmationTemplate do
  @moduledoc false
  use Pow.Phoenix.Mailer.Template

  template :mail,
  "Confirm your email address",
  """
  Hi,

  Please use the following link to confirm your e-mail address:

  <%= @url %>
  """,
  """
  <%= content_tag(:h3, "Hi,") %>
  <%= content_tag(:p, "Please use the following link to confirm your e-mail address:") %>
  <%= content_tag(:p, link(@url, to: @url)) %>
  """
end
