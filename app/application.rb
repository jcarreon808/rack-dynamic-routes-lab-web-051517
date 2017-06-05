class Application
@@items=[]

  def call(env)
    resp=Rack::Response.new
    req=Rack::Request.new(env)
    if req.path.match(/items/)
      item=req.path.split("/items/").last
      price = get_price(item)
      if price
        resp.write price
        resp.status = 200
      else
        resp.write "Item not found."
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end

  def get_price(search_item)
    response = nil
    @@items.each do |item|
      if item.name == search_item
        response = item.price
      end
    end
    response
  end
end
