module ApplicationHelper
  def navbar_links
    links = {
      home: root_path,
      groceries: groceries_path,
      contacts: contacts_path
    }
    return links unless current_user&.admin?

    links[:users] = admin_users_path
    links[:contacts] = admin_contact_requests_path
    links
  end
end
