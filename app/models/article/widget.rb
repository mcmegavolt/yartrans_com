class Article::Widget < ActiveRecord::Base
  attr_accessible :body, :name, :widgetable_id, :widgetable_type
  belongs_to :widgetable, :polymorphic => true
end
