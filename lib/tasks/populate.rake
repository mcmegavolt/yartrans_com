namespace :db do

  desc "Erase and fill database"
  task :populate => :environment do

    require 'populator'
    require 'faker'
                                                                                                                                                                                                                          
    ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ######  
    ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ######  
    ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ######  
                                                                                                                                                                                                                          
         ##   ##### ###### #### ####  ##     ######  
        ####  ##  ##  ##    ## ##  ## ##     ##      
       ##  ## ##  ##  ##    ## ##     ##     ##      
       ###### #####   ##    ## ##     ##     ####    
       ##  ## ####    ##    ## ##     ##     ##      
       ##  ## ## ##   ##    ## ##  ## ##     ##      
       ##  ## ##  ##  ##   #### ####  ###### ######  
                

    ### First create root category                                                                                                                                                                                                                                                                       
    Article::Category.populate 3 do |cat|
      cat.permalink = Populator.words(1).parameterize
      cat.name = (cat.permalink + ' root cat').titleize
      cat.description = Populator.paragraphs(1)
      cat.position = 0

      ### Create some sub-categories
      Article::Category.populate 2..3 do |subcat|
        subcat.permalink = Populator.words(2).parameterize
        subcat.name = (subcat.permalink + ' sub cat').titleize
        subcat.description = Populator.paragraphs(1)
        subcat.position = 0
        subcat.ancestry = cat.id.to_s

        ### Create some pages for sub-category
        Article::Page.populate 2..4 do |page|
          page.permalink = Populator.words(1..2).parameterize
          page.title = (page.permalink + ' sub page').titleize
          page.body = Populator.paragraphs(3..5)
          page.entry = Populator.paragraphs(1)
          page.published = true
          page.category_id = subcat.id
        end

      end

      ### Create some pages for root category
      Article::Page.populate 1..3 do |page|
        page.permalink = Populator.words(1).parameterize
        page.title = (page.permalink + ' root page').titleize
        page.body = Populator.paragraphs(3..5)
        page.entry = Populator.paragraphs(1)
        page.published = true
        page.category_id = cat.id
      end

    end

    ### Create some static pages
    Article::Page.populate 2 do |static|
      static.permalink = Populator.words(1).parameterize
      static.title = static.permalink.titleize
      static.body = Populator.paragraphs(3..5)
      static.entry = Populator.paragraphs(1)
      static.published = true
    end

    ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ######  
    ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ######  
    ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ######  


       ##  ##  ####  ###### #####   ####   
       ##  ## ##  ## ##     ##  ## ##  ##  
       ##  ## ##     ##     ##  ## ##      
       ##  ##  ####  ####   #####   ####   
       ##  ##     ## ##     ####       ##  
       ##  ## ##  ## ##     ## ##  ##  ##  
        ####   ####  ###### ##  ##  ####   
    
      User.populate 70 do |u|
        u.email = Faker::Internet.email
        u.encrypted_password = '#########'
        Profile.populate 1 do |p|
          p.user_id = u.id
          p.name = Faker::Company.name
          p.personal_id = '1C-' + rand(10 ** 10).to_s.rjust(10,'0')
          p.phone_main = Faker::PhoneNumber.phone_number
          p.phone_alternate = Faker::PhoneNumber.phone_number
        end

        AdmissionApp.populate 10 do |app|
          app.user_id = u.id
          app.barcode = 'BAR-' + rand(10 ** 10).to_s.rjust(10,'0')
          app.expected_date = Time.now + 10.days
          app.notes = Populator.words(2..4)
          app.vehicle = Populator.words(2..4)
          app.cargo_name = Faker::Company.name
          app.code_number = rand(10 ** 10).to_s.rjust(10,'0')
          app.unit_id = [0,1,2,3]
          app.unit_count = 5..40
          app.in_box_count = 5..10
          app.box_count = 5..10
          app.additional_info = Populator.paragraphs(1) 
        end
      end

      User.find_each do |u|
        u.password = 'mcmegavolt'
        if u.id == 1
          p 'if 1 //// USER-ID => ' + u.id.to_s
          u.role_ids = [1]
        elsif u.id == 2
          p 'if 2 //// USER-ID => ' + u.id.to_s
          u.role_ids = [2]
        elsif  u.id == 3
          p 'if 3 //// USER-ID => ' + u.id.to_s
          u.role_ids = [3]
        else
          p 'ELSE //// USER-ID => ' + u.id.to_s
          u.role_ids = [Role.find_by_name('Client').id]
        end
        if u.save
          p 'Saving user ' + u.id.to_s + ' - OK'
        else
          p 'Saving user ' + u.id.to_s + ' - FALSE'
        end
        if u.confirm!
          p 'Confirm user ' + u.id.to_s + ' - OK'
        else
          p 'Confirm user ' + u.id.to_s + ' - Already confirmed!'
        end

      end


         ##    #### ###### #### ##  ## #### ###### #### ###### ####   
        ####  ##  ##  ##    ##  ##  ##  ##    ##    ##  ##    ##  ##  
       ##  ## ##      ##    ##  ##  ##  ##    ##    ##  ##    ##      
       ###### ##      ##    ##  ##  ##  ##    ##    ##  ####   ####   
       ##  ## ##      ##    ##  ##  ##  ##    ##    ##  ##        ##  
       ##  ## ##  ##  ##    ##   ####   ##    ##    ##  ##    ##  ##  
       ##  ##  ####   ##   ####   ##   ####   ##   #### ###### ####   


    ActivityFeed.find_each do |feed|                                                                      
      feed.delete      
    end

    # User.find_each do |u|
    #   Profile.populate 1 do |p|
    #     p.user_id = u.id
    #     p.name = Faker::Company.name
    #     p.personal_id = '1C-' + rand(10 ** 10).to_s.rjust(10,'0')
    #     p.phone_main = Faker::PhoneNumber.phone_number
    #     p.phone_alternate = Faker::PhoneNumber.phone_number
    #   end
    # end
      

    ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ######  
    ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ######  
    ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ######  


    #Category.populate 20 do |category|
    #  category.name = Populator.words(1..3).titleize
    #  Product.populate 10..100 do |product|
    #    product.category_id = category.id
    #    product.name = Populator.words(1..5).titleize
    #    product.description = Populator.sentences(2..10)
    #    product.price = [4.99, 19.95, 100]
    #    product.created_at = 2.years.ago..Time.now
    #  end
    #end


    #Person.populate 100 do |person|
    #  person.name    = Faker::Name.name
    #  person.company = Faker::Company.name
    #  person.email   = Faker::Internet.email
    #  person.phone   = Faker::PhoneNumber.phone_number
    #  person.street  = Faker::Address.street_address
    #  person.city    = Faker::Address.city
    #end

  end
end