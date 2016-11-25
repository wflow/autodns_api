# AutoDNS api ruby gem
This gem implements a partial api to the InternetX AutoDNS XML http interface.

## Installation

    gem install autodns_api

## Usage Examples

```ruby
client = AutodnsAPI::Client.new(
  url: 'https://gateway.autodns.com/', user: 'user', password: 'password', context: '1'
)
transport = client.transport

# create a handle
response = AutodnsAPI::Contact.create_handle(t, type: 'PERSON', city: 'Trostberg', lname: 'Dent', pcode: '835301', address: 'Street 1')
if response.success?
  puts response.status_object
end

# query handle
response = AutodnsAPI::Contact.by_id(t, response.status_object['value'])
if response.success?
  puts response.all_attributes
end

# query domain
response = AutodnsAPI::Domain.by_name(t, 'webflow.de')
if response.success?
  puts response.all_attributes
end
```

# Further Documentation

Official AutoDNS documentation: https://login.autodns.com/files/downloads/1/adns_schnittstellendokumentation16.0.pdf
