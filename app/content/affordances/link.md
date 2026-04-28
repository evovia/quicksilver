---
title: Link
description: You need buttons in your app. This is how you get them.
published_at: 2026-04-17 11:59:15 UTC
---

## Examples

<%= erbify do %>
  <%= render_previews("link", variant: :affordance) %>
<% end %>

## Implementation

<%= erbify do %>
  ```css
  <%= render_affordance_implementation("link") %>
  ```
<% end %>
