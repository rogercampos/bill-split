module ApplicationHelper
  def amount_badge(amount)
    if amount < 0
      tag.span amount.abs.round(2), class: 'px-2 py-1 text-green-600 bg-green-100 border-green-700 rounded-full'
    else
      tag.span amount.round(2), class: 'px-2 py-1 text-orange-600 bg-orange-100 border-orange-700 rounded-full'
    end
  end

  def person_badge(name)
    tag.span name, class: 'px-2 py-1 text-gray-600 bg-gray-200 border-gray-700 rounded-full'
  end
end
