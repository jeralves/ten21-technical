# ten21 technical exercice


Neste cenário a soluçao do cliente tem dois componentes on-premises: uma máquina linux onde está alojada a __base de dados__ e uma máquina linux ondeestá alojado o __front-end da aplicação__ num __contentor__ 

## Planeamento
(o cloud providar a usar será Azure)  
  
### Database server
  
Assumindo que possa ser um servidor SQL e que armazena ids dos utilizadores anónimos e as respostas ao questionário. Pode surgir o problema de ao fim de milhões de inserções, o armazenamento da máquina acabar com um espaço reduzido ou nenhum, e por sua vez o workload intenso causar problemas de disponibilidade. A solução será migrar para _Azure SQL Database_. O serviço oferece capacidades de PaaS, alta disponibilidade e desempenho, e os recursos podem ser alterados dinâmicamente conforme necessidade sem downtime como mencionado [aqui](https://learn.microsoft.com/en-us/azure/azure-sql/database/sql-database-paas-overview?view=azuresql#scalable-performance-and-pools) e [aqui](https://learn.microsoft.com/en-us/azure/azure-sql/database/sql-database-paas-overview?view=azuresql#scalable-performance-and-pools).  

### Assessment  
  
Precisamos de saber se existe algum blocker de migração ou problemas de compatibilidade. Para isso usamos a ferramenta nativa _Azure SQL migration extension for Azure Data Studio_. Com esta ferramenta conseguimos entender a prontidão da base de dados a migrar, e recomendações das configurações para a _Azure SQL Database_.

### _Azure SQL Database_ 

(no caso de não seguir as recomendações automáticas do assessment feito) Tomando as considerações necessárias: o modelo de deployment será a _single database_; o purchasing model será _vCore model_ que permite a opcção de _Azure Hybrid Benefit_ em que ajuda a cobrir os custos das licenças; o service tier será _Business Critical/Premium_ indicado para a situação em questão.  

### WebApp container server  
  
Presumindo que possa ser uma image docker, e esta estar no Docker Hub, pode-se iniciar o serviço _Web App_ , e em _Instance Details_ usar essa mesma imagem. No entanto como a webapp tem milhões de acessos é sensato usar _Kubernetes_, ter várias instâncias da webapp com capacidades de load balancing.  
  
### Virtual Network

Para a kubernets funcionar como intencionado é necessário estar sobre a mesma vnet, e como é uma webapp global, podemos usar as várias regiões com global peering.  
  
### _Azure Traffic Manager_  
  
A nossa webapp tem um alcance global, dai termos de usar um  traffic manager para distribuir os utilizadores dependendo da sua localização no globo. Assim consegue-se configurar os endpoints, estes sendos os resources associados aos IPs das vnets. E associar o domain ao DNS deste manager.    
  
### Arquitectura proposta

![arquitectura proposta](https://i.imgur.com/IDvwVdl.png)  
  
