
test_user = User.create!(
  email: "test@test.com",
  password: "123456",
  password_confirmation: "123456",
  username: "TestUser"
)

# Posts exemplo
10.times do |i|
  test_user.posts.create!(
    title: "Post número #{i + 1}",
    content: "Conteúdo de exemplo para o post #{i + 1}"
  )
end

puts "Seeds executadas com sucesso!"