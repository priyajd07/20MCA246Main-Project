from datetime import datetime

from flask import *


from src.dbconnection import *
from datetime import datetime
from web3 import Web3, HTTPProvider
from flask import *


from src.dbconnection import *

app=Flask(__name__)
# from web3 import Web3, HTTPProvider
blockchain_address = 'HTTP://127.0.0.1:7545'
# Client instance to interact with the blockchain
web3 = Web3(HTTPProvider(blockchain_address))
# Set the default account (so we don't need to set the "from" for every transaction call)
web3.eth.defaultAccount = web3.eth.accounts[0]

compiled_contract_path = r'C:\Users\Anjan\Desktop\ONLINE EXAM\online classroom\node_modules\.bin\build\contracts\onlineexamination.json'
# Deployed contract address (see `migrate` command output: `contract address`)
deployed_contract_address = '0x01B387A02AB780515E59F2Ce3f149d28fb4d76Af'




@app.route('/markup',methods=['post'])
def markup():
    eid=request.form['eid']
    lid=request.form['lid']
    print(lid)
    mark=request.form['mark']
    q="INSERT INTO marks VALUES(NULL,%s,%s,%s)"
    val=(lid,eid,mark)
    iud(q,val)
    with open(compiled_contract_path) as file:
        contract_json = json.load(file)  # load contract info as JSON
        contract_abi = contract_json['abi']  # fetch contract's abi - necessary to call its functions
        date = datetime.now().strftime("%Y-%m-%d")
        contract = web3.eth.contract(address=deployed_contract_address, abi=contract_abi)
        blocknumber = web3.eth.get_block_number()
        message2 = contract.functions.report_info(blocknumber + 1, int(eid), int(lid), mark, date).transact()
        print(message2)

    return jsonify({'task': 'success'})



app.run(host='0.0.0.0',port=5001)