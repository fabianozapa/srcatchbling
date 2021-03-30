user = User.new(
  role: 'admin',
  name: 'Admin',
  email: 'admin@admin.com',
  password: '123456',
  encrypted_password: '$2a$12$51FhAA.QK6ONzOynqacBQ.HTaKWXm2hRppSaLrqjFsnZsC5GcbE3O',
)
user.save!
