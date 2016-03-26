x Section
    * has many events
    * has_many roles through :section_role
    * name: string
  
x Role
    * has_many sections through :section_role
  
x SectionRole acts as tuple
    * section_id
    * role_id
    * permission (:read, :read_secure, :write)

Event
    *x has_many sections through section_events
    * Cancan permissions governed by section_role!
    * Event CRUD via SectionController so that permissions can be governed.
    
User
    * can_read_secure_section?(section)
    * can_write_section?(section)
    * can_read_section?(section)
    * super_user?
    
    
CURRENT WORK: EventController work to expose available sections