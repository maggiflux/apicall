require 'uri'
require 'net/http'
require 'json'

def get_data(url)
    url = URI("https://jsonplaceholder.typicode.com/photos")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    response = http.request(request)
    JSON.parse(response.read_body)[0..10]
end

clean_data = get_data("https://jsonplaceholder.typicode.com/photos")

File.open('index.html', 'w') do |f|
    f.puts "<!DOCTYPE html>\n
        <html lang= 'en'>\n
        <head>\n
        <meta charset='UTF-8's>\n
        <meta name='viewport' content='width=device-width, initial-scale=1.0'>\n
        <meta http-equiv='X-UA-Compatible' content='ie=edge'>\n
        <title>Document</title>\n
        </head>\n
        <body>\n"

        clean_data.each do |hash_info|
            f.puts "<img src='#{hash_info['url']}' alt='#{hash_info['title']}'>"
        end
        
        f.puts "\t</body> \n
            </html>"
end

