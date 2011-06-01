Shoes.app :title => 'Twitter Update', :width => 400, :height => 50 do
  @text = edit_line :width => 310
  button "Tweet" do
    puts %x{~/scripts/twitter-client.rb --tweet "#{@text.text}"}
    exit
  end
end
