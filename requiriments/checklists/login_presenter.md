# Login Presenter

## Regras
1. Chamar Validation ao alterar o email
2. Notificar o emailErrorStream com o mesmo erro do Validation, caso retorne erro
3. Notificar o emailErrorStream com null, caso o Validation não retorne erro
4. Não notificar o emailErrorStream se o valor for igual ao último
5. Notificar o isFormValidStream após alterar o email
6. Chamar Validation ao alterar senha
7. Notificar o passwordErrorStream com o mesmo erro do Validation, caso retorne erro
8. Notificar o passwordErrorStream com null, caso o Validation não retorne erro
9. Não notificar o passwordErrorStream se o valor for igual ao último
10. Notificar o isFormValidStream após alterar o senha
11. Para o formulário estar válido todos os Streams de erro precisam estar null e todos os campos obrigatórios preenchidos
12. Não notificar o isFormValidStream se os valores forem iguais aos ultimos
13. Chamar Authentication com email e senha corretos
14. Notificar o isLoadingStream com true antes de chamar o Authentication
15. Notificar o isLoadingStream com false ao fim do Authentication
16. Nofificar o mainError caso o Authentication retornar uma DomainError
17. Fechar todos os Streams no dispose
18. ⛔️ Gravar o Account no cache em caso de sucesso
19. ⛔️ Levar o Usuário para tela de enquetes em caso de sucesso