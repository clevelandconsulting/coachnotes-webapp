angular.module('app').service 'playerRepository', ['apiNameIdRepositoryFactory', (apiNameIdRepositoryFactory) -> 
 repo = new apiNameIdRepositoryFactory() 
 repo.path = '/api/v1/players'
 
 repo
]
 