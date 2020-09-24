#!/bin/sh
#== DEFINE MODULES ==
#== External ==

#=== Tokens ==
export EXT_TOKEN_DAI=
export EXT_TOKEN_USDC=
export EXT_TOKEN_AKRO=
export EXT_TOKEN_ADEL=

#=== Compound ==
export EXT_COMPOUND_CTOKEN_DAI=
export EXT_COMPOUND_CTOKEN_USDC=
export EXT_COMPOUND_COMPTROLLER=

#=== Curve.Fi ==
export EXT_CURVEFY_Y_DEPOSIT=
export EXT_CURVEFY_Y_REWARDS=
export EXT_CURVEFY_SBTC_DEPOSIT=
export EXT_CURVEFY_SBTC_REWARDS=
export EXT_CURVEFY_SUSD_DEPOSIT=
export EXT_CURVEFY_SUSD_REWARDS=

#== Akropolis ==
export MODULE_POOL=
export MODULE_ACCESS=
export MODULE_SAVINGS=
export MODULE_INVESTING=
export MODULE_STAKING=
export MODULE_STAKING_ADEL=
export MODULE_REWARD=
export PROTOCOL_CURVEFY_Y=
export POOL_TOKEN_CURVEFY_Y=
export PROTOCOL_CURVEFY_SBTC=
export POOL_TOKEN_CURVEFY_SBTC=
export PROTOCOL_CURVEFY_SUSD=
export POOL_TOKEN_CURVEFY_SUSD=
export PROTOCOL_COMPOUND_DAI=
export POOL_TOKEN_COMPOUND_DAI=
export PROTOCOL_COMPOUND_USDC=
export POOL_TOKEN_COMPOUND_USDC=

case "$1" in
#== ACTIONS ==
  show)
        echo npx oz create RewardVestingModule --network rinkeby --init "initialize(address _pool)" --args $MODULE_POOL
        echo npx oz send-tx --to $MODULE_POOL--network rinkeby --method set --args "reward, $MODULE_REWARD, false"
        echo npx oz send-tx --to $MODULE_POOL--network rinkeby --method set --args "akro, $EXT_TOKEN_AKRO, false"
        echo npx oz send-tx --to $MODULE_POOL--network rinkeby --method set --args "adel, $EXT_TOKEN_ADEL, false"
        ;;
  show2)
        echo npx oz create InvestingModule --network rinkeby --init "initialize(address _pool)" --args $MODULE_POOL
        echo npx oz send-tx --to $MODULE_POOL--network rinkeby --method set --args "investing, $MODULE_INVESTING, false"
        ;;
  init)
        echo INIT PROJECT, ADD CONTRACTS
        #npx oz init
        npx oz add Pool AccessModule SavingsModule StakingPool
        npx oz add CompoundProtocol_DAI PoolToken_Compound_DAI
        npx oz add CompoundProtocol_USDC PoolToken_Compound_USDC
        #npx oz add CurveFiProtocol_Y PoolToken_CurveFiY
        #npx oz add CurveFiProtocol_SBTC PoolToken_CurveFi_SBTC
        npx oz add CurveFiProtocol_SUSD PoolToken_CurveFi_SUSD
        ;;

  createPool)
        echo CREATE POOL
        npx oz create Pool --network rinkeby --init
        ;;

  createModules)
        echo CREATE MODULES
        npx oz create AccessModule --network rinkeby --init "initialize(address _pool)" --args $MODULE_POOL
        npx oz create SavingsModule --network rinkeby --init "initialize(address _pool)" --args $MODULE_POOL
        npx oz create StakingPool --network rinkeby --init "initialize(address _pool,address _stakingToken, uint256 _defaultLockInDuration)" --args "$MODULE_POOL, $EXT_TOKEN_AKRO, 0"
        npx oz create StakingPoolADEL --network rinkeby --init "initialize(address _pool,address _stakingToken, uint256 _defaultLockInDuration)" --args "$MODULE_POOL, $EXT_TOKEN_ADEL, 0"
        npx oz create RewardVestingModule --network rinkeby --init "initialize(address _pool)" --args $MODULE_POOL
        echo CREATE PROTOCOLS AND TOKENS
        echo CREATE Compound DAI
        npx oz create CompoundProtocol_DAI --network rinkeby --init "initialize(address _pool, address _token, address _cToken, address _comptroller)" --args "$MODULE_POOL, $EXT_TOKEN_DAI, $EXT_COMPOUND_CTOKEN_DAI, $EXT_COMPOUND_COMPTROLLER"
        npx oz create PoolToken_Compound_DAI --network rinkeby --init "initialize(address _pool)" --args $MODULE_POOL
        echo CREATE Compound USDC
        npx oz create CompoundProtocol_USDC --network rinkeby --init "initialize(address _pool, address _token, address _cToken, address _comptroller)" --args "$MODULE_POOL, $EXT_TOKEN_USDC, $EXT_COMPOUND_CTOKEN_USDC, $EXT_COMPOUND_COMPTROLLER"
        npx oz create PoolToken_Compound_USDC --network rinkeby --init "initialize(address _pool)" --args $MODULE_POOL
        echo CREATE Curve.Fi Y
        npx oz create CurveFiProtocol_Y --network rinkeby --init "initialize(address _pool)" --args $MODULE_POOL
        npx oz create PoolToken_CurveFi_Y --network rinkeby --init "initialize(address _pool)" --args $MODULE_POOL
        #echo CREATE Curve.Fi SBTC
        #npx oz create CurveFiProtocol_SBTC --network rinkeby --init "initialize(address _pool)" --args $MODULE_POOL
        #npx oz create PoolToken_CurveFi_SBTC --network rinkeby --init "initialize(address _pool)" --args $MODULE_POOL
        echo CREATE Curve.Fi SUSD
        npx oz create CurveFiProtocol_SUSD --network rinkeby --init "initialize(address _pool)" --args $MODULE_POOL
        npx oz create PoolToken_CurveFi_SUSD --network rinkeby --init "initialize(address _pool)" --args $MODULE_POOL
        ;;

  addModules)
        echo SETUP POOL: FOR ALL MODULES set
        npx oz send-tx --to $MODULE_POOL--network rinkeby --method set --args "access, $MODULE_ACCESS, false"
        npx oz send-tx --to $MODULE_POOL--network rinkeby --method set --args "savings, $MODULE_SAVINGS, false"
        npx oz send-tx --to $MODULE_POOL--network rinkeby --method set --args "staking, $MODULE_STAKING, false"
        npx oz send-tx --to $MODULE_POOL--network rinkeby --method set --args "stakingAdel, $MODULE_STAKING_ADEL, false"
        npx oz send-tx --to $MODULE_POOL--network rinkeby --method set --args "reward, $MODULE_REWARD, false"
        npx oz send-tx --to $MODULE_POOL--network rinkeby --method set --args "akro, $EXT_TOKEN_AKRO, false"
        npx oz send-tx --to $MODULE_POOL--network rinkeby --method set --args "adel, $EXT_TOKEN_ADEL, false"
        ;;

  setupProtocols)
        echo SETUP OTHER CONTRACTS
        #npx oz send-tx --to $PROTOCOL_CURVEFY_Y--network rinkeby --method setCurveFi --args "$EXT_CURVEFY_Y_DEPOSIT, $EXT_CURVEFY_Y_REWARDS"
        #npx oz send-tx --to $PROTOCOL_CURVEFY_SBTC--network rinkeby --method setCurveFi --args "$EXT_CURVEFY_SBTC_DEPOSIT, $EXT_CURVEFY_SBTC_REWARDS"
        npx oz send-tx --to $PROTOCOL_CURVEFY_SUSD--network rinkeby --method setCurveFi --args "$EXT_CURVEFY_SUSD_DEPOSIT, $EXT_CURVEFY_SUSD_REWARDS"
        ;;

  addProtocols)
        echo ADD PROTOCOLS
        npx oz send-tx --to $MODULE_SAVINGS--network rinkeby --method registerProtocol --args "$PROTOCOL_COMPOUND_DAI, $POOL_TOKEN_COMPOUND_DAI"
        npx oz send-tx --to $MODULE_SAVINGS--network rinkeby --method registerProtocol --args "$PROTOCOL_COMPOUND_USDC, $POOL_TOKEN_COMPOUND_USDC"
        #npx oz send-tx --to $MODULE_SAVINGS--network rinkeby --method registerProtocol --args "$PROTOCOL_CURVEFY_Y, $POOL_TOKEN_CURVEFY_Y"
        #npx oz send-tx --to $MODULE_SAVINGS--network rinkeby --method registerProtocol --args "$PROTOCOL_CURVEFY_SBTC, $POOL_TOKEN_CURVEFY_SBTC"
        npx oz send-tx --to $MODULE_SAVINGS--network rinkeby --method registerProtocol --args "$PROTOCOL_CURVEFY_SUSD, $POOL_TOKEN_CURVEFY_SUSD"
        ;;

  setupOperators)
        echo SETUP OPERATORS FOR PROTOCOLS
        npx oz send-tx --to $PROTOCOL_COMPOUND_DAI--network rinkeby --method addDefiOperator --args $MODULE_SAVINGS
        npx oz send-tx --to $PROTOCOL_COMPOUND_USDC--network rinkeby --method addDefiOperator --args $MODULE_SAVINGS
        #npx oz send-tx --to $PROTOCOL_CURVEFY_Y--network rinkeby --method addDefiOperator --args $MODULE_SAVINGS
        #npx oz send-tx --to $PROTOCOL_CURVEFY_SBTC--network rinkeby --method addDefiOperator --args $MODULE_SAVINGS
        npx oz send-tx --to $PROTOCOL_CURVEFY_SUSD--network rinkeby --method addDefiOperator --args $MODULE_SAVINGS
        echo SETUP MINTERS FOR POOL TOKENS
        npx oz send-tx --to $POOL_TOKEN_COMPOUND_DAI--network rinkeby --method addMinter --args $MODULE_SAVINGS
        npx oz send-tx --to $POOL_TOKEN_COMPOUND_USDC--network rinkeby --method addMinter --args $MODULE_SAVINGS
        #npx oz send-tx --to $POOL_TOKEN_CURVEFY_Y--network rinkeby --method addMinter --args $MODULE_SAVINGS
        #npx oz send-tx --to $POOL_TOKEN_CURVEFY_SBTC--network rinkeby --method addMinter --args $MODULE_SAVINGS
        npx oz send-tx --to $POOL_TOKEN_CURVEFY_SUSD--network rinkeby --method addMinter --args $MODULE_SAVINGS
        ;;
      *)
        echo "need command"
esac


echo DONE

