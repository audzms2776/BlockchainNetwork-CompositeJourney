const NS = 'org.acme.mynetwork';

/**
 * Make an Offer for a ProductListing
 * @param {org.acme.mynetwork.Donate} data - the offer
 * @transaction
 */
function Donate(data) {
    const donateData = getFactory()
        .newResource(NS, 'DonateData', data.donateId);

    donateData.donateMoney = data.donateMoney;
    donateData.donator = data.donator;
    donateData.campaign = data.campaign;

    return getAssetRegistry(NS + '.DonateData').then(function (registry) {
        return registry.add(donateData);
    });
}
