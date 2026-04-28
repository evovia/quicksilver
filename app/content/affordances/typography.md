---
title: Typography
description: You probably need to display some text. Bold, thin, small or large. We've got all kinds here.
---

<%= erbify do %>
  <%= render_previews("typography", variant: :affordance) %>
<% end %>

## Implementation

<%= erbify do %>
  ```css
  <%= render_affordance_implementation("typography") %>
  ```
<% end %>
