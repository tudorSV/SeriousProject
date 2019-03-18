require 'test_helper'

describe "CompaniesPages" do
  #subject { page }

  describe "page" do
    it { should have_selector('h1',   'All the companies from the database') }
    it { should have_link('Create',    href: 'companies/new') }
    it { should have_link('Home page', href: root_path) }
  end
end
