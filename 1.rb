require 'gmail'
require 'pry'
require 'json'
require 'csv'
require 'google_drive'


def Operation_on_gmail(mails)
     Gmail.connect('steamcompt@gmail.com', 'Pauline1995') do |gmail|
           puts gmail.logged_in?
   puts mails
             mails.each do |mail|
               puts mail

               email = gmail.compose do
                 to mail
                 subject "Projet THP!"
                 body "Bonjour"
               end
               email.deliver!
             end
       end
end



def save_from_on_GoogleDrive
   session = GoogleDrive::Session.from_config("config.json")
   ws = session.spreadsheet_by_key("1sU6_IqwYkDkgVaj5poEI8U_e-BnyQ1nKZQSnKsDiOrs").worksheets[0]   #cle a changer en fonction du lien url du fichier google drive
   table_of_mails=[]
   #  for i in 1..table_data.length
   #    ws[i, 1] = table_data[i-1][:nom]
   #    ws[i, 2] = table_data[i-1][:url]
   #    ws[i, 3] = table_data[i-1][:email]
   #  end
    puts ws.num_rows
    (1..(ws.num_rows + 1)).each do |row|
       
       table_of_mails << ws[row + 1, 2]
    end
    Operation_on_gmail(table_of_mails)
    ws.save
    ws.reload
end


def perform
  save_from_on_GoogleDrive()

end

perform
