Section
    * has many events
    * has_many roles through :section_role
    * name: string
  
Role
    * has_many sections through :section_role
  
SectionRole acts as tuple
    * section_id
    * role_id
    * permission (:read, :read_secure, :write)

Event
    * belongs_to section
    * Cancan permissions governed by section_role!
    
User
    * can_read_secure_section?(section)
    * can_write_section?(section)
    * can_read_section?(section)
    