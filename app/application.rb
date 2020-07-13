class Application
    attr_accessor :item
    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
        if req.path.match(/items/)
            search_term = req.path.split('/items/').last
            if @@items.any?{|item| item.name == search_term}
                item = @@items.find{|i| i.name = search_term}
                resp.write "#{item.price.to_s}"
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end
end