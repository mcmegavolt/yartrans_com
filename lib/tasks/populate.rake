namespace :db do

  desc "Erase and fill database"
  task :populate => :environment do

    require 'populator'
    require 'faker'

    Article::Category.populate 4 do |cat|
      cat.permalink = Populator.words(1..2).parameterize
      cat.name = cat.permalink.titleize
      cat.description = Populator.paragraphs(1)
      cat.position = 0

      Article::Page.populate 6 do |page|
        page.permalink = Populator.words(2..3).parameterize
        page.title = page.permalink.titleize
        page.body = Populator.paragraphs(3..5)
        page.entry = Populator.paragraphs(1)
        page.published = true
        page.category_id = cat.id
      end
    end

    Article::Page.populate 2 do |static|
      static.permalink = Populator.words(1).parameterize
      static.title = static.permalink.titleize
      static.body = Populator.paragraphs(3..5)
      static.entry = Populator.paragraphs(1)
      static.published = true
    end

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