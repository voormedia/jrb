require "builder"

xml = Builder::XmlMarkup.new
xml.greeting "Hello #{params[:name]}!"
xml.target!
