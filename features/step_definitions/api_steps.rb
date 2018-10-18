Given(/^I want to get the users$/) do
  @request = 'get'
end

When(/^I send an api GET request$/) do
  if @request == 'get'
    send_get(TestConfig['host'], '/api/users')
  end
end

Then(/^the response is a success$/) do
  p @response.code
  p @response.message
  expect(@response.code).to eq('200')
  expect(@response.message).to eq('OK')
end