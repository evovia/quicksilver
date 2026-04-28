---
title: Base component
position: 3
---

When you install [Phlex](https://www.phlex.fun/), you get a very basic base class for the rest of your views and/or components to inherit from and where shared logic is placed.

This is the base class, all the Quicksilver components are based on. You can build your own or just copy this.

<%= erbify do %>
```ruby
<%= render_component_implementation("base") %>
```
<% end %>
