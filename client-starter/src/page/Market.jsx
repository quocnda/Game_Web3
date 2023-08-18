import { useEffect, useState } from 'react'
import { ethers } from 'ethers'

// Components
import { Makeitem } from '../components'
import {Navigation} from '../components'
import {Product} from '../components'
import {Section} from '../components'
import { useGlobalContext } from '../context'
import './index.css'

const Market = () =>{


    const { provider_of_coin, account, contract_of_coin, provider, setaccount, contract_of_nft, provider_of_nft, items_of_sold, items, contract_from_market } = useGlobalContext();
    const [item, setitem] = useState(null)
    const [toggle, settoggle] = useState(false)
    const [toggleofMakeitem, settoggleofMakeitem] = useState(false)
    const [items_of_sold_id, setitem_of_sold_id] = useState(0)
    const [item_from_nft, setitem_from_nft] = useState(null)

    const togglePop = (id) => {

        const item_ = items_of_sold[id]
        if (item_ == undefined) {
          console.log("da vao day")
        }
        else {
          const item = items[item_.itemId - 1]
          console.log(item)
          setitem_from_nft(item)
        }
        setitem(item_)
    
        toggle ? settoggle(false) : settoggle(true)
      }
      const togglePopItem = () => {
        toggleofMakeitem ? settoggleofMakeitem(false) : settoggleofMakeitem(true)
      }

    return (
        <div>
            <Navigation account={account}
                contract_of_coin={contract_of_coin}
                provider={provider_of_coin}
                setaccount={setaccount}
                contract_of_nft={contract_of_nft}
                provider_of_nft={provider_of_nft}
                toggle={toggleofMakeitem}
                settoggle={settoggleofMakeitem}
            />
            <h2>Welcome to Dappazon</h2>
            {items && (
                    <Section title={"Clothing and Jewelry"} items_of_sold={items_of_sold} items={items} togglePop={togglePop} setitem_of_sold_id={setitem_of_sold_id} />
            )}
            {toggle &&
                (
                    <Product item_nft={item_from_nft} item={item} items_of_sold={items_of_sold} provider={provider} account={account} dappazon={contract_from_market} togglePop={togglePop} id_of_sold={items_of_sold_id} />
                )
            }
            {
                toggleofMakeitem && (
                    <Makeitem toggle={toggleofMakeitem}
                        settoggle={togglePopItem}
                        contract={contract_from_market}
                        provider={provider}
                    />
                )
            }

        </div>
    );
}

export default Market;