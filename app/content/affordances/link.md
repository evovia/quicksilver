---
title: Link
description: You need buttons in your app. This is how you get them.
published_at: 2026-04-17 11:59:15 UTC
---

## Examples

<%= erbify do %>
  <section class="space-y-6 prose">
    <%= render_affordance_previews("link") %>
  </section>
<% end %>

## Implementation

<%= erbify do %>
  ```css
  <%= render_affordance_implementation("link") %>
  ```
<% end %>
