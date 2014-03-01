angular.module('app').service 'collegeRepository', ['apiNameIdRepositoryFactory', (apiNameIdRepositoryFactory) -> 
 repo = new apiNameIdRepositoryFactory() 
 repo.path = '/api/v1/colleges'
 
 repo
]
 