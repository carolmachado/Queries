
select from tbOrganizacoes o where not exists (select 1 from tbPedidos p where p.OrganizacaoId = o.id)
and ativo = 1