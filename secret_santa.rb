# $ gem install malone
require "malone"

gifters = [
           {
            name: "Peter Parker",
            email: "spidey@example.com"
           },
           {
            name: "Peter Capaldi",
            email: "imthedoctor@example.com"
           },
           {
            name: "Peter Griffin",
            email: "guy_of_family@example.com"
           },
          ]


gifters   = gifters.shuffle.dup
receivers = gifters.dup.tap { |g| g.push(g.shift) }

gifters.zip(receivers) do |gifter, receiver|
  # Gmail
  # m = Malone.connect(url: "smtp://username%40gmail.com:pass@smtp.gmail.com:587")

  # Mailcatcher (for testing stuff)
  # $ gem install mailcatcher
  # $ mailcatcher
  m = Malone.connect(url: "smtp://me:me@localhost:1025")

  # English
  html = "<p>Hi #{gifter[:name]}</p><p>Your secret santa is: <b>#{receiver[:name]}</b></p>"
  # Spanish
  # html = "<p>Hola #{gifter[:name]}</p> <p> Tu amigo invisible es: <b>#{receiver[:name]}</b> </p>"

  m.deliver(from: "no-reply@example.com",
            to: gifter[:email],
            # English
            subject: "Secret Santa!",
            # Spanish
            #subject: "Amigo Invisible!",
            html: html)

end

puts
puts "Done!"


# >> ["Peter Parker", "Peter Griffin"]
# >> ["Peter Griffin", "Peter Capaldi"]
# >> ["Peter Capaldi", "Peter Parker"]
# >> 
# >> Done!
