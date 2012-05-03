class User < ActiveRecord::Base    
  has_and_belongs_to_many :roles
  attr_accessible :name, :realname, :password, :password_confirmation, :role_ids
  has_associated_audits

  name_regex = /^[a-zA-Z0-9_]*$/
  password_regex = /^[a-zA-Z0-9!@#$\%^&*()\-_ ]*$/
    
  validates :name, presence: true, 
                   allow_blank: false, 
                   uniqueness: true, 
                   length: { maximum: 32 },
                   format: { with: name_regex }
  validates :realname, presence: true, 
                       allow_blank: true, 
                       length: { maximum: 64 }
  has_secure_password
  validates :password, on: :create,
                       presence: true,
                       length: { within: 6..32 },
                       format: { with: password_regex }
  
  def find_perm( perm ) 
    ret = false
    roles.each do |role|
      if role.send(perm)
        ret = true
      end
    end
    return ret
  end             
  
  def can_admin_anything?
    return (find_perm "admin_users?" or
            find_perm "admin_schedule?" or
            find_perm "admin_duty_board?" or
            find_perm "admin_radios?")
  end
              
  def can_admin_users?
    find_perm "admin_users?"
  end
                       
  def write_entries?
    find_perm "write_entries?"
  end
  
  def read_hidden_entries?
    find_perm "read_hidden_entries?"
  end

  def add_lost_and_found?
    find_perm "add_lost_and_found?"
  end
  
  def modify_lost_and_found?
    find_perm "modify_lost_and_found?"
  end  
end
