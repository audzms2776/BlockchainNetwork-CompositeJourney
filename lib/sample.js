// Donate trasaction System
// Modeling: lib/sample.cto
// package name: m-network
// new install and network import

'use strict';
const NS = 'org.acme.mynetwork';

/**
 * Make DonateData
 * @param {org.acme.mynetwork.Donate} data - the donate
 * @transaction
 */
function Donate(data) {
    const donateMoney = data.donateMoney;
    const donator = data.donator;
    const campaign = data.campaign;

    // make DonateData
    const donateData = getFactory()
        .newResource(NS, 'DonateData', data.donateId);

    donateData.money = donateMoney;
    donateData.usedMoney = 0;
    donateData.donator = donator;
    donateData.campaign = campaign;
    donateData.usages = [];

    return getAssetRegistry(NS + '.DonateData').then((registry) => {
        return registry.add(donateData);
    }).then(() => {
        var event = getFactory().newEvent(NS, 'DonateEvent');

        // o Integer donateMoney
        // --> Donator donator
        // --> Campaign campaign
        event.donateMoney = donateMoney;
        event.donator = donator;
        event.campaign = campaign;

        emit(event);
    });
}

/**
 * Use DonateData
 * @param {org.acme.mynetwork.UseMoney} data - the usage
 * @transaction
 */
function UseMoney(data) {
    const usageId = data.usageId;
    const money = data.money;
    const detail = data.detail;
    const donateData = data.donateData;

    // make MoneyUsage
    const usageData = getFactory().newResource(NS, 'MoneyUsage', usageId);
    usageData.usageId = usageId;
    usageData.money = money;
    usageData.detail = detail;

    // Update UsageData into DonateData
    donateData.usedMoney += money;
    donateData.usages.push(usageData);

    return getAssetRegistry(NS + '.MoneyUsage').then((registry) => {
        return registry.add(usageData);
    }).then(() => {
        return getAssetRegistry(NS + '.DonateData');
    }).then((donateDataRegistry) => {
        return donateDataRegistry.update(donateData);
    });
}
