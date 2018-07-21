'use strict';
const NS = 'org.acme.mynetwork';

/**
 * Make DonateData
 * @param {org.acme.mynetwork.Donate} data - the donate
 * @transaction
 */
function Donate(data) {
    const donateData = getFactory()
        .newResource(NS, 'DonateData', data.donateId);

    donateData.money = data.donateMoney;
    donateData.donator = data.donator;
    donateData.campaign = data.campaign;
    donateData.usages = [];

    return getAssetRegistry(NS + '.DonateData').then((registry) => {
        return registry.add(donateData);
    });
}

/**
 * Use DonateData
 * @param {org.acme.mynetwork.UseMoney} data - the usage
 * @transaction
 */
function UseMoney(data) {
    const money = data.money;
    const donateData = data.donateData;
    
    
}