class ApplicationController < ActionController::Base
  before_action :set_navbar_links

  def set_navbar_links
    @navbar_links = {
      home: root_path,
      groceries: groceries_path,
      contacts: contacts_path,
    }
  end
end
