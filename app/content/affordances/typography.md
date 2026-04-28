---
title: Typography
description: You probably need to display some text. Bold, thin, small or large. We've got all kinds here.
---

<%= erbify do %>
  <section class="space-y-6 prose">
    <%= render_affordance_previews("typography") %>
  </section>
<% end %>

## Implementation

<%= erbify do %>
  ```css
  <%= render_affordance_implementation("typography") %>
  ```
<% end %>
