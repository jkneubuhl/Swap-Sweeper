class Properties
  include Mongoid::Document
  field :category, :type => String
  field :name, :type => String
end
