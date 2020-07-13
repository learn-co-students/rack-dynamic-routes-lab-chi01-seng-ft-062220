class Application
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
        
        if req.path.match(/items/)
            requested_item = req.path.split("/items/").last
            @@items.find do |item| 
                if item.name == requested_item
                    resp.write "#{item.price}\n"
                else
                    resp.write "Item not found"
                    resp.status = 400
                end
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end

        resp.finish
    end
end
