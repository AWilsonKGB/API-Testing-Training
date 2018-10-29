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
    when 'put'
      send_put(TestConfig['host'], '/api/users/2', @json)
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
  expect(JSON.parse(@response.body)['address'][0]['house']).to eq(@user.address[0].house)
  identification = JSON.parse(@response.body)['id']
  p "Your User ID is: #{identification}"
end

Given(/^I want to update a user$/) do
  @json = update_user
  @request = 'put'
end

And(/^the user is updated$/) do
  expect(JSON.parse(@response.body)['first_name']).to eq(@user.first_name)
  expect(JSON.parse(@response.body)['last_name']).to eq(@user.last_name)
  expect(JSON.parse(@response.body)['address'][0]['house']).to eq(@user.address[0].house)
  expect(JSON.parse(@response.body)['updatedAt'].to_s[0..9]).to eq(Time.now.to_s[0..9])
end