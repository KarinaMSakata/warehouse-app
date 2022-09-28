def login(usuario)
  click_on 'Fazer Login'
  fill_in 'E-mail', with: usuario.email
  fill_in 'Senha', with: usuario.password
  click_on 'Entrar'
end