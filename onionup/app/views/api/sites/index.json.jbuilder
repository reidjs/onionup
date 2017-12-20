
json.sites do 
    @sites.each do |site|
        json.set! site.id do
            json.id site.id
            json.url site.url
            json.alias site.alias
            json.ping_ids do
                json.array! [site.pings.last.id]
            end
        end
    end
end
pings = @pings || @sites.map{|site| site.pings.last}
json.pings do 
    pings.flatten.each do |ping|
        json.set! ping.id do
            json.id ping.id
            json.status ping.status
            json.site_id ping.site_id
            json.loaded ping.loaded
            json.loadTime ping.loadTime
            json.responseTime ping.responseTime
            json.created_at ping.created_at
        end
    end
end


