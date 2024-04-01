# reMind


### FEATURES


1. ✅ Boxes
    - ✅ Listar as boxes;
    - ✅ Contar o número de termos;
    - ✅ Contar o número de termos pendentes de revisão; 
    - ✅ Criar nova box;
    
    
2. ✅ NewBox(Create e Update)
    - ✅ Input: nome (50), palavras chave (150), descrição (150) e tema;
    - ✅ UUID, data de criação
    - ✅ Lógica da data lastReview
    
    
3. ✅ Box
    - ✅ Listar termos;
    - ✅ Pesquisa de termos;
    - ✅ Pesquisa de boxes;
    - ✅ Contar o número de termos pendentes de revisão; 
    - ✅ Editar Box;
    - ✅ Adicionar novo termo; 
    - ✅ Ir para o Swipper;
    - ✅ Editar termo; 
    - ✅ Deletar termo.
     
     
4. NewTerm(Create e Update)
    - ✅ Input: termo (50), significado (150);
    - ✅ UUID, data de criação, data da próxima revisão, box UUID;
    - Revisão: 1 dia, 2 dias, 3 dias, 5 dias, 7 dias, 14 dias, 30 dias;
    - ✅ "Save and Add New" - Para facilitar a adição de novos termos;
        *  ✅ Salvar os dados preenchidos; 
        *  ✅ Limpar os campos;
        *  ✅ Permanecer na tela.
        
        
5. ✅ Swipper
    - ✅ Exibir o termo e significado (tap);
    - ✅ Contar o número de termos pendentes de revisão;
    - ✅ Swipe para a esquerda = ainda estou aprendendo este termo;
    - ✅ Swipe para a direita = eu lembro deste termo;
    - ✅ Finalizar a revisão antes de visualizar todos os termos; 
    *  ✅ Botão que inicia todas as revisões;
    *  ✅ Iniciar uma única revisão
    
    
6. ✅ Swipper Report
    - ✅ Listar todos os termos revisados;
    - ✅ Ao clicar em um termo, a row se expande e o significado é exibido;
        
        
* MISC
    *  ✅ versionamento Git/GitHub;
    *  ✅ commits semânticos;
    *  ✅ JSON para criar boxes e termos instantaneamente;
    *  ✅ Botões na Sheet de criar Box, criados pelo JSON de boxes;
    *  ✅ Long press to delete boxes.
