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

Given(/^I want to post a user$/) do
  @request = 'post'
  @json = create_user
end

When(/^I send an api request$/) do
  case @request.downcase
    when 'get'
      send_get(TestConfig['host'], '/api/users')
    when 'post'
      send_post(TestConfig['host'], '/api/users', @json)
    else
      raise('Request method not available')
  end
end

Then(/^the user is added$/) do
  p @response.code
  p @response.message
  @user.address[0].city == JSON.parse(@response.body)['address'][0]['city']
  identification = JSON.parse(@response.body)['id']
  p "Your User ID is: #{identification}"
end