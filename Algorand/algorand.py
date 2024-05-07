
from algokit_utils.beta.algorand_client import (AlgorandClient, AssetCreateParams, AssetOptInParams, AssetTransferParams, PayParams)

algorand = AlgorandClient.default_local_net()

dispenser = algorand.account.dispenser()

creator = algorand.account.random()

algorand.send.payment(
    PayParams(
        sender= dispenser.address,
        receiver= creator.address,
        amount= 10_000_000_000
    )
)

sent_txn = algorand.send.asset_create(
    AssetCreateParams(
        sender=creator.address,
        total = 33000,
        asset_name= "Hero",
        unit_name="HER"
    )
)

assets_id = sent_txn["confirmation"]["asset-index"]
print(assets_id)
addresses = []
for i in range(0,3):
    addresses.append(algorand.account.random())
    algorand.send.payment(
    PayParams(
        sender= dispenser.address,
        receiver= addresses[i].address,
        amount= 10_000_000
    )
    )

    algorand.send.asset_opt_in(
        AssetOptInParams(
            sender= addresses[i].address,
            asset_id= assets_id
        )
    )

    asset_transfer1 = algorand.send.asset_transfer(
        AssetTransferParams(
            sender= creator.address,
            receiver= addresses[i].address,
            asset_id= assets_id,
            amount= 10,
            last_valid_round=1000
        )
    )

print(algorand.account.get_information(addresses[0].address)["assets"])
print(algorand.account.get_information(addresses[1].address)["assets"])
print(algorand.account.get_information(addresses[2].address)["assets"])