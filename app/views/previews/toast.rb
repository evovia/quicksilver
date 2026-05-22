class Previews::Toast < Previews::Base
  def dismissable
    render UI::Toast.new(dismissable: true, auto_dismiss: false) do
      "The user has been deleted"
    end
  end

  def not_dismissable
    render UI::Toast.new(dismissable: false) do
      "The user has been deleted"
    end
  end

  def auto_dismiss
    render UI::Toast.new(dismissable: true, auto_dismiss: true) do
      "The user has been deleted"
    end
  end

  def with_action
    div class: "space-y-3" do
      render UI::Toast.new(auto_dismiss: false) do |toast|
        toast.action(href: "#", text: "Action")

        "The user has been deleted"
      end
      render UI::Toast.new(auto_dismiss: false, variant: :danger) do |toast|
        toast.action(href: "#", text: "Action")

        "The user has been deleted"
      end
    end
  end

  def variants
    div class: "space-y-3" do
      render UI::Toast.new(auto_dismiss: false) do
        "The user has been deleted"
      end
      render UI::Toast.new(auto_dismiss: false, variant: :danger) do
        "The user has been deleted"
      end
    end
  end

  def with_a_list_of_messages
    render UI::Toast.new(dismissable: true, auto_dismiss: false) do
      ul do
        li { "Message 1" }
        li { "Message 2" }
        li { "Message 3 but this message is very long and it will be interesting to see how the component handles wrapping" }
      end
    end
  end
end
