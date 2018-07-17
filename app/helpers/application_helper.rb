module ApplicationHelper
  def less_ugly_decimal number
    "%.#{number.truncate.to_s.size + 2}g" % number
  end
end
