Given(/^I want to get the users$/) do
  @request = 'get'
end

Then(/^the response is a success$/) do
  p @response.code
  p @response.message
  expect(@response.code).to eq('200')
  expect(@response.message).to eq('OK')

end

Given(/^I want to add a user$/) do
  @json = create_user
  @request = 'post'
end

When(/^I send an api request$/) do
  case @request.downcase
    when 'get'
      send_get(TestConfig['host'], '/api/users')
    when 'post'
      send_post(TestConfig['host'], '/api/users', @json)
    when 'put'
      send_put(TestConfig['host'], '/api/users/1', @json)
    when 'get_with _parameters'
      send_get_with_parameters(TestConfig['host'], '/api/users', @parameters)
    else
      raise('Request method not available')
  end
end

Then(/^the user is added$/) do
  p @response.code
  p @response.message
  expect(@response.code).to eq('201')
  expect(JSON.parse(@response.body)['first_name']).to eq(@user.first_name)
  expect(JSON.parse(@response.body)['last_name']).to eq(@user.last_name)
  expect(JSON.parse(@response.body)['createdAt'].to_s[0..9]).to eq(Time.now.to_s[0..9])
  id = JSON.parse(@response.body)['id']
  p "Your User ID is: #{id}"
end

Given(/^I want to update a user$/) do
  @json = update_user
  @request = 'put'
end

And(/^the user is updated$/) do
  response = JSON.parse(@response.body)
  expect(response['first_name']).to eq(@user.first_name)
  expect(response['last_name']).to eq(@user.last_name)
  expect(response['address'][0]['house']).to eq(@user.address[0].house)
  expect(response['updatedAt'].to_s[0..9]).to eq(Time.now.to_s[0..9])

end

Given(/^I want to get the users with parameters$/) do
  @request = 'get_with _parameters'
end

And(/^I want to get "([^"]*)" pages with "([^"]*)" users per page$/) do |page, number_of_users|
  @parameters = "page=#{page}&per_page=#{number_of_users}"
end

And(/^the response displays "([^"]*)" pages with "([^"]*)" users per page$/) do |page, number_of_users|
  response = JSON.parse(@response.body)
  p response['page']
  p response['per_page']
  expect(response['page']).to eq(page.to_i)
  expect(response['per_page']).to eq(number_of_users.to_i)
end