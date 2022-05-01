# frozen_string_literal: true

class CustomFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::FormTagHelper

  delegate :tag, :concat, to: :@template

  def field_with_errors(field_name)
    if object.errors[field_name].empty?
      yield
      return
    end

    error_message = object.errors[field_name].to_sentence

    tag.div(class: "with-errors") do
      yield
      concat tag.span(error_message, class: "error-message")
    end
  end

  def base_errors_list
    return if object.errors[:base].none?

    tag.div(class: "billing_info_notification flex w-full p-3
            text-sm rounded my-1 justify-between bg-red-200 text-red-600") do
      tag.ul do
        object.errors[:base].each do |message|
          concat tag.li(message)
        end
      end
    end
  end
end
