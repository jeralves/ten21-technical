# ten21 technical exercice


Neste cenário a soluçao do cliente tem dois componentes on-premises: uma máquina linux onde está alojada a __base de dados__ e uma máquina linux ondeestá alojado o __front-end da aplicação__ num __contentor__; 

## Estratégia    
(na seguinte estratégia de migração o cloud provider será Azure)

### Database server
  
Assumindo que possa ser um servidor SQL e que armazena ids dos utilizadores anónimos e as respostas ao questionário. Pode surgir o problema de ao fim de milhões de inserções, o armazenamento da máquina acabar com um espaço reduzido ou nenhum, e por sua vez o workload intenso causar problemas de disponibilidade. A solução será migrar para _Azure SQL Database_. O serviço oferece capacidades de PaaS, alta disponibilidade e desempenho, e os recursos podem ser alterados dinâmicamente conforme necessidade sem downtime como mencionado [aqui](https://learn.microsoft.com/en-us/azure/azure-sql/database/sql-database-paas-overview?view=azuresql#scalable-performance-and-pools) e [aqui](https://learn.microsoft.com/en-us/azure/azure-sql/database/sql-database-paas-overview?view=azuresql#scalable-performance-and-pools).  
  
### Database server to _Azure SQL Database_    
  
Tomando as devidas considerações: o modelo de deployment será a _single database_; o purchasing model será _vCore model_ que permite a opcção de _Azure Hybrid Benefit_ em que ajuda a cobrir os custos das licenças; o service tier será _Business Critical/Premium service tier_ indicado para a situação em questão.
