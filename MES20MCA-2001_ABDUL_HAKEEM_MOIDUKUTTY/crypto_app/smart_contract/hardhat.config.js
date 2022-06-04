// https://eth-rinkeby.alchemyapi.io/v2/cD6uvb6_Jop5truPEdKAFM5wvd_NvGcB

require ('@nomiclabs/hardhat-waffle');

module.exports = {
  solidity: '0.8.0',
  network:{
    rinkeby:{
      url:'https://eth-rinkeby.alchemyapi.io/v2/cD6uvb6_Jop5truPEdKAFM5wvd_NvGcB',
      accounts: [ '2b82cfffb6b6571235b14ac584c7b99d9c549015b76baa59d0c4ebf94eaa64b3' ]
    }
  }
}