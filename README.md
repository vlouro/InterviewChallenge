# InterviewChallenge
 
Foi utilizada a arquitetura MVVM, não foi utilizada nenhuma biblioteca.
Foi desenvolvido com o mínimo da versão 17.4 e Xcode 15.3. 

Após a obtenção do pedido, o json foi guardado no Documents Directory. 
A alternativa que poderia ter sido era era uma base de dados.

Melhorias no código:
- Acrescentar loading nas imagens enquanto não as carregas, bem como o pedido da primeira vez que é lançada a aplicação.
- Dividir o pedido inicial  em paginação onde iria comparar o número actual de produtos que já foi obtido com o total que vem na resposta.