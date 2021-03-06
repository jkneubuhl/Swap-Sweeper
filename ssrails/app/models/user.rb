

class User
  include Mongoid::Document
  
  field :created, :type => DateTime
  field :facebook_object_id, :type => Integer
  field :account_black_balled, :type => Boolean, :default => false
  field :name, :type => String
  embeds_one :session

  validates_uniqueness_of :facebook_object_id
  has_many :offerings
  has_many :bids, :inverse_of => :bidder

  has_many :sent_messages, :class_name => 'Message', :inverse_of => :sender
  has_many :received_messages, :class_name => 'Message', :inverse_of => :receiver

  class << self
    def create_from_facebook_user( facebook_user )
      User.create!( :facebook_object_id => facebook_user['id'], 
                    :name => facebook_user['name'] )
    end
  end

  def unread_messages    
    @unread ||= Message.where( read: false ).and( receiver_id: self.id ).desc( :created_at ) 
  end

  set_callback( :create, :before ) do |document|
    document.created = DateTime.now
  end
  
end
