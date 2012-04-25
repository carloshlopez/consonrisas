Given /^I see all the need categories listed$/ do
  page.should have_content('sonrisas')
end

When /^I select the need "([^"]*)"$/ do |arg1|
  page.should have_content(arg1)
end

Then /^I should see all the needs of the category "([^"]*)"$/ do |arg1|
  page.should have_content(arg1)
end

Then /^I should see the number of proyects that have them$/ do
  page.should have_content('proyecto')
end

