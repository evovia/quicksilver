---
name: Accordion
description: For folding stuff in and out. Or that music that is always used when Tour de France is on TV.
published_at: 2026-04-17 14:04:35 UTC
---

# Accordion

<%= erbify do %>
  <%= render UI::Accordion.new do |accordion| 
    accordion.item(heading: "Item 1") do
      content_tag :p do
        "Content 1"
      end
    end
    accordion.item(heading: "Item 2") do
      content_tag :p do
        "Content 2"
      end
    end
  end %>
<% end %>
