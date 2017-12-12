json.sites do 
    @sites.each do |site|
        json.set! site.id do
            json.id site.id
            json.url site.url
            json.ping_ids do
                json.array! site.pings.map{|ping| ping.id}
            end
        end
    end
end
pings = @sites.map{|site| site.pings}
json.pings do 
    pings.flatten.each do |ping|
        json.set! ping.id do
            json.status ping.status
            json.site_id ping.site_id
            json.created_at ping.created_at
        end
    end
end
