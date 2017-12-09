#Simple test case to hit the tor homepage
require 'test/unit'
require 'net/http'
require 'uri'

$:.unshift "#{File::dirname($0)}/../lib/"
require 'socksify'
require 'socksify/http'

# TCPSocket.socks_server = "127.0.0.1"
# TCPSocket.socks_port = 9050

# Net::HTTP::SOCKSProxy("127.0.0.1", 9050)

def enable_socks
  TCPSocket.socks_server = "127.0.0.1"
  TCPSocket.socks_port = 9050
end

def http_tor_proxy
  Net::HTTP::SOCKSProxy("127.0.0.1", 9050)
end

def check_tor(http_klass = Net::HTTP)
  # enable_socks
  http_tor_proxy
  parse_check_response get_http(http_klass, 'https://check.torproject.org/', 'check.torproject.org')
end

def get_http(http_klass, url, host_header)
  uri = URI(url)
  _get_http(http_klass, uri.scheme, uri.host, uri.port, uri.request_uri, host_header)
end

def _get_http(http_klass, scheme, host, port, path, host_header)
  body = nil
  http_klass.start(host, port,
                   :use_ssl => scheme == 'https',
                   :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
    req = Net::HTTP::Get.new path
    req['Host'] = host_header
    req['User-Agent'] = "ruby-socksify test"
    body = http.request(req).body
  end
  body
end

def parse_check_response(body)
  if body.include? 'This browser is configured to use Tor.'
    p "You are using tor."
    is_tor = true
  elsif body.include? 'You are not using Tor.'
    p "You are not using tor"
    is_tor = false
  else
    raise 'Bogus response'
  end

  if body =~ /Your IP address appears to be:\s*<strong>(\d+\.\d+\.\d+\.\d+)<\/strong>/
    ip = $1
  else
    raise 'Bogus response, no IP'
  end
  [is_tor, ip]
end

is_tor_socks, ip_socks = check_tor
p is_tor_socks
