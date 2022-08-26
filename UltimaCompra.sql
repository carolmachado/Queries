select c.Nome, max( f.[DATA]) from [NOTAS FISCAIS] f
inner join [TABELA DE CLIENTES] c on c.CPF = f.CPF
where c.CPF = 50534475787 and [data] = '2018'
group by c.NOME, [Data]
