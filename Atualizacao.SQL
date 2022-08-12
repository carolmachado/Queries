select o.Nome as 'Organização', o.DataCadastro as 'Data de cadastro da organização', a.UltimaAtualizacao as 'Última atualização do cardápio',
isnull(( select 'sim' from tbOrganizacoes o where exists (select 1 from tbPedidos p
where p.OrganizacaoId = o.id ) and ativo = 1 and o.Id =a.OrganizacaoId),'não') as RecebeuPedido
from (select OrganizacaoId, max(UltimaAtualizacao) as UltimaAtualizacao from tbProdutos
group by OrganizacaoId) a inner join tbOrganizacoes o on o.Id = a.OrganizacaoId
where o.Ativo = 1

