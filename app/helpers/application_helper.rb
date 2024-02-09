module ApplicationHelper
  def navbar_links
    {
      home: root_path,
      groceries: groceries_path,
      contacts: contacts_path
    }
  end
end
