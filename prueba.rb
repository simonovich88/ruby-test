require "uri"
require "net/http"
require 'json'

def request (direccion)
    url = URI(direccion)

    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Cookie"] = "__cfduid=d654d829332eb0904cbace77ce8a144a61594812831"

    response = https.request(request)
    JSON.parse response.read_body


end 

body=request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=TGKawFnr9gokeWINPA0ybpvEMcUhgaEBUD068hml')



a=body['photos'].map{|x| x['img_src']}


def buid_web_page(imagen)

    output = "<html>\n<head>\n</head>\n\t<body>\n<ul>"
    imagen.each do |img|
         output += "\n\t\t\t<li><img src=#{img}></li>"
    end
    output += "\n\t\t<ul>\n\t</body>\n</html>"
    
    File.write('index.html', output)


end


buid_web_page(a)

#nuevo metodo bonus

b=body['photos'].map{|x| x['camera']['name']}



def photos_count(camara)

    new_hast ={}

    array=[]

    camara.each do |i|

        array=  camara.group_by{|i| i}

    end 


    array.each do |k,v|

   new_hast[k]=v.count

   # puts "carama #{k} valor #{v.count}"
    


    end

    print new_hast

end 


photos_count(b)