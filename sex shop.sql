create database vlgk

use vlgk

create table Produtos
(
id int identity primary key,
Nome varchar(255),
Fabricante varchar(255),
Quantidade numeric(10,2),
Quantidade_atual numeric(10,2),
VlUnitario numeric(10,2),
tipo varchar(50)
)

insert Produtos values
('LAMBUZE GEL BEIJÁVEL PARA MASSAGEM 50G', 'INTT', 100, 100,20,'Gel'),
('MÁSCARA VERNIZ PRETA MULHER GATO','DOMINATRIXXX',280,200,5.30,'Fantasia'),
('CONJUNTO SUSPIRO EM RENDA ','Patitex', 90,90,19.84,'Vestimenta'),
('ALGEMA DE METAL PELÚCIA REVESTIDA FUR LOVE CUFFS','SEXY IMPORT',50,50,5.90,'brinquedos'),
('SABONETE ÍNTIMO TÉRMICO ESQUENTA E ESFRIA 210ML','SOUL COSMÉTICOS',25,25,12.75,'Sabonetes'),
('TESTO FEMME PERFORMANCE SUPLEMENTO VITAMÍNICO MINERAL 30 COMPRIMIDOS','CIMED',20,20, 22.58 ,'suplemento')

select * from Produtos

create view vwProdutos as
select id as Código,
       nome as Produto,
       Fabricante,
       VlUnitario as Valor_Unitario,
       tipo
from Produtos

select * from vwProdutos

alter view vwProdutos as
select id as Código,
       nome as Produto,
       Fabricante,
       VlUnitario as Valor_Unitario,
       tipo
from Produtos
where VlUnitario > 5.90

create procedure Busca
@CampoBusca varchar(255)
as
select Produto, Valor_Unitario, tipo
from vwProdutos
where Produto = @CampoBusca

execute Busca  'TESTO FEMME PERFORMANCE SUPLEMENTO VITAMÍNICO MINERAL 30 COMPRIMIDOS'

-- TRIGGER
 
create table produtosVendidos
(
Id_venda int identity,
Nome varchar(100),
quantidade_vendida int,
)

create table Historico_de_vendas
(
Nome varchar(100),
quantidadeVendida int,
)


select * from Produtos
select * from produtosVendidos
select * from Historico_de_vendas

create trigger trg_Administracao_de_vendas
on produtosVendidos
for insert
as begin
    declare @produto varchar(255),
            @quantidade int

            select @quantidade = quantidade_vendida,
            @produto = Nome from inserted

            
            update Produtos set
                Quantidade_atual = Quantidade_atual - @quantidade
               where Nome = @produto


            insert Historico_de_vendas
            values(@produto,@quantidade)
    end

    insert produtosVendidos values('TESTO FEMME PERFORMANCE SUPLEMENTO VITAMÍNICO MINERAL 30 COMPRIMIDOS',12)



select * from Produtos
select * from produtosVendidos
select * from Historico_de_vendas
