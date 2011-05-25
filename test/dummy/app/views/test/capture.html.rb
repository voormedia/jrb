name = capture do
  write params[:name]
end

write "Hello #{name}!"
