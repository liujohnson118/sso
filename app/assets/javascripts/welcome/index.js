$(document).ready(function(){
    $(function(){
        function addBitcoinPricesData(data){
            if(data == []){
                return;
            }
            let bitcoinPricesTable = $('#bitcoin-prices-table').DataTable();
            Object.entries(data).forEach(function(currencyData){
                let timeData = currencyData[1];
                bitcoinPricesTable.row.add([currencyData[0], (timeData['24h'] || 'Unknown'),(timeData['7d'] || 'Unknown'),
                    (timeData['30d'] || 'Unknown')]).draw(false);
            })
        }
        $.getJSON('/welcome/bitcoin_prices.json', addBitcoinPricesData);
    })
})
