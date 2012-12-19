module MyFonts
  module Previewable
    def preview(text="The little brown fox jumps over the lazy dog")
      response = HTTParty.post("http://www.myfonts.com/widgets/testdrive/testdrive-ajax.php",
        query: {
          "seed" => 0,
          "size" => 72,
          "text" => text,
          "fg" => "000000",
          "bg" => "ffffff",
          "src" => "custom",
          "tab" => "desktop",
          "goodies" => "ot.liga",
          "browser[]" => "mac_106_firefox_3_6",
          "w" => "720",
          "i[0]" => url.gsub(/((http:\/\/)?(www\.)?myfonts\.com\/fonts\/)/, "").gsub(/\/$/, "") + ",,720"
        }
      )
      response.body.gsub(/\\/, "")[/src="(.+?)"/, 1]
    end  
  end
end