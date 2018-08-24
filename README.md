블록체인을 활용한 투명한 기부 시스템
==================================
Transparent Donation System Using Block Chain
==================================



### skill
1. aws ec2
2. docker
3. hyperledger fabric
4. node.js

### reference
https://developer.ibm.com/kr/journey/category/blockchain/

1. ~~https://developer.ibm.com/kr/journey/build-a-blockchain-network/~~
2. ~~https://developer.ibm.com/kr/journey/create-and-execute-blockchain-smart-contracts/~~
3. ~~https://developer.ibm.com/kr/journey/automate-business-processes-via-blockchain-events/~~
4. https://developer.ibm.com/kr/journey/integrate-rabbitmq-and-redis-cluster-with-a-blockchain-network/


### data model 

1. asset

DonateData
```
asset DonateData identified by donateId {
    o String donateId
    o Integer money
    o Integer usedMoney
    o MoneyUsage[] usages
    --> Donator donator
    --> Campaign campaign
}
```

MoneyUsage
```
asset MoneyUsage identified by usageId{
    o String usageId
    o Integer money
    o String detail
}
```

2. participant 

Campaign
```
participant Campaign identified by campaignId {
    o String campaignId
    o String title
}
```

Donator
```
participant Donator identified by donatorId {
    o String donatorId
    o String name
}
```

3. transaction

Donate
```
transaction Donate {
    o String donateId
    o Integer donateMoney
    --> Donator donator
    --> Campaign campaign
}
```

UseMoney
```
transaction UseMoney {
    o String usageId
    o Integer money 
    o String detail
    --> DonateData donateData
}
```
