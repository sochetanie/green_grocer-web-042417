def consolidate_cart(cart)
  # code here
  result = {}
  cart.each do |x|
    x.each do |key, value|
    if result[key] == nil
      result[key] = value
      result[key][:count] = 1
    else
      result[key][:count] = result[key][:count] + 1
    end
  end
end
  result
end

def apply_coupons(cart, coupons)
  # code here
    coupons.each do |hash|
        result = hash[:item]
        if cart[result] && cart[result][:count] >= hash[:num]
            if cart["#{result} W/COUPON"] == nil
                cart["#{result} W/COUPON"] = {}
                cart["#{result} W/COUPON"][:clearance] = cart["#{hash[:item]}"][:clearance]
                cart["#{result} W/COUPON"][:price] = hash[:cost]
                cart["#{result}"][:count] -= hash[:num]
                cart["#{result} W/COUPON"][:count] = 1
                else
                cart["#{result} W/COUPON"][:count] += 1
                cart["#{result}"][:count] -= hash[:num]
            end
        end
    end
    cart
end


def apply_clearance(cart)
  # code here
  cart.each do |key, value|
    if value[:clearance]
      updated_price = value[:price] * 0.80
      value[:price] = updated_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0
  final_cart.each do |key, value|
    total += value[:price] * value[:count]
  end
  total = total * 0.9 if total > 100
  total
end
